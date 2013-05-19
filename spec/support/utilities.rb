def sign_in(user)
	visit signin_path
	fill_in "Email",  		with: user.email
	fill_in "Password",  	with: user.password
	click_button "Sign in"	
	cookies[:remember_token] = user.remember_token
end

def title_h1(title, h1)
	it {should have_selector('title', text: title)}
	it {should have_selector('h1', text: h1)}
end

