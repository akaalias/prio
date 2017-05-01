require 'rails_helper'

feature 'Prioritization' do

  before :each do
    @t1 = Task.create(description: 'Task A')
    @t2 = Task.create(description: 'Task B')
    @t3 = Task.create(description: 'Task C')
  end

  describe 'seeing the list of tasks' do
    before :each do
      visit '/'
    end

    it 'lets me see the title' do
      within 'h1' do
        expect(page).to have_content('All Tasks')
      end
    end

    it 'lets me see the list of tasks' do
      within 'ul' do
        within 'li:nth-of-type(1)' do
          expect(page).to have_content('Task A')
        end
        within 'li:nth-of-type(2)' do
          expect(page).to have_content('Task B')
        end
        within 'li:nth-of-type(3)' do
          expect(page).to have_content('Task C')
        end
      end
    end

    it 'lets me see a link for prioritization' do
      expect(page).to have_link('Prioritize')
    end
  end

  describe 'Prioritization' do
    it 'lets me compare A and B' do
      visit '/'

      click_on 'Prioritize'

      # First comparison - A/B
      within 'h1' do
        expect(page).to have_content('Compare Task A and Task B')
      end

      within '#progress' do
        expect(page).to have_content('3 Comparisons Remaining')
      end

      within '#choice_left' do
        within 'h2' do
          expect(page).to have_content('Task A')
        end
        expect(page).to have_button 'Choose Task A'
      end

      within '#choice_right' do
        within 'h2' do
          expect(page).to have_content('Task B')
        end
        expect(page).to have_button 'Choose Task B'
      end

      within('#choice_left') do
        click_button 'Choose Task A'
      end

      # next comparison A/C
      within '#flash' do
        expect(page).to have_content('You chose Task A over Task B')
      end

      within '#progress' do
        expect(page).to have_content('2 Comparisons Remaining')
      end

      within 'h1' do
        expect(page).to have_content('Compare Task A and Task C')
      end

      within '#choice_left' do
        within 'h2' do
          expect(page).to have_content('Task A')
        end
        expect(page).to have_button 'Choose Task A'
      end

      within '#choice_right' do
        within 'h2' do
          expect(page).to have_content('Task C')
        end
        expect(page).to have_button 'Choose Task C'
      end

      within('#choice_left') do
        click_button 'Choose Task A'
      end

      # next comparison – B/C
      within '#flash' do
        expect(page).to have_content('You chose Task A over Task C')
      end

      within '#progress' do
        expect(page).to have_content('1 Comparisons Remaining')
      end

      within 'h1' do
        expect(page).to have_content('Compare Task B and Task C')
      end

      within('#choice_left') do
        click_button 'Choose Task B'
      end

      # Go back to homepage
      within '#flash' do
        expect(page).to have_content('You compared all Tasks')
      end

      within 'ul' do
        within 'li:nth-of-type(1)' do
          expect(page).to have_content('Task A')
          within 'span' do
            expect(page).to have_content('Winner 2 times')
          end
        end
        within 'li:nth-of-type(2)' do
          expect(page).to have_content('Task B')
          within 'span' do
            expect(page).to have_content('Winner 1 times')
          end
        end
        within 'li:nth-of-type(3)' do
          expect(page).to have_content('Task C')
          within 'span' do
            expect(page).to have_content('Winner 0 times')
          end
        end
      end

      expect(page).to_not have_link('Prioritize')
      expect(page).to have_link('Reprioritize')
    end
  end

  describe 'Prioritization' do
    before :each do
      Comparison.create(task_left_id: @t1.id, task_right_id: @t2.id, choice_id: @t1.id)
      Comparison.create(task_left_id: @t1.id, task_right_id: @t3.id, choice_id: @t1.id)
      Comparison.create(task_left_id: @t2.id, task_right_id: @t3.id, choice_id: @t2.id)
    end

    it 'lets me compare A and B' do
      visit '/'

      click_on 'Reprioritize'

      # First comparison - A/B
      within 'h1' do
        expect(page).to have_content('Compare Task A and Task B')
      end

      within '#progress' do
        expect(page).to have_content('3 Comparisons Remaining')
      end
    end
  end
end
