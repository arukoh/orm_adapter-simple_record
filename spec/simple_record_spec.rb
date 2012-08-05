require 'spec_helper'
require 'example_app_shared'
require 'models'

if !defined?(SimpleRecord::Base)
  puts "** require 'simple_record' to run the specs in #{__FILE__}"
  exit 1
end

logger = Logger.new($stdout)
logger.level = Logger::ERROR
SimpleRecord.establish_connection( ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_ACCESS_KEY'], :logger => logger)

module SimpleRecordOrmSpec
  # here be the specs!
  describe SimpleRecord::Base::OrmAdapter do
    before do
      User.destroy_all
      Note.destroy_all
    end
  
    it_should_behave_like "example app with orm_adapter" do
      let(:user_class) { User }
      let(:note_class) { Note }
    end
  end
end
