require 'test_helper'

class DataControllerTest < ActionController::TestCase
  setup do
    @datum = data(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:data)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create datum" do
    assert_difference('Datum.count') do
      post :create, datum: { assistants: @datum.assistants, bio: @datum.bio, blog: @datum.blog, closedProjects: @datum.closedProjects, completeName: @datum.completeName, constituency: @datum.constituency, cvLink: @datum.cvLink, dateOfBirth: @datum.dateOfBirth, debates: @datum.debates, declarationLink: @datum.declarationLink, electoralAddress: @datum.electoralAddress, electoralFax: @datum.electoralFax, electoralMobile: @datum.electoralMobile, electoralTelephone: @datum.electoralTelephone, email: @datum.email, facebook: @datum.facebook, followers: @datum.followers, following: @datum.following, googlePlus: @datum.googlePlus, ideology1: @datum.ideology1, ideology2: @datum.ideology2, ideology3: @datum.ideology3, ideology4: @datum.ideology4, ideology5: @datum.ideology5, instagram: @datum.instagram, institution: @datum.institution, institutionalAddress: @datum.institutionalAddress, institutionalFax: @datum.institutionalFax, institutionalMobilePhone: @datum.institutionalMobilePhone, institutionalTelephone: @datum.institutionalTelephone, lastActivity1: @datum.lastActivity1, lastActivity2: @datum.lastActivity2, lastActivity3: @datum.lastActivity3, lastActivity4: @datum.lastActivity4, likes: @datum.likes, linkedin: @datum.linkedin, name: @datum.name, officialWebsite: @datum.officialWebsite, openProjects: @datum.openProjects, phone: @datum.phone, picture: @datum.picture, placeOfBirth: @datum.placeOfBirth, politicalParty: @datum.politicalParty, politicalPartyImage: @datum.politicalPartyImage, position: @datum.position, premium: @datum.premium, profession: @datum.profession, proposals: @datum.proposals, quote1: @datum.quote1, quote2: @datum.quote2, region: @datum.region, sourceActivity: @datum.sourceActivity, sourceWebsite: @datum.sourceWebsite, sponsorships: @datum.sponsorships, studies: @datum.studies, twitter: @datum.twitter, university: @datum.university, verified: @datum.verified, victories: @datum.victories, youtubeChannel: @datum.youtubeChannel }
    end

    assert_redirected_to datum_path(assigns(:datum))
  end

  test "should show datum" do
    get :show, id: @datum
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @datum
    assert_response :success
  end

  test "should update datum" do
    patch :update, id: @datum, datum: { assistants: @datum.assistants, bio: @datum.bio, blog: @datum.blog, closedProjects: @datum.closedProjects, completeName: @datum.completeName, constituency: @datum.constituency, cvLink: @datum.cvLink, dateOfBirth: @datum.dateOfBirth, debates: @datum.debates, declarationLink: @datum.declarationLink, electoralAddress: @datum.electoralAddress, electoralFax: @datum.electoralFax, electoralMobile: @datum.electoralMobile, electoralTelephone: @datum.electoralTelephone, email: @datum.email, facebook: @datum.facebook, followers: @datum.followers, following: @datum.following, googlePlus: @datum.googlePlus, ideology1: @datum.ideology1, ideology2: @datum.ideology2, ideology3: @datum.ideology3, ideology4: @datum.ideology4, ideology5: @datum.ideology5, instagram: @datum.instagram, institution: @datum.institution, institutionalAddress: @datum.institutionalAddress, institutionalFax: @datum.institutionalFax, institutionalMobilePhone: @datum.institutionalMobilePhone, institutionalTelephone: @datum.institutionalTelephone, lastActivity1: @datum.lastActivity1, lastActivity2: @datum.lastActivity2, lastActivity3: @datum.lastActivity3, lastActivity4: @datum.lastActivity4, likes: @datum.likes, linkedin: @datum.linkedin, name: @datum.name, officialWebsite: @datum.officialWebsite, openProjects: @datum.openProjects, phone: @datum.phone, picture: @datum.picture, placeOfBirth: @datum.placeOfBirth, politicalParty: @datum.politicalParty, politicalPartyImage: @datum.politicalPartyImage, position: @datum.position, premium: @datum.premium, profession: @datum.profession, proposals: @datum.proposals, quote1: @datum.quote1, quote2: @datum.quote2, region: @datum.region, sourceActivity: @datum.sourceActivity, sourceWebsite: @datum.sourceWebsite, sponsorships: @datum.sponsorships, studies: @datum.studies, twitter: @datum.twitter, university: @datum.university, verified: @datum.verified, victories: @datum.victories, youtubeChannel: @datum.youtubeChannel }
    assert_redirected_to datum_path(assigns(:datum))
  end

  test "should destroy datum" do
    assert_difference('Datum.count', -1) do
      delete :destroy, id: @datum
    end

    assert_redirected_to data_path
  end
end
