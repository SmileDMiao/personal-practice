module Searchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model

    after_commit on: [:create] do
      SearchIndexerWorker.perform_async('index', self.class.name, self.id)
    end

    after_commit on: [:update] do
      SearchIndexerWorker.perform_async('update', self.class.name, self.id)
    end

    after_commit on: [:destroy] do
      SearchIndexerWorker.perform_async('delete', self.class.name, self.id)
    end

  end
end
