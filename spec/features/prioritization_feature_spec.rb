require 'rails_helper'

feature 'Prioritization' do

  before :each do
    @t1 = Task.create(description: 'Task A')
    @t2 = Task.create(description: 'Task B')
    @t3 = Task.create(description: 'Task C')
  end

  describe 'Prioritization' do
    it 'lets me compare A and B' do
      visit '/tasks'

      click_on I18n.t('tasks.prioritize')

      # By importance
      # First comparison - A/B
      within '.progress-bar' do
        expect(page).to have_content('0%')
      end

      within 'h1' do
        expect(page).to have_content('important')
      end

      within '#choice_left' do
        within 'h2' do
          expect(page).to have_content('Task A')
        end
        expect(page).to have_button I18n.t('comparisons.choose')
      end

      within '#choice_right' do
        within 'h2' do
          expect(page).to have_content('Task B')
        end
        expect(page).to have_button I18n.t('comparisons.choose')
      end

      within('#choice_left') do
        click_button I18n.t('comparisons.choose')
      end

      # next comparison A/C
      within '.progress-bar' do
        expect(page).to have_content('17%')
      end

      within 'h1' do
        expect(page).to have_content('important')
      end

      within '#choice_left' do
        within 'h2' do
          expect(page).to have_content('Task A')
        end
        expect(page).to have_button I18n.t('comparisons.choose')
      end

      within '#choice_right' do
        within 'h2' do
          expect(page).to have_content('Task C')
        end
        expect(page).to have_button I18n.t('comparisons.choose')
      end

      within('#choice_left') do
        click_button I18n.t('comparisons.choose')
      end

      # next comparison – B/C
      within 'h1' do
        expect(page).to have_content('important')
      end

      within '.progress-bar' do
        expect(page).to have_content('33%')
      end

      within '#choice_left' do
        within 'h2' do
          expect(page).to have_content('Task B')
        end
        expect(page).to have_button I18n.t('comparisons.choose')
      end

      within '#choice_right' do
        within 'h2' do
          expect(page).to have_content('Task C')
        end
        expect(page).to have_button I18n.t('comparisons.choose')
      end

      within('#choice_left') do
        click_button I18n.t('comparisons.choose')
      end

      # By urgency
      # First comparison - A/B
      within '.progress-bar' do
        expect(page).to have_content('50%')
      end

      within 'h1' do
        expect(page).to have_content('urgent')
      end

      within '#choice_left' do
        within 'h2' do
          expect(page).to have_content('Task A')
        end
        expect(page).to have_button I18n.t('comparisons.choose')
      end

      within '#choice_right' do
        within 'h2' do
          expect(page).to have_content('Task B')
        end
        expect(page).to have_button I18n.t('comparisons.choose')
      end

      within('#choice_left') do
        click_button I18n.t('comparisons.choose')
      end

      # next comparison A/C
      within '.progress-bar' do
        expect(page).to have_content('67%')
      end

      within 'h1' do
        expect(page).to have_content('urgent')
      end

      within '#choice_left' do
        within 'h2' do
          expect(page).to have_content('Task A')
        end
        expect(page).to have_button I18n.t('comparisons.choose')
      end

      within '#choice_right' do
        within 'h2' do
          expect(page).to have_content('Task C')
        end
        expect(page).to have_button I18n.t('comparisons.choose')
      end

      within('#choice_left') do
        click_button I18n.t('comparisons.choose')
      end

      # next comparison – B/C
      within 'h1' do
        expect(page).to have_content('urgent')
      end

      within '.progress-bar' do
        expect(page).to have_content('83%')
      end

      within('#choice_left') do
        click_button I18n.t('comparisons.choose')
      end

      # Go back to homepage
      within 'ul' do
        within 'li:nth-of-type(1)' do
          expect(page).to have_content('Task A')
          within 'small' do
            expect(page).to have_content('Winner 4 times')
          end
        end
        within 'li:nth-of-type(2)' do
          expect(page).to have_content('Task B')
          within 'small' do
            expect(page).to have_content('Winner 2 times')
          end
        end
        within 'li:nth-of-type(3)' do
          expect(page).to have_content('Task C')
          within 'small' do
            expect(page).to have_content('Winner 0 times')
          end
        end
      end

      expect(page).to_not have_link('Prioritize')
      expect(page).to have_link('Reprioritize')
    end
  end

  describe 'Ordering after prioritization' do
    before :each do
      Comparison.create(task_left_id: @t1.id, task_right_id: @t2.id, choice_id: @t2.id)
      Comparison.create(task_left_id: @t1.id, task_right_id: @t3.id, choice_id: @t3.id)
      Comparison.create(task_left_id: @t2.id, task_right_id: @t3.id, choice_id: @t3.id)
    end

    it 'shows me the list in order of prioritization' do
      visit '/tasks'

      within 'ul' do
        within 'li:nth-of-type(1)' do
          expect(page).to have_content('Task C')
          within 'small' do
            expect(page).to have_content('Winner 2 times')
          end
        end
        within 'li:nth-of-type(2)' do
          expect(page).to have_content('Task B')
          within 'small' do
            expect(page).to have_content('Winner 1 times')
          end
        end
        within 'li:nth-of-type(3)' do
          expect(page).to have_content('Task A')
          within 'small' do
            expect(page).to have_content('Winner 0 times')
          end
        end
      end
    end
  end

  describe 'Reprioritization' do
    before :each do
      Comparison.create(task_left_id: @t1.id, task_right_id: @t2.id, choice_id: @t1.id, measure: "important")
      Comparison.create(task_left_id: @t1.id, task_right_id: @t3.id, choice_id: @t1.id, measure: "important")
      Comparison.create(task_left_id: @t2.id, task_right_id: @t3.id, choice_id: @t2.id, measure: "important")

      Comparison.create(task_left_id: @t1.id, task_right_id: @t2.id, choice_id: @t1.id, measure: "urgent")
      Comparison.create(task_left_id: @t1.id, task_right_id: @t3.id, choice_id: @t1.id, measure: "urgent")
      Comparison.create(task_left_id: @t2.id, task_right_id: @t3.id, choice_id: @t2.id, measure: "urgent")
    end

    it 'lets me compare A and B' do
      visit '/tasks'

      click_on I18n.t('tasks.reprioritize')

      # First comparison - A/B
      within '.progress-bar' do
        expect(page).to have_content('0%')
      end

      within '#choice_left' do
        within 'h2' do
          expect(page).to have_content('Task A')
        end
        expect(page).to have_button I18n.t('comparisons.choose')
      end

      within '#choice_right' do
        within 'h2' do
          expect(page).to have_content('Task B')
        end
        expect(page).to have_button I18n.t('comparisons.choose')
      end
    end
  end
end
