# ESPD model

Generated. Do not hand-edit: this folder is rebuilt from the EA model and the enrichment
sources by `espd-tools/model-compiler` and replaced as a whole.

It is the implementer-neutral model that sits beside the criterion structure
(`../criterion/espd-edm.json`): for each modeled criterion, the shape of the data an
implementation stores and the mapping of that data to and from the UBL documents.

ESPD version 5.0.0, UBL 2.4. 62 criteria, 21 value types.

## Layout

| Path | Content |
| --- | --- |
| `compiled-model.json` | The manifest: versions, provenance, and an inventory of every criterion and value type with its files. Validated by `schema/compiled-model.schema.json`. Start here. |
| `instance-data/<key>.schema.json`, `<key>.example.json` | JSON Schema (draft 2020-12) and a minimal valid example of the instance data for one criterion. 124 files. |
| `xml-mapping/<key>.request.mapping.json`, `<key>.response.mapping.json` | Declarative specs that map the instance data to and from the UBL ESPD Request and Response. 124 files. |
| `compiled/<key>.json` | The criterion as compiled from the EA structure plus the enrichment (structure, semantic ids, instance bindings, value types) with its constraint hints. Lets an implementation derive its own layers, such as a form, without the EA export. 62 files. |
| `registries/` | The shared registries: value types (JSON shape and UBL bindings), the XML encoding profile, fixed code list attribute sets, the scheme-agency policy, the roles, and the codelist governance. |
| `schema/` | JSON Schema of `compiled-model.json`. |

`<key>` is the criterion's output identity and the file stem of all its files. Most criteria use
their EA code (for example `slc-stand-to-gen`); the Part II and V "other" criteria use
`ot-<id>` (for example `ot-eo-size`), which keeps their identity stable.

## Provenance

`compiled-model.json` records the SHA-256 of the exact structure export and of the enrichment
sources the model was built from, so the same inputs can be recognised and a stale model detected.
The hashes are taken over text with line endings normalised to LF.

## What is not here

Presentation (form layout, UI types, labels, translations) is the concern of each implementation
and is not part of this model.
