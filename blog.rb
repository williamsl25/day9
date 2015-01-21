require 'sinatra'
require 'data_mapper'

DataMapper.setup(
	:default,
	'mysql://root@localhost/eating_easy'
	)
class Recipe
	include DataMapper::Resource
	DataMapper::Property::String.length(1000)
	# attr_accessor :name
	# attr_accessor: prep_time
	# attr_accessor: cook_time
	property :id, Serial
	property :name, String
	property :prep_time, String
	property :cook_time, String
	property :ingredients, String
	property :directions, String
end
# an instance of the object Recipe
DataMapper.finalize.auto_upgrade!

# RESTful
##########
# GET - receives information from the server
# POST - creates information/sends new information to the server
# PUT/PATCH - updates/sends updated exisiting information to the server
# DELETE - sends delete information to the server

# Index
get '/' do  #get checks where the user is on the browser
	@recipes = Recipe.all
	erb :index
end
# New
get '/new' do
	erb :create_recipe
end

# get '/create_recipe' do
# end

# the form page - /new
# takes a new object (recipe) and accesses the form on the create_recipe page 
post '/create_recipe' do  #form will send info through the hash [:name],[:ingredients]
	p params # same as puts.inspect
	@recipe = Recipe.new
	@recipe.name = params[:recipe]
	@recipe.prep_time = params[:prep_time]
	@recipe.cook_time = params[:cook_time]
	@recipe.ingredients = params[:ingredients]
	@recipe.directions = params[:directions]
	@recipe.save  #call it -run it to create a new recipe
	redirect to '/'
	# redirect to '/' will put the recipe in database when entered on the form
	# redirect it to the root route '/'
end

# Show
get '/recipe/:id' do
	@recipe = Recipe.get params[:id]
	erb :display_recipe
end
# displays the recipe inputed from form

# Delete
delete '/delete_recipe/:id' do
	@recipe = Recipe.get params[:id]
	@recipe.destroy
	redirect to '/'
end
#takes the object off the database

get '/edit_recipe/:id' do
	@recipe = Recipe.get params[:id]
	erb :edit_blog
end

patch '/save-recipe/:id' do
	@recipe = Recipe.get params[:id]
	@recipe.update name: params[:recipe]
	@recipe.update prep_time: params[:prep_time]
	@recipe.update cook_time: params[:cook_time]
	@recipe.update ingredients: params[:ingredients]
	@recipe.update directions: params[:directions]
	@recipe.save  #call it -run it to create a new recipe
	redirect to '/'
end




# Edit
# Get - displays the form
# Update
# PUT - changes/submits the updated data

# CRUD
# c - create
# r - read
# u - update
# d - destroy








