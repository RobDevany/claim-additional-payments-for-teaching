require "csv"

module StudentLoans
  class ClaimsCsv
    attr_accessor :claims

    FIELDS = [
      :reference,
      :submitted_at,
      :qts_award_year,
      :claim_school_name,
      :employment_status,
      :current_school_name,
      :first_name,
      :middle_name,
      :surname,
      :address_line_1,
      :address_line_2,
      :address_line_3,
      :address_line_4,
      :postcode,
      :date_of_birth,
      :payroll_gender,
      :teacher_reference_number,
      :national_insurance_number,
      :student_loan_repayment_plan,
      :email_address,
      :had_leadership_position,
      :mostly_performed_leadership_duties,
      :biology_taught,
      :chemistry_taught,
      :computer_science_taught,
      :languages_taught,
      :physics_taught,
      :bank_sort_code,
      :bank_account_number,
      :student_loan_repayment_amount,
    ].freeze

    def initialize(claims)
      self.claims = claims
    end

    def file
      Tempfile.new.tap do |file|
        file.write(header_row)
        claims.each do |claim|
          file.write(StudentLoans::ClaimCsvRow.new(claim).to_s)
        end
        file.rewind
      end
    end

    private

    def header_row
      CSV.generate_line(csv_headers)
    end

    def csv_headers
      FIELDS.map { |h| header_string_for_field(h) }
    end

    def header_string_for_field(header)
      I18n.t("student_loans.csv_headers.#{header}")
    end
  end
end