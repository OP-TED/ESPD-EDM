#!/usr/bin/env node
//
// Version check for ESPD-EDM.
//
// Every place in this repository that states a version has to agree with every
// other one. The check reads the files as a consumer would, with nothing but
// Node itself - no npm install, no exporter - so it can run on every commit no
// matter how the commit was made: by the export automation, by the validation
// publication, or by hand.
//
// What it checks:
//   codelists/codelists.json   espdVersion / ublVersion present and well formed;
//                              no duplicate ids; canonical (source, id) order;
//                              lists exactly the .gc files in the folder
//   codelists/*.gc             <Version> matches the index; ESPD-maintained
//                              lists carry the ESPD version in <Version>,
//                              <CanonicalVersionUri> and <LocationUri>
//   schemas/schemas.json       every UBL schema is at the index's ublVersion
//   README.md                  the Version badge
//   CHANGELOG.md               the release notes heading
//   VERSION                    if present
//
// The reference version is, in order: EXPECTED_VERSION if set; the X.Y.Z of a
// release/X.Y.Z branch (the pull request base on a pull request); otherwise
// the espdVersion declared in codelists.json, which still makes every other
// statement agree with it.
//
// Usage: node .github/scripts/check-versions.mjs [repository root]
// Exit codes: 0 consistent, 1 inconsistent.

import fs from 'node:fs'
import path from 'node:path'

const ROOT = path.resolve(process.argv[2] ?? '.')

// Same spelling rules as the exporter: 5.0.0, 5.0.0-beta, 5.0.0-alpha.2.
const ESPD_VERSION = /^\d+\.\d+\.\d+(?:-[0-9A-Za-z.-]+)?$/
const UBL_VERSION = /^\d+\.\d+$/
const ESPD_SOURCE = 'espd'

const problems = []
const report = (message) => problems.push(message)

const inGitHubActions = process.env.GITHUB_ACTIONS === 'true'

const fileOf = (relative) => path.join(ROOT, relative)
const exists = (relative) => fs.existsSync(fileOf(relative))
const read = (relative) => fs.readFileSync(fileOf(relative), 'utf-8')

const readJson = (relative) => {
  if (!exists(relative)) {
    report(`${relative} does not exist`)
    return null
  }
  try {
    return JSON.parse(read(relative))
  } catch (error) {
    report(`${relative} is not valid JSON: ${error.message}`)
    return null
  }
}

const byCodeUnit = (a, b) => (a < b ? -1 : a > b ? 1 : 0)

// --- reference version --------------------------------------------------------

const releaseVersionOf = (branch) => /^release\/(.+)$/.exec(branch ?? '')?.[1] ?? null

const resolveExpectedVersion = () => {
  if (process.env.EXPECTED_VERSION) {
    return { version: process.env.EXPECTED_VERSION, origin: 'EXPECTED_VERSION' }
  }
  // On a pull request the content is about to land on the base branch, so the
  // base decides which version it has to be.
  const branch = process.env.GITHUB_EVENT_NAME === 'pull_request'
    ? process.env.GITHUB_BASE_REF
    : process.env.GITHUB_REF_NAME
  const fromBranch = releaseVersionOf(branch)
  return fromBranch ? { version: fromBranch, origin: `branch ${branch}` } : null
}

// --- genericode ---------------------------------------------------------------

// Only the <Identification> block matters here, and it has a fixed, flat shape,
// so a regular expression is enough and keeps the check free of dependencies.
const readIdentification = (relative) => {
  const xml = read(relative)
  const block = /<Identification>([\s\S]*?)<\/Identification>/.exec(xml)?.[1]
  if (!block) return null
  const first = (tag) =>
    new RegExp(`<${tag}(?:\\s[^>]*)?>([^<]*)</${tag}>`).exec(block)?.[1]?.trim() ?? null
  return {
    shortName: first('ShortName'),
    version: first('Version'),
    canonicalVersionUri: first('CanonicalVersionUri'),
    locationUri: first('LocationUri'),
  }
}

// "v5.0.0" as a whole path segment, so v5.0.0 does not satisfy 5.0.0-beta.
const carriesVersionSegment = (uri, version) => {
  const escaped = version.replace(/[.*+?^${}()|[\]\\]/g, '\\$&')
  return new RegExp(`/v${escaped}(?:/|$)`).test(uri)
}

// --- checks -------------------------------------------------------------------

