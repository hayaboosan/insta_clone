require 'rails_helper'

RSpec.describe 'チャット', type: :system do
  let(:login_user) { create(:user) }
  let(:user) { create(:user) }

  describe 'メッセージボタン' do
    it 'ユーザーの詳細ページに存在すること' do
      login_as login_user
      visit user_path(user)
      expect(page).to have_selector(:link_or_button, 'メッセージ')
    end
    
    it 'クリックすると当該ユーザーとのチャットルームに遷移すること' do
      login_as login_user
      visit user_path(user)
      click_button 'メッセージ'
      expect(current_path).to eq chatroom_path(Chatroom.first)
    end
  end

  describe 'メッセージ投稿' do
    context 'テキストを入力しないで投稿ボタンを押した場合' do
      it 'エラーメッセージが表示されること' do
        login_as login_user
        visit user_path(user)
        click_button 'メッセージ'
        click_button '投稿'
        sleep 0.5
        expect(page.driver.browser.switch_to.alert.text).to eq 'メッセージを入力してください'
        end
      end

    context 'テキストを入力して投稿ボタンを押した場合' do
      it 'メッセージが投稿されること' do
        login_as login_user
        visit user_path(user)
        click_button 'メッセージ'
        fill_in 'メッセージ', with: 'hello world'
        click_button '投稿'
        expect(page).to have_content 'hello world'
      end
    end
  end

  describe 'メッセージの編集ボタンをクリックした場合' do
    it 'モーダルが表示され、コメントの編集ができること', js: true do
      login_as login_user
      visit user_path(user)
      click_button 'メッセージ'
      fill_in 'メッセージ', with: 'hello world'
      click_button '投稿'
      expect(page).to have_content 'hello world'
      find(".edit-button").click
      within '#modal-container' do
        fill_in 'メッセージ', with: 'updated hello world'
        click_button '更新'
      end
      expect(page).to have_content('updated hello world')
    end
  end

  describe 'メッセージの削除ボタンをクリックした場合' do
    it '確認ダイアログが出て、｢OK｣するとメッセージが削除されること' do
      login_as login_user
      visit user_path(user)
      click_button 'メッセージ'
      fill_in 'メッセージ', with: 'hello world'
      click_button '投稿'
      expect(page).to have_content 'hello world'
      page.accept_confirm { find(".delete-button").click }
      expect(page).to_not have_content('hello world')
    end
  end
end
