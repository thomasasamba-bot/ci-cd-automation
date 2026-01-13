require_relative 'config/environment'
require 'json'

class LambdaHandler
  def self.process(event:, context:)
    Rails.logger.info("Processing SQS Event: #{event.inspect}")
    
    records = event['Records'] || []
    records.each do |record|
      begin
        process_record(record)
      rescue => e
        Rails.logger.error("Failed to process record #{record['messageId']}: #{e.message}")
        # Raising error triggers SQS retry/DLQ logic
        raise e 
      end
    end

    { statusCode: 200, body: JSON.generate({ status: 'success', processed_count: records.size }) }
  end

  def self.process_record(record)
    body = record['body']
    Rails.logger.info("Message Body: #{body}")
    
    # Example: Parse JSON body if applicable
    # payload = JSON.parse(body)
    # Perform business logic here
  end
end
