feature 'Viewing links' do

  scenario 'I can see existing links on the links page' do

    visit '/listings'
    expect(page.status_code).to eq 200

    # within 'ul#listings' do
      expect(page).to have_content('Leafy Towers')
    # end
  end

  # scenario 'I can create a new listing on the page' do
  #
  #   visit '/listings'
  #   fill_in :name, with: 'Makers'
  #   fill_in 'bio', with: 'Academy'
  #   fill_in 'guests', with: 4
  #   click_button('submit')
  #
  #
  #     expect(page).to have_content('Markers')
  # end

  # scenario 'I can see a submit button on the page' do
  #   visit '/listings'
  #   expect(page).to have_selector('#submit', visible: true)
  # end
end
