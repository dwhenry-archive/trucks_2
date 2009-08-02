class LoadsController < ApplicationController
  include Geokit::Geocoders
  require 'extends_mappable'
  # GET /loads
  # GET /loads.xml
  def your
    @loads = current_user.company.loads
    load = @loads.first
    
    if load
      @results = get_match_results(load.start_lng,load.start_lat,load.end_lng,load.end_lat,load.load_type)
    else
      @results = []
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @loads }
    end
  end

  # GET /loads
  # GET /loads.xml
  def index
    @loads = Load.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @loads }
    end
  end

  # GET /loads/1
  # GET /loads/1.xml
  def show
    @load = Load.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @load }
    end
  end

  # GET /loads/new
  # GET /loads/new.xml
  def new
    @load = Load.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @load }
    end
  end

  # GET /loads/1/edit
  def edit
    @load = Load.find(params[:id])
  end

  # POST /loads
  # POST /loads.xml
  def create
    @load = Load.new(params[:load])
    @load.company = current_user.company

    respond_to do |format|
      if @load.save
        flash[:notice] = 'Loads was successfully created.'
        format.html { redirect_to(your_loads_path) }
        format.xml  { render :xml => @load, :status => :created, :location => @load }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @load.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /loads/1
  # PUT /loads/1.xml
  def update
    @load = Load.find(params[:id])

    respond_to do |format|
      if @load.update_attributes(params[:loads])
        flash[:notice] = 'Load was successfully updated.'
        format.html { redirect_to(@load) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @load.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /loads/1
  # DELETE /loads/1.xml
  def destroy
    @load = Load.find(params[:id])
    @load.destroy

    respond_to do |format|
      format.html { redirect_to(loads_url) }
      format.xml  { head :ok }
    end
  end

  def match_data
    #debugger
    if params[:start_lng] and params[:start_lat] and
            params[:end_lng] and params[:end_lat] and
            params[:load_type]
      res = get_match_results(params[:start_lng],params[:start_lat],
                                 params[:end_lng],params[:end_lat],
                                 params[:load_type])
    end

    render :partial => 'match_data', :locals => {:results => res}
  end

  protected
  def get_match_results(start_lng, start_lat,end_lng,end_lat,load_type)
    ExtendsMappable.calcualte_journey(start_lat.to_s + ',' + start_lng.to_s,end_lat.to_s + ',' + end_lng.to_s,load_type)
  end
end

