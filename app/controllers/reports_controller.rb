class ReportsController < ApplicationController
  include AuthorizationHelper

  autocomplete :user, :name
  helper :submitted_content
  include ReportFormatterHelper

  # reports are allowed to be viewed by  only by TA, instructor and administrator
  def action_allowed?
    current_user_has_ta_privileges?
  end

  def response_report
    # ACS Removed the if condition(and corresponding else) which differentiate assignments as team and individual assignments
    # to treat all assignments as team assignments
    @type = params.key?(:report) ? params[:report][:type] : 'basic'
    # From the ReportFormatterHelper module
    send(@type.underscore, params, session)
    @user_pastebins = UserPastebin.get_current_user_pastebin current_user
  end

  # function to export specific headers to the csv
  def self.export_details_fields(detail_options)
    fields = []
    fields << 'Name' if detail_options['name'] == 'true'
    fields << 'UnityID' if detail_options['unity_id'] == 'true'
    fields << 'EmailID' if detail_options['email'] == 'true'
    fields << 'Grade' if detail_options['grade'] == 'true'
    fields << 'Comment' if detail_options['comment'] == 'true'
    fields
  end

  # function to check for detail_options and return the correct csv
  def self.export_details(csv, _parent_id, detail_options)
    return csv unless detail_options
  end
  
  def llm_evaluation_report(params, session)
    assignment_id = params[:id]
    @assignment = Assignment.find(assignment_id)
    @llm_response_data = LlmEvaluationService.call(params)
  end
  
  
  # def llm_evaluation_report(params, session)
  #   assignment_id = params[:id]
  #   @assignment = Assignment.find(assignment_id)
  #   @userid = session[:user].id
  #   @type = 'LLMEvaluationReport'

  #   # Use same logic as regular review report
  #   response_maps_with_distinct_participant_id =
  #     ResponseMap.select('DISTINCT reviewer_id')
  #               .where('reviewed_object_id = ? and type = ? and calibrate_to = ?', assignment_id, 'ReviewResponseMap', 0)

  #   @reviewers = response_maps_with_distinct_participant_id.map do |map|
  #     ReviewResponseMap.get_reviewer_with_id(assignment_id, map.reviewer_id)
  #   end

  #   # Sort reviewers for display
  #   @reviewers = if @assignment.team_reviewing_enabled
  #                 Team.sort_by_name(@reviewers)
  #               else
  #                 Participant.sort_by_name(@reviewers)
  #               end
    
  #   @user_pastebins = UserPastebin.get_current_user_pastebin current_user

  #   render 'response_report'
  # end
  # def llm_evaluation_report(params, session)
  #   assignment_id = params[:id].to_i
  #   @assignment = Assignment.find(assignment_id)
  
  #   @type = 'LLMEvaluationReport' # used in response_report.html.haml to select partial
  
  #   # Use the same logic as the review report to get reviewer info and response maps
  #   @reviewers = ReviewResponseMap.final_versions_from_reviewer(assignment_id, nil).keys.map do |symbol|
  #     # Get each round's reviewers
  #     ReviewResponseMap.where(reviewed_object_id: assignment_id).map(&:reviewer)
  #   end.flatten.uniq
  
  #   @assignment_questionnaire = AssignmentQuestionnaire.where(assignment_id: assignment_id).first
  
  #   # You can even reuse the logic of building team scores or metrics
  #   @review_volume_metrics = {}
  #   @reviewers.each do |reviewer|
  #     @review_volume_metrics[reviewer.id] = Response.volume_of_review_comments(assignment_id, reviewer.id)
  #   end
  # end
  

end



