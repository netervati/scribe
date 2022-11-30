# frozen_string_literal: true
# typed: strict

require 'json'
require 'sorbet-runtime'

module Helpers
  # Handles file operations
  class FileHandler
    extend T::Sig

    sig { void }
    def self.create_project_directory
      Dir.mkdir('project') unless Dir.exist?('project')
    end

    sig { params(project_name: String).void }
    def self.create_project_file(project_name)
      file = File.new("./project/#{project_name}.json", 'w')

      file.puts(JSON.dump({ name: project_name, list: [] }))

      file.close
    end

    sig { params(file_name: String).returns(T::Boolean) }
    def self.project_exist?(file_name)
      exists = T.let(false, T::Boolean)

      Dir['project/**/*.json'].each do |file|
        exists = true if file.gsub('project/', '').gsub('.json', '') == file_name.split[2]
      end

      exists
    end

    sig { params(file_name: String).returns(T::Hash[T.untyped, T.untyped]) }
    def self.read_project_contents(file_name)
      file = File.open("./project/#{file_name}.json")

      contents = file.read

      file.close

      JSON.parse(contents).transform_keys(&:to_sym)
    end

    sig { params(file_name: String, content: T::Hash[T.untyped, T.untyped]).returns(NilClass) }
    def self.update_project_contents(file_name, content)
      file = File.open("./project/#{file_name}.json", 'w')

      file.puts(JSON.dump(content))

      file.close
    end
  end
end
