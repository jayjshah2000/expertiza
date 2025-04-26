# app/services/llm_evaluation_service.rb
class LlmEvaluationService
    def self.call(params)
      # Later: Build request payload from actual data
  
      # For now: Return dummy structured data
      {
        reviewers: [
          {
            reviewer_id: 1,
            reviewer_name: "John Doe",
            unity_id: "jdoe",
            reviews_done: "2/3",
            reviewed_teams: [
              { team_name: "Team1", reviewed: true, score_awarded: 85, average_score: 80 },
              { team_name: "Team2", reviewed: false, score_awarded: nil, average_score: nil }
            ],
            metrics: "35 words",
            review_grade: {
              grade_for_reviewer: 90,
              comment_for_reviewer: "Good effort!"
            }
          },
          {
            reviewer_id: 2,
            reviewer_name: "Jane Smith",
            unity_id: "jsmith",
            reviews_done: "3/3",
            reviewed_teams: [
              { team_name: "Team3", reviewed: true, score_awarded: 95, average_score: 93 },
              { team_name: "Team4", reviewed: true, score_awarded: 90, average_score: 89 }
            ],
            metrics: "42 words",
            review_grade: {
              grade_for_reviewer: 88,
              comment_for_reviewer: "Detailed feedback."
            }
          }
        ]
      }
    end
  end
  