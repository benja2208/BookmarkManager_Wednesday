# require 'factory_girl'

feature 'User sign up' do 
	# user = create(:user)

	scenario 'I can sign up as a new user' do 
		expect { sign_up }.to change(User, :count).by(1)
		expect(page).to have_content('Welcome, alice@example.com')
		expect(User.first.email).to eq('alice@example.com')
	end 

	scenario 'with a password that does not match' do 
		expect { sign_up(password_confirmation:'wrong') }.not_to change(User, :count)
		expect(current_path).to eq('/users')
		expect(page).to have_content 'Password does not match the confirmation'
	end 

	scenario 'no email address given' do
		expect { sign_up(email: '')}.not_to change(User, :count)
		expect(current_path).to eq('/users')
		expect(page).to have_content 'Email must not be blank'
	end 

	scenario 'I cannot sign up with an existing email' do 
		sign_up
		expect { sign_up }.to change(User, :count).by(0)
		expect(page).to have_content('Email is already taken')
	end 

end 

feature 'User sign in' do 
	let(:user) do 
		User.create(email: 'user@example.com',
								password: 'secret1234',
								password_confirmation: 'secret1234')
	end 

	scenario 'with correct credentials' do 
		sign_in(email: user.email, password: user.password)
		expect(page).to have_content "Welcome, #{user.email}"
	end 

end 

feature 'User signs out' do 
	before(:each) do 
		User.create(email: 'test@test.com', 
								password: 'test',
								password_confirmation: 'test')
	end 

	scenario 'while being signed in' do
    sign_in(email: 'test@test.com', password: 'test')
    click_button 'Sign out'
    expect(page).to have_content('goodbye!') 
    expect(page).not_to have_content('Welcome, test@test.com')
  end
end 