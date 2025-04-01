import { ATTRIBUTE, INHERITANCE, RELATIONSHIP, INSTANCE_OF } from './const.js'

function dbToJson ({ objects, objectProperties, attributes, connectors }) {

  const nodeIndex = {}
  for (const { Object_ID, Name } of objects) {
    nodeIndex[Object_ID] = Name
  }

  const nodesToExclude = [
    'Package',
    'ProxyConnector',
    'Note',
    'Text',
    'Datatype']
  // const toInclude = ['Class', 'Enumeration', 'Object']

  const nodes = objects.filter(x => !nodesToExclude.includes(x.Object_Type)).
    map(({ Object_ID, Note, Object_Type, Classifier }) => {

      const result = {
        eaId: Object_ID,
        name: nodeIndex[Object_ID], description: Note, type: Object_Type,
        tags: objectProperties.filter(x => x.Object_ID === Object_ID).
          map(x => {
            return {
              property: x.Property, value: x.Value,
            }
          })
      }
      // Objects might come with a Classifier,
      // i.e. (EU) 2015/1986 instance of at-voc:legal-basis
      if (Object_Type === 'Object') {
        result.instanceOf = nodeIndex[Classifier]
      }

      return result
    })

  // Do not export enum values (need to be analyzed)
  // at-voc-new:ResponseStatus sh:in ("Accepted" "Rejected" ... )
  // Should they move to skos:inScheme?
  const includeAttribute = (x) => !(!x.Type && x.Stereotype === 'enum')

  // Do not export NoteLinks
  const includeConnector = (x) => !(!x.Start_Object_ID || x.Connector_Type ===
    'NoteLink')

  const edges = [
    ...attributes.filter(includeAttribute).map(toLiteralRelation(nodeIndex)),
    ...connectors.filter(includeConnector).map(toObjectRelation(nodeIndex))]
  return { nodes, edges }
}

const toLiteralRelation = nodeIndex => x => {
  const { Object_ID, Name, Type, LowerBound, UpperBound, Notes, Stereotype, Default } = x

  const source = nodeIndex[Object_ID]
  const predicate = Name
  const target = Type
  const default_value = Default

  return {
    eaId: Object_ID,
    type: ATTRIBUTE,
    source,
    predicate,
    target,
    quantifiers: getQuantifierFromBounds({ LowerBound, UpperBound }),
    description: Notes,
    default_value
  }
}

const toObjectRelation = nodeIndex => x => {
  const {
    Connector_ID,
    DestRole,
    Start_Object_ID,
    End_Object_ID,
    Connector_Type,
    Direction,
    DestCard,
    Notes,
  } = x

  const source = nodeIndex[Start_Object_ID]

  const type = Connector_Type

  const knownPredicates = {
    [INSTANCE_OF]: 'skos:inScheme', [INHERITANCE]: 'rdfs:subClassOf',
  }

  const predicate = DestRole || knownPredicates[type]

  const target = nodeIndex[End_Object_ID]

  if (Direction !== 'Source -> Destination') { // Apparently this is not taken into account
    // console.log(domain, predicate, range)
  }
  if (Direction !== 'Bi-Directional') { // Apparently this is not taken into account
    // console.log('Bidirectional',domain, predicate, range)
    // If we find some instance of this, apply inverses.
    // :relatesTo owl:inverseOf :isRelatedTo .
  }
  return {
    eaId: Connector_ID,
    type,
    source,
    predicate,
    target,
    quantifiers: getQuantifierFromString(DestCard),
    description: Notes,
  }
}

function getQuantifierFromBounds ({ LowerBound, UpperBound }) {

  return !(LowerBound || UpperBound) ? {
    quantifiersDeclared: false,
  } : {
    min: LowerBound,
    max: UpperBound === '*' ? undefined : UpperBound,
    quantifiersDeclared: true,
  }
}

function getQuantifierFromString (str) {
  const raw = { quantifiersDeclared: true, raw: str }
  if (str === '0..1') {
    return { min: 0, max: 1, ...raw }
  } else if (str === '1') {
    return { min: 1, max: 1, ...raw }
  } else if (str === '1..*') {
    return { min: 1, ...raw }
  } else if (str === '0..*') {
    return raw
  } else return {
    quantifiersDeclared: false,
  }
}

export { dbToJson }