class PeopleController < ApplicationController
  def index
    @people = Person.all
    @people = Person.search(params[:term])
  end

  def show
    @people = Person.all
  end

  def new
    @person = Person.new
  end

  def create
    @person = Person.new(person_params)
    @person.document = params[:file] # Assign a file like this, or
    # like this
    # File.open('app/assets/images/') do |f|
      # @person.document = f
    # end
    #@person.document.url  => 'app/assets/images/file.png'
    #@person.document.current_path  => 'app/assets/images/file.png'
    #@person.document_identifier   => 'file.png'

    if @person.save
      flash[:notice] = "Your registration has been submitted."
    else
      flash.now[:alert] = "There was an error saving your new to-do item. Please try again."
      render :new
    end
    notify_wellfence
  end

  def edit
    @person = Person.find(params[:id])
  end

  def updated
    @person = Person.find(params[:id])
    @person.assign_attributes(person_params)

    if @person.save
      flash[:notice] = "Your info was updated."
      redirect_to welcome_index_path
     else
      flash.now[:alert] = "There was an error saving your info. Please try again."
      render :edit
     end
  end

  def destroy
    @person = Person.find(params[:id])

    if @person.destroy
      flash[:notice] = "\"#{@person.first_name}\" was deleted successfully."
      redirect_to people_path
    else
      flash.now[:alert] = "There was an error deleting this person."
      redirect_to people_path
    end
  end

  private

  def notify_wellfence
    account_sid = ENV['ACCOUNT_SID']
    auth_token = ENV['AUTH_TOKEN']
    @client = Twilio::REST::Client.new(account_sid, auth_token)
    @client.messages.create(
      from: "+18306421354",
        to: ["+12104008165", "+18322820867"],
      body: "#{@person.first_name} #{@person.last_name}\n #{@person.company}\n #{@person.position}\n #{@person.email}\n Phone: #{@person.phone}\n ID:#{@person.card_number}\n H2S: #{@person.document}")
  end

  def person_params
    params.require(:person).permit(:first_name, :last_name, :company, :position, :email, :phone, :h2s, :has_card, :card_number, :rig, :id, :document)
  end

end