const checkCodeLists = (reference) => {
  const index = readJson('codelists/codelists.json')
  if (!index) return

  const { espdVersion, ublVersion, codelists } = index

  if (!espdVersion) {
    report('codelists/codelists.json has no espdVersion')
  } else if (!ESPD_VERSION.test(espdVersion)) {
    report(`codelists/codelists.json espdVersion "${espdVersion}" is not a major.minor.patch version`)
  } else if (espdVersion !== reference) {
    report(`codelists/codelists.json espdVersion is "${espdVersion}", expected "${reference}"`)
  }

  if (!ublVersion) {
    report('codelists/codelists.json has no ublVersion')
  } else if (!UBL_VERSION.test(ublVersion)) {
    report(`codelists/codelists.json ublVersion "${ublVersion}" is not a major.minor version`)
  }

  if (!Array.isArray(codelists) || codelists.length === 0) {
    report('codelists/codelists.json lists no code lists')
    return { ublVersion }
  }

  const counts = new Map()
  codelists.forEach(({ id }) => counts.set(id, (counts.get(id) ?? 0) + 1))
  ;[...counts].filter(([, n]) => n > 1)
    .forEach(([id, n]) => report(`codelists/codelists.json lists "${id}" ${n} times`))

  const actual = codelists.map(c => `${c.source}/${c.id}`)
  const canonical = [...codelists]
    .sort((a, b) => byCodeUnit(a.source, b.source) || byCodeUnit(a.id, b.id))
    .map(c => `${c.source}/${c.id}`)
  const firstOut = actual.findIndex((entry, i) => entry !== canonical[i])
  if (firstOut !== -1) {
    report(
      `codelists/codelists.json is not in (source, id) order: entry ${firstOut + 1} is ` +
      `"${actual[firstOut]}", expected "${canonical[firstOut]}"`)
  }

  const onDisk = fs.readdirSync(fileOf('codelists')).filter(name => name.endsWith('.gc'))
  const indexed = new Set(codelists.map(c => `${c.id}.gc`))
  onDisk.filter(name => !indexed.has(name))
    .forEach(name => report(`codelists/${name} is not listed in codelists/codelists.json`))

  codelists.forEach(entry => {
    const relative = `codelists/${entry.id}.gc`
    if (!exists(relative)) {
      report(`codelists/codelists.json lists "${entry.id}" but ${relative} does not exist`)
      return
    }

    const id = readIdentification(relative)
    if (!id) {
      report(`${relative} has no <Identification> block`)
      return
    }

    if (id.shortName !== entry.id) {
      report(`${relative} declares <ShortName> "${id.shortName}", its index id is "${entry.id}"`)
    }
    if (!id.version) {
      report(`${relative} has an empty <Version>`)
    } else if (id.version !== String(entry.version)) {
      report(`${relative} declares <Version> "${id.version}", codelists.json records "${entry.version}"`)
    }

    // ESPD-maintained lists are versioned with the model. External ones carry
    // their EU Vocabularies publication date and are only held to the index.
    if (entry.source !== ESPD_SOURCE) return

    if (id.version && id.version !== reference) {
      report(`${relative} is ESPD-maintained and declares <Version> "${id.version}", expected "${reference}"`)
    }
    for (const [tag, uri] of [['CanonicalVersionUri', id.canonicalVersionUri], ['LocationUri', id.locationUri]]) {
      if (!uri) {
        report(`${relative} has an empty <${tag}>`)
      } else if (!carriesVersionSegment(uri, reference)) {
        report(`${relative} <${tag}> "${uri}" does not point at v${reference}`)
      }
    }
  })

  return { ublVersion }
}

const checkSchemas = (ublVersion) => {
  const index = readJson('schemas/schemas.json')
  if (!index) return

  const ubl = (index.schemas ?? []).filter(schema => schema.standard === 'UBL')
  if (ubl.length === 0) {
    report('schemas/schemas.json lists no UBL schemas')
    return
  }

  ubl.filter(schema => ublVersion && String(schema.version) !== String(ublVersion))
    .forEach(schema => report(
      `schemas/schemas.json has UBL ${schema.name} at "${schema.version}", ` +
      `codelists.json says ublVersion "${ublVersion}"`))

  ubl.filter(schema => !exists(`schemas/${schema.filename}`))
    .forEach(schema => report(`schemas/schemas.json lists schemas/${schema.filename}, which does not exist`))
}

// shields.io escapes "-" in a badge as "--": Version-5.0.0--beta-orange.svg.
const checkReadmeBadge = (reference) => {
  if (!exists('README.md')) return report('README.md does not exist')
  const match = /img\.shields\.io\/badge\/Version-((?:[^-]|--)+)-[A-Za-z]+\.svg/.exec(read('README.md'))
  if (!match) return report('README.md has no Version badge (img.shields.io/badge/Version-...)')
  const badge = match[1].replace(/--/g, '-')
  if (badge !== reference) report(`README.md Version badge says "${badge}", expected "${reference}"`)
}

const checkChangelog = (reference) => {
  if (!exists('CHANGELOG.md')) return report('CHANGELOG.md does not exist')
  const heading = read('CHANGELOG.md').split(/\r?\n/).find(line => /^#\s/.test(line))
  if (!heading) return report('CHANGELOG.md has no heading')
  const match = /^#\s+ESPD-EDM\s+(\S+)\s+Release Notes\s*$/.exec(heading)
  if (!match) return report(`CHANGELOG.md heading "${heading}" is not "# ESPD-EDM <version> Release Notes"`)
  if (match[1] !== reference) report(`CHANGELOG.md heading says "${match[1]}", expected "${reference}"`)
}

const checkVersionFile = (reference) => {
  if (!exists('VERSION')) return
  const declared = read('VERSION').trim()
  if (declared !== reference) report(`VERSION says "${declared}", expected "${reference}"`)
}

// --- main ---------------------------------------------------------------------

const main = () => {
  const expected = resolveExpectedVersion()
  const declared = readJson('codelists/codelists.json')?.espdVersion ?? null

  if (expected && !ESPD_VERSION.test(expected.version)) {
    report(`the expected version "${expected.version}" (from ${expected.origin}) is not a major.minor.patch version`)
  }

  const reference = expected?.version ?? declared
  console.log(`Repository: ${ROOT}`)
  console.log(expected
    ? `Expected version: ${expected.version} (from ${expected.origin})`
    : `Expected version: ${declared ?? '(none)'} (from codelists/codelists.json - not a release branch)`)

  if (reference) {
    const { ublVersion } = checkCodeLists(reference) ?? {}
    checkSchemas(ublVersion)
    checkReadmeBadge(reference)
    checkChangelog(reference)
    checkVersionFile(reference)
  } else {
    report('no version to check against: codelists/codelists.json declares none and this is not a release branch')
  }

  if (problems.length > 0) {
    console.log(`\n✗ ${problems.length} version problem(s):`)
    problems.forEach(p => console.log(inGitHubActions ? `::error::${p}` : `  - ${p}`))
    process.exit(1)
  }

  console.log(`\n✓ All versions agree on ${reference}`)
}

main()
