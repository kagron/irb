require 'test_helper'

class DocumentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @document = documents(:one)
  end

  test "should get index" do
    get documents_url
    assert_response :success
  end

  test "should get new" do
    get new_document_url
    assert_response :success
  end

  test "should create document" do
    assert_difference('Document.count') do
      post documents_url, params: { document: { address: @document.address, advisor_sig: @document.advisor_sig, authorities_consent: @document.authorities_consent, confidentiality: @document.confidentiality, department: @document.department, email: @document.email, end_date: @document.end_date, fName: @document.fName, lName: @document.lName, lit_review: @document.lit_review, opt_participation: @document.opt_participation, parental_consent: @document.parental_consent, phone: @document.phone, pool_of_subjects: @document.pool_of_subjects, procedure: @document.procedure, project_title: @document.project_title, research_question: @document.research_question, risks: @document.risks, sponsor_name: @document.sponsor_name, start_date: @document.start_date, sub_recruitment: @document.sub_recruitment, subjects_consent: @document.subjects_consent, typeOfApplication: @document.typeOfApplication } }
    end

    assert_redirected_to document_url(Document.last)
  end

  test "should show document" do
    get document_url(@document)
    assert_response :success
  end

  test "should get edit" do
    get edit_document_url(@document)
    assert_response :success
  end

  test "should update document" do
    patch document_url(@document), params: { document: { address: @document.address, advisor_sig: @document.advisor_sig, authorities_consent: @document.authorities_consent, confidentiality: @document.confidentiality, department: @document.department, email: @document.email, end_date: @document.end_date, fName: @document.fName, lName: @document.lName, lit_review: @document.lit_review, opt_participation: @document.opt_participation, parental_consent: @document.parental_consent, phone: @document.phone, pool_of_subjects: @document.pool_of_subjects, procedure: @document.procedure, project_title: @document.project_title, research_question: @document.research_question, risks: @document.risks, sponsor_name: @document.sponsor_name, start_date: @document.start_date, sub_recruitment: @document.sub_recruitment, subjects_consent: @document.subjects_consent, typeOfApplication: @document.typeOfApplication } }
    assert_redirected_to document_url(@document)
  end

  test "should destroy document" do
    assert_difference('Document.count', -1) do
      delete document_url(@document)
    end

    assert_redirected_to documents_url
  end
end
