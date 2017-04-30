require 'rails_helper'

feature 'Prioritization' do

  before :each do
    Task.create(description: 'Task A')
    Task.create(description: 'Task B')
    Task.create(description: 'Task C')
  end

  describe 'seeing the list of tasks' do
    before :each do
      visit '/tasks'
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

  describe 'Comparing' do
    it 'lets me compare A and B' do
      visit '/tasks'

      click_on 'Prioritize'

      within 'h1' do
        expect(page).to have_content('Compare Task A and Task B')
      end

      within '#progress' do
        expect(page).to have_content('3 Comparisons Remaining')
      end

      within 'form:nth-of-type(1)' do
        within 'h2' do
          expect(page).to have_content('Task A')
        end
        expect(page).to have_button 'Choose Task A'
      end

      within 'form:nth-of-type(2)' do
        within 'h2' do
          expect(page).to have_content('Task B')
        end
        expect(page).to have_button 'Choose Task B'
      end

      within('form:nth-of-type(1)') do
        click_button 'Choose Task A'
      end

      # next comparison A - C
      within '#flash' do
        expect(page).to have_content('You chose Task A over Task B')
      end

      within '#progress' do
        expect(page).to have_content('2 Comparisons Remaining')
      end

      within 'h1' do
        expect(page).to have_content('Compare Task A and Task C')
      end

      within 'form:nth-of-type(1)' do
        within 'h2' do
          expect(page).to have_content('Task A')
        end
        expect(page).to have_button 'Choose Task A'
      end

      within 'form:nth-of-type(2)' do
        within 'h2' do
          expect(page).to have_content('Task C')
        end
        expect(page).to have_button 'Choose Task C'
      end

      within('form:nth-of-type(1)') do
        click_button 'Choose Task A'
      end

      # next comparison  – B / C
      within '#flash' do
        expect(page).to have_content('You chose Task A over Task C')
      end

      within '#progress' do
        expect(page).to have_content('1 Comparisons Remaining')
      end

      within 'h1' do
        expect(page).to have_content('Compare Task B and Task C')
      end

      within('form:nth-of-type(1)') do
        click_button 'Choose Task B'
      end

      # Go back to homepage
      within '#flash' do
        expect(page).to have_content('You compared all Tasks')
      end
    end
  end
end
