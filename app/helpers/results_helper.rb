module ResultsHelper

  def result_statuses
    Result.statuses.keys
  end
  
end
