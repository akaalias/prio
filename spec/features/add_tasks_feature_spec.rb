require 'rails_helper'

feature 'Homepage' do
  include ActionView::Helpers::AssetUrlHelper

  describe 'Viewing homepage' do
    before :each do
      visit '/'
    end

    it 'lets me see a headline' do
      within 'h1' do
        expect(page).to have_content(I18n.t('homepage.headline'))
      end
    end

    it 'lets me see an image' do
      expect(page).to have_css("img[id='banner']")
    end

    it 'lets me see copy' do
      expect(page).to have_css("div[id='copy']")
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
