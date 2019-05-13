class TslrClaim < ApplicationRecord
  PAGE_SEQUENCE = [
    "qts-year",
    "claim-school",
    "still-teaching",
    "subject-percentage",
  ].freeze

  VALID_QTS_YEARS = [
    "2013-2014",
    "2014-2015",
    "2015-2016",
    "2016-2017",
    "2017-2018",
    "2018-2019",
    "2019-2020",
  ].freeze

  enum employment_status: {
    claim_school: 0,
    different_school: 1,
    no_school: 2,
  }, _prefix: :employed_at

  belongs_to :claim_school, optional: true, class_name: "School"

  validates :claim_school,      on: :"claim-school", presence: {message: "Select a school from the list"}
  validates :qts_award_year,    on: :"qts-year", inclusion: {in: VALID_QTS_YEARS, message: "Select the academic year you were awarded qualified teacher status"}
  validates :employment_status, on: :"still-teaching", presence: {message: "Choose the option that describes your current employment status"}

  delegate :name, to: :claim_school, prefix: true, allow_nil: true
end
