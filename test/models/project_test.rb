# == Schema Information
#
# Table name: projects
#
#  id           :bigint(8)        not null, primary key
#  name         :string
#  description  :text
#  repositories :text
#  features     :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  match_id     :bigint(8)
#  team_id      :bigint(8)
#

require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  setup do
    @project = projects(:simple_project)
  end
  
  test 'Project belongs to a team' do
    team = teams(:team2)
    assert_equal(@project, team.project)
    assert_equal(team, @project.team)
  end
  
  test 'Project belongs to a match' do
    match = matches(:content_match)
    assert_equal(match, @project.match)
    assert_equal(@project, match.projects.first)
  end

  test 'Project can have many users through team' do
    user1 = users(:user_test2)
    user2 = users(:user_test3)

    assert_equal(@project.users.first, user1)
    assert_equal(@project.users.last, user2)
    assert_equal(user1.project, @project)
  end
end
