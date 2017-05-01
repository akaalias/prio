require 'rails_helper'

feature 'Homepage' do
  describe 'Viewing homepage' do
    before :each do
      visit '/'
    end

    it 'lets me see a headline' do
      within 'h1' do
        expect(page).to have_content(I18n.t('homepage.headline'))
      end
    end

    it 'lets me see an explanation' do
      within 'p:nth-of-type(1)' do
        expect(page).to have_content(I18n.t('homepage.explanation.step_one'))
      end

      within 'p:nth-of-type(2)' do
        expect(page).to have_content(I18n.t('homepage.explanation.step_two'))
      end
    end

    it 'lets me see a get started button' do
      expect(page).to have_link(I18n.t('homepage.get_started'))
    end
  end
end

feature 'Adding Tasks' do
  describe 'adding tasks with the text-area' do
    before :each do
      visit '/'

      click_on I18n.t('homepage.get_started')
    end

    it 'lets me see instructions' do
      within 'h3' do
        expect(page).to have_content(I18n.t('tasks.instructions'))
      end
    end

    it 'lets me create tasks' do
      fill_in 'tasks', with: 'Task A\nTask B\nTask C'

      click_button I18n.t('tasks.create_tasks')

      within 'h1' do
        expect(page).to have_content(I18n.t('tasks.all_tasks'))
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
