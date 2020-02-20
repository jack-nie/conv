class ExcelsController < ApplicationController
  before_action :set_excel, only: [:show, :edit, :update, :destroy]

  # GET /excels
  # GET /excels.json
  def index
    @excels = Excel.all
  end

  # GET /excels/1
  # GET /excels/1.json
  def show
  end

  # GET /excels/new
  def new
    @excel = Excel.new
  end

  # GET /excels/1/edit
  def edit
  end

  # POST /excels
  # POST /excels.json
  def create
    @excel = Excel.new(excel_params)

    respond_to do |format|
      if @excel.save
        format.html { redirect_to @excel, notice: 'Excel was successfully created.' }
        format.json { render :show, status: :created, location: @excel }
      else
        format.html { render :new }
        format.json { render json: @excel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /excels/1
  # PATCH/PUT /excels/1.json
  def update
    excel1 = Spreadsheet.open excel_params[:excel1].tempfile
    excel2 = Spreadsheet.open excel_params[:excel2].tempfile
    excel3 = Spreadsheet.open excel_params[:excel3].tempfile
    map = Hash.new

    sheet1 = excel1.worksheet 0
    sheet1.each do |row|
      tmp =  Hash.new
      tmp["name"] = row[6]
      tmp["sex"] =  row[7]
      tmp["temperature"] = row[8]
      tmp["address"] =  row[9]
      map[row[6]] = tmp
    end

    book = Spreadsheet::Workbook.new
    sheet4 = book.create_worksheet


    sheet2 = excel2.worksheet 0
    sheet2.each do |row|
      tmp =  Hash.new
      tmp["name"] = row[6]
      tmp["sex"] =  row[7]
      tmp["temperature"] = row[8]
      tmp["address"] =  row[9]
      unless row[1].nil?
        begin
          date = Date.parse row[1]
          Rails.logger.info
          str = row[1].to_datetime.strftime("%H时%M分")
          tmp["time"] = str
        rescue Exception => e
          Rails.logger.info row[1] + "======="
        end
      end
      map[row[6]] = tmp
    end

    sheet3 = excel3.worksheet 0
    sheet3.each_with_index do |row, index|
      next if index < 2
      data = map[row[1]]
      Rails.logger.info index
      if data.nil?
        data = {}
      end
      sheet4.row(index).push row[1], data["name"], data["time"], nil, nil,data["temperature"]
    end
    spreadsheet = StringIO.new
    book.write spreadsheet
    send_data spreadsheet.string.bytes.to_a.pack("C*"), :disposition=>'attachment', :type => "application/vnd.ms-excel", :filename => "data.xls", :stream => false
  end

  # DELETE /excels/1
  # DELETE /excels/1.json
  def destroy
    @excel.destroy
    respond_to do |format|
      format.html { redirect_to excels_url, notice: 'Excel was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_excel
      @excel = Excel.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def excel_params
      params.fetch(:excel, {})
    end
end
