# ESPD model

Generated. Do not hand-edit: this folder is rebuilt from the EA model and the enrichment
sources by `espd-tools/model-compiler` and replaced as a whole.

It is the implementer-neutral model that sits beside the criterion structure
(`../criterion/espd-edm.json`): for each modeled criterion, the shape of the data an
implementation stores and the mapping of that data to and from the UBL documents. For the
administrative parts (I, II, VI), which are not criteria, it also holds the schema, mapping and form.

ESPD version 5.0.0, UBL 2.4. 62 criteria, 21 value types, 6 sections of the administrative parts.

## Status

This is the first publication of the model, with ESPD-EDM 5.0.0. It is a contract between the
ESPD-EDM and the implementations that use it: the instance-data schemas fix the JSON shape in which an
implementation stores an ESPD, and the mapping specs fix how that shape maps to the UBL Request and
Response. Two things to be aware of:

- **Compatibility policy.** What counts as a breaking change to the instance-data shape or the mappings,
  and how a change is signalled, has not been decided by the ESPD-EDM owners. The format of
  `compiled-model.json` is versioned (`envelopeVersion`, currently 1). Until a policy exists, pin
  the version of ESPD-EDM you build on (a tag or commit) and compare the hashes in `compiled-model.json`
  to see whether the model changed.
- **Provisional registries.** A registry carries `status` and `statusNote`. `confirmed` records a decision (for
  example `registries/roles.json`: the exclusion categories are mandatory for both buyer types). `provisional`
  means it is still under review and must not be read as normative. These registries are provisional now:
  - `registries/scheme-agency-profile.json`: Provisional, pending review by the ESPD profile owners: the agency per identifier scheme (VAT to VIES, LEI to GLEIF, DUNS to D&B) and especially the default OP for identifiers without a scheme field are a pragmatic policy that satisfies BR-OTH-02 (the attribute must be present and non-empty). A change affects the values of @schemeAgencyID in generated XML, not the structure of the model. Do not treat these values as normative.

Known limitations of the mapping specs, found by round-tripping every published example through them:

- a numeric `QUANTITY` answer comes back as a string (`slc-stand-ratio`);
- a buyer `URL` requirement is not written to the Request (`slc-suit-reg-trade`);
- the branching criterion `slc-stand-other` loses requirement leaves, gains extra array items and returns
  a rating as a string.

## Layout

| Path | Content |
| --- | --- |
| `compiled-model.json` | The manifest: versions, provenance, and an inventory of every criterion, value type and administrative part with its files. Validated by `schema/compiled-model.schema.json`. Start here. |
| `instance-data/<key>.schema.json`, `<key>.example.json` | JSON Schema (draft 2020-12) and a minimal valid example of the instance data for one criterion. 124 files. |
| `xml-mapping/<key>.request.mapping.json`, `<key>.response.mapping.json` | Declarative specs that map the instance data to and from the UBL ESPD Request and Response. 124 files. |
| `compiled/<key>.json` | The criterion as compiled from the EA structure plus the enrichment (structure, semantic ids, instance bindings, value types) with its constraint hints. Lets an implementation derive its own layers, such as a form, without the EA export. 62 files. |
| `parts/<part>/index.json`, `section<L>.schema.json`, `.example.json`, `.mapping.json`, `.form.json` | The administrative parts (I, II, VI), which are not criteria: for each section the instance-data schema, an example, the UBL mapping, and the form (fields, input types, labels, code lists). Authored in the enrichment and published verbatim. 6 sections. |
| `registries/` | The shared registries: value types (JSON shape and UBL bindings), the XML encoding profile, fixed code list attribute sets, the scheme-agency policy, the roles, the codelist governance, and the vocabulary of form affordances (UI hints). |
| `schema/` | JSON Schema of `compiled-model.json`. |

`<key>` is the criterion's output identity and the file stem of all its files. Most criteria use
their EA code (for example `slc-stand-to-gen`); the Part II and V "other" criteria use
`ot-<id>` (for example `ot-eo-size`), which keeps their identity stable.

## Using the model

1. Read `compiled-model.json`. It lists every criterion with its files, the ESPD and UBL versions, and the
   registries.
2. Store a user's answers as the instance data a criterion's `instance-data/<key>.schema.json` describes.
   The `.example.json` next to it is a valid instance. The administrative parts have their own schemas
   under `parts/`. Together they form one flat document: `{ partI, partII, ..., partVI }`.
3. Turn instance data into a UBL Request or Response, and back, with the `xml-mapping/<key>` specs and
   the `parts/<part>/section<L>.mapping.json` specs. The specs are declarative: you need an engine that
   runs them. [espd-demo](https://github.com/OP-TED/espd-demo) contains one (`model/mapping-engine`) and a
   round-trip test over every published example.
4. Build the user interface from `compiled/<key>.json` (structure, value types, constraint hints) and, for
   the administrative parts, from the `parts/<part>/section<L>.form.json` files. Labels and layout of the
   criteria are yours; the translations are not part of this model.
5. Validate the resulting XML with the files in `../validation`.

## Where it comes from, and how to change it

```
EA model (espd-conceptual-model)  --export-->  criterion/espd-edm.json  --+
                                                                          +--> espd-tools/model-compiler --> model/
enrichment/ (espd-conceptual-model)  -------------------------------------+
```

The structure comes from the EA model. Everything else (semantic ids, instance bindings, value types, UBL
bindings, roles, the administrative parts) is authored in `espd-conceptual-model/enrichment`. The workflow
"Export & publish to ESPD-EDM" in that repository runs the compiler and replaces this folder as a whole, so a
criterion removed from the model does not linger. A change belongs there, not here: a hand edit is
overwritten by the next publication and reported by the verification below.

## Verifying

```
node verify.mjs --model <ESPD-EDM/model> --edm <ESPD-EDM/criterion/espd-edm.json>
```

(`verify.mjs` is in `espd-tools/model-compiler`.) It checks that `compiled-model.json` conforms to its schema,
that every file it lists exists, that no file is unlisted (stale or hand-added), and that the model was built
from the structure export in the same commit.

## Provenance

`compiled-model.json` records the SHA-256 of the exact structure export and of the enrichment
sources the model was built from, so the same inputs can be recognised and a stale model detected.
The hashes are taken over text with line endings normalised to LF.

## What is not here

The form of the criteria (layout, grouping, labels, translations) is the concern of each
implementation and is not part of this model. The forms of the administrative parts are, because
every implementation has to fill in the same Part I, II and VI.
