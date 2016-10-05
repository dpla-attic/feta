module Feta
  ##
  # Descriptive Metadata for OriginalRecord
  class OriginalRecordMetadata < ActiveTriples::Resource
    include Feta::LDP::RdfSource

    configure base_uri: Feta::Settings.marmotta.record_container

    property :created, predicate: RDF::DC.created
    property :modified, predicate: RDF::DC.modified
    property :hasFormat, predicate: RDF::DC.hasFormat
    property :wasGeneratedBy, predicate: RDF::PROV.wasGeneratedBy
  end
end