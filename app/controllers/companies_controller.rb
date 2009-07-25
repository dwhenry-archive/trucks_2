class CompaniesController < ApplicationController
  # GET /companies
  # GET /companies.xml
  def index
    @companies = Companies.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @companies }
    end
  end

  # GET /companies/1
  # GET /companies/1.xml
  def show
    @companies = Companies.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @companies }
    end
  end

  # GET /companies/new
  # GET /companies/new.xml
  def new
    @companies = Companies.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @companies }
    end
  end

  # GET /companies/1/edit
  def edit
    @companies = Companies.find(params[:id])
  end

  # POST /companies
  # POST /companies.xml
  def create
    @companies = Companies.new(params[:companies])

    respond_to do |format|
      if @companies.save
        flash[:notice] = 'Companies was successfully created.'
        format.html { redirect_to(@companies) }
        format.xml  { render :xml => @companies, :status => :created, :location => @companies }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @companies.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /companies/1
  # PUT /companies/1.xml
  def update
    @companies = Companies.find(params[:id])

    respond_to do |format|
      if @companies.update_attributes(params[:companies])
        flash[:notice] = 'Companies was successfully updated.'
        format.html { redirect_to(@companies) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @companies.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.xml
  def destroy
    @companies = Companies.find(params[:id])
    @companies.destroy

    respond_to do |format|
      format.html { redirect_to(companies_url) }
      format.xml  { head :ok }
    end
  end
end
