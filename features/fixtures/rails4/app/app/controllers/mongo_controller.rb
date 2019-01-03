class MongoController < ApplicationController

  def success_crash
    doc = MongoModel.create(string_field: "String")
    doc.save
    "Statement".prepnd("Failing")
  end

  def get_crash
    MongoModel.where(string_field: true)
    "Statement".prepnd("Failing")
  end

  def failure_crash
    begin
      Mongoid::Clients.default.database.command(:bogus => 1)
    rescue
    end

    "Statement".prepnd("Failing")
  end
end
