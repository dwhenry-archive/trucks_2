class CompaniesController < ApplicationController
  skip_before_filter :login_required, :only => [:new, :create]

  # GET /company
  # GET /company.xml
  def index
    @companies = Company.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @companies }
    end
  end

  # GET /company/1
  # GET /company/1.xml
  def show
    @company = Company.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @company }
    end
  end

  # GET /company/new
  # GET /company/new.xml
  def new
    @company = Company.new
    @company.users.build()

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @company }
    end
  end

  # GET /company/1/edit
  def edit
    @company = Company.find(params[:id])
  end

  # POST /company
  # POST /company.xml
  def create
    @company = Company.new(params[:company])
    @emails = {}
    respond_to do |format|
      if @company.save
        @company.users.each do |user|
          if Rails.env == "production"
            email = TrucksEmail.deliver_registration_confirmation(user)
          else
            email = TrucksEmail.create_registration_confirmation(user)
            @emails.merge!({user.login => email})
          end
        end
        format.html { render :action => "show" }
        format.xml  { render :xml => @company, :status => :created, :location => @company }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @company.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /company/1
  # PUT /company/1.xml
  def update
    @company = Company.find(params[:id])

    respond_to do |format|
      if @company.update_attributes(params[:company])
        flash[:notice] = 'Company was successfully updated.'
        format.html { redirect_to(@company) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @company.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /company/1
  # DELETE /company/1.xml
  def destroy
    @company = Company.find(params[:id])
    @company.destroy

    respond_to do |format|
      format.html { redirect_to(company_url) }
      format.xml  { head :ok }
    end
  end
end
