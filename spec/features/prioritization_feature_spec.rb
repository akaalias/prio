require 'rails_helper'

feature 'Prioritization' do
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
        expect(page).to have_content('Compare A and B')
      end

      within 'form#new_comparison' do
        within 'h2:nth-of-type(1)' do
          expect(page).to have_content('Task A')
        end
        within 'h2:nth-of-type(2)' do
          expect(page).to have_content('Task B')
        end
      end
    end
  end
end
