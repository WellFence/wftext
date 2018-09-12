class PeopleController < ApplicationController
  def index
    @people = Person.search(params[:search])
  end

  def show
    @people = Person.all
    @person = Person.find(params[:id])
  end

  def new
    @person = Person.new
  end

  def create
    @person = Person.new(person_params)
    @person.completed = false
    if @person.save
      flash[:notice] = "Thank you for registering. We will reach out to you promptly with further instructions."
    else
      flash.now[:alert] = "There was an error with your submission. Please try again."
      render :new
    end
    notify_wellfence
    redirect_to welcome_index_path
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

  def mark_completed
    @people = Person.all
    @person = Person.find(params[:id])
    if @person.update_attribute(:completed, true)
      flash[:notice] = "\"#{@person.first_name}\" successfully marked complete."
      redirect_to people_path
    else
      flash.now[:alert] = "There was an error marking this person complete, try again."
      render :show
    end
  end

  private

  def notify_wellfence
    account_sid = ENV['ACCOUNT_SID']
    auth_token = ENV['AUTH_TOKEN']
    @client = Twilio::REST::Client.new(account_sid, auth_token)
    @client.messages.create(
      from: "+18306421354",
        to: "+12104008165",
      body: "#{@person.first_name} #{@person.last_name}\n #{@person.company}\n #{@person.position}\n #{@person.email}\n Phone: #{@person.phone}\n ID:#{@person.card_number}\n H2S: #{@person.document}")
  end

  def person_params
    params.require(:person).permit(:first_name, :last_name, :company, :position, :email, :phone, :h2s, :has_card, :card_number, :rig, :id, :document, :completed, :search)
  end

end
