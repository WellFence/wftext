class PeopleController < ApplicationController
  def index
    @people = Person.all
    @people = Person.search(params[:term])
  end

  def show
    @people = Person.all
  end

  def new
    @people = Person.new
  end

  def create
    @person = Person.new(person_params)
    if @person.save
      flash[:notice] = "Your registration has been submitted."
      redirect_to welcome_index_path
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
      redirect_to action: :index
    else
      flash.now[:alert] = "There was an error deleting this person."
      render :show
    end
  end

  private

  def person_params
    params.require(:person).permit(:first_name, :last_name, :company, :position, :email, :phone, :h2s, :has_card, :card_number, :rig, :id)
  end

  def notify_wellfence
    account_sid = ENV['ACCOUNT_SID']
    auth_token = ENV['AUTH_TOKEN']

    @client = Twilio::REST::Client.new(account_sid, auth_token)

    @client.messages.create(
      from: "+18306421354",
        to: ["+12104008165", "+12544854214"],
      body: "#{@person.first_name} #{@person.last_name} \n #{@person.company} \n #{@person.position} \n #{@person.email} \n Phone: #{@person.phone} \n H2S: #{@person.h2s} \n ID:#{@person.card_number}")
  end

end
