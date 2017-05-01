require 'rails_helper'

feature 'Homepage' do
  describe 'Viewing homepage' do
    before :each do
      visit '/'
    end

    it 'lets me see a headline' do
      within 'h1' do
        expect(page).to have_content('Do the most valuable thing next.')
      end
    end

    it 'lets me see a welcome message' do
      within 'h2' do
        expect(page).to have_content('Prio.io helps you prioritize a list of tasks effectively.')
      end
    end
  end
end

feature 'Adding Tasks' do
  describe 'adding tasks with the text-area' do
    before :each do
      visit '/'
    end

    it 'lets me see instructions' do
      within 'h3' do
        expect(page).to have_content('Enter your tasks below, one task per line. When you are done, click on the button.')
      end
    end

    it 'lets me create tasks' do
      fill_in 'tasks', with: 'Task A\nTask B\nTask C'

      click_button 'Create Tasks'

      within 'h1' do
        expect(page).to have_content('All Tasks')
      end

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
  end
end
