Given /^no current Users$/ do 
  User.delete_all
  Company.delete_all
end
