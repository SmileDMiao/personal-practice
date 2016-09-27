module Searchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model

    after_commit on: [:create] do
      SearchIndexerJob.perform_later('index', self.class.name, self.id)
    end

    after_commit on: [:update] do
      SearchIndexerJob.perform_later('update', self.class.name, self.id)
    end

    after_commit on: [:destroy] do
      SearchIndexerJob.perform_later('delete', self.class.name, self.id)
    end

  end
end
