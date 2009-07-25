class LoadsController < ApplicationController
  # GET /loads
  # GET /loads.xml
  def index
    @loads = Loads.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @loads }
    end
  end

  # GET /loads/1
  # GET /loads/1.xml
  def show
    @loads = Loads.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @loads }
    end
  end

  # GET /loads/new
  # GET /loads/new.xml
  def new
    @loads = Loads.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @loads }
    end
  end

  # GET /loads/1/edit
  def edit
    @loads = Loads.find(params[:id])
  end

  # POST /loads
  # POST /loads.xml
  def create
    @loads = Loads.new(params[:loads])

    respond_to do |format|
      if @loads.save
        flash[:notice] = 'Loads was successfully created.'
        format.html { redirect_to(@loads) }
        format.xml  { render :xml => @loads, :status => :created, :location => @loads }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @loads.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /loads/1
  # PUT /loads/1.xml
  def update
    @loads = Loads.find(params[:id])

    respond_to do |format|
      if @loads.update_attributes(params[:loads])
        flash[:notice] = 'Loads was successfully updated.'
        format.html { redirect_to(@loads) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @loads.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /loads/1
  # DELETE /loads/1.xml
  def destroy
    @loads = Loads.find(params[:id])
    @loads.destroy

    respond_to do |format|
      format.html { redirect_to(loads_url) }
      format.xml  { head :ok }
    end
  end
end
