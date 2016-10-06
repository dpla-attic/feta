module Feta
  ##
  # Descriptive Metadata for OriginalRecord
  class OriginalRecordMetadata < ActiveTriples::Resource
    include Feta::LDP::RdfSource

    configure base_uri: 'http://record_container.example'

    property :created, predicate: RDF::DC.created
    property :modified, predicate: RDF::DC.modified
    property :hasFormat, predicate: RDF::DC.hasFormat
    property :wasGeneratedBy, predicate: RDF::PROV.wasGeneratedBy
  end
end