class CreateCompanies < ActiveRecord::Migration
  def self.up
    create_table :companies do |t|
      t.string :name
      t.string :abn
      t.string :address1
      t.string :address2
      t.string :town
      t.string :state
      t.string :postcode
      t.string :pref_type
      t.string :phone

      t.timestamps
    end

    @adminCompany_t = Company.create (
        :name => "Admin_t",
        :abn  => "1245",
        :address1 => "Admin",
        :address2 => "Admin",
        :town => "Admin",
        :state => "QLD",
        :postcode => "1234",
        :pref_type => "Truck",
        :phone => "0712541125"
    )

    @adminCompany_g = Company.create (
        :name => "Admin_g",
        :abn  => "1246",
        :address1 => "Admin",
        :address2 => "Admin",
        :town => "Admin",
        :state => "QLD",
        :postcode => "1234",
        :pref_type => "Contract",
        :phone => "0712541126"
    )  
  end

  def self.down
    drop_table :companies
  end
end
