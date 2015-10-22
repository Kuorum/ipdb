class ProcessController < ApplicationController

  def download_csv()
    
    region_id = params[:region_id]
    @datum = Datum.where(:region_id => region_id)


    csv_string = CSV.generate do |csv|
         #csv << Datum.column_names
         csv << ["id","sourceWebsite","name","picture","politicalParty","politicalPartyImage","verified","likes","followers","email","twitter","facebook","linkedin","googlePlus","instagram","blog","youtubeChannel","premium","bio","quote1","quote2","sourceActivity","lastActivity1","lastActivity2","lastActivity3","lastActivity4","ideology1","ideology2","ideology3","ideology4","ideology5","following","openProjects","closedProjects","proposals","debates","sponsorships","victories","dateOfBirth","placeOfBirth","institutionalAddress","institutionalTelephone","institutionalFax","institutionalMobilePhone","electoralAddress","electoralTelephone","electoralFax","electoralMobile","phone","assistants","completeName","position","region","institution","constituency","studies","university","profession","cvLink","declarationLink","officialWebsite","politicalExperience","causes","region_code_alliance","region_code_nation","region_code_state","region_code_county","region_code_city","constituency_code_alliance","constituency_code_nation","constituency_code_state","constituency_code_county","constituency_code_city","political_leaning_index","cause1","cause2","cause3","cause4","cause5","known_for1","known_for2","known_for3","known_for4","known_for5","known_for_link1","known_for_link2","known_for_link3","known_for_link4","known_for_link5","lastActivity5","lastActivity1Date","lastActivity2Date","lastActivity3Date","lastActivity4Date","lastActivity5Date","lastActivity1Action","lastActivity2Action","lastActivity3Action","lastActivity4Action","lastActivity5Action","lastActivity1Outcome","lastActivity2Outcome","lastActivity3Outcome","lastActivity4Outcome","lastActivity5Outcome","political_experience1","political_experience2","political_experience3","political_experience4","political_experience5","political_experience1_content","political_experience2_content","political_experience3_content","political_experience4_content","political_experience5_content","political_experience1_date","political_experience2_date","political_experience3_date","political_experience4_date","political_experience5_date","school","family","pinterest","gender","region_id","lastActivity1Link","lastActivity2Link","lastActivity3Link","lastActivity4Link","lastActivity5Link"]
         
         @datum.each do |data|

          id = data.id
          sourceWebsite = data.sourceWebsite
          name = data.name
          picture = data.picture
          politicalParty = data.politicalParty

          party_image = ""  
          ideology1 = 0.0
          ideology2 = 0.0
          ideology3 = 0.0
          ideology4 = 0.0
          ideology5 = 0.0

          political_party = PoliticalParty.where("name LIKE ?",  '%'+data.politicalParty+'%')
          political_party.each do |pp|
            party_image = pp.image
            ideology1 = pp.leaning_index
            ideology2 = pp.leaning_index
            ideology3 = pp.leaning_index
            ideology4 = pp.leaning_index
            ideology5 = pp.leaning_index
          end  

          politicalPartyImage = party_image      
          verified = data.verified
          likes = data.likes
          followers = data.followers
          email = data.email
          twitter = data.twitter
          facebook = data.facebook
          linkedin = data.linkedin
          googlePlus = data.googlePlus
          instagram = data.instagram
          blog = data.blog
          youtubeChannel = data.youtubeChannel
          premium = data.premium
          bio = data.bio
          quote1 = data.quote1
          quote2 = data.quote2
          sourceActivity = data.sourceActivity
          lastActivity1 = data.lastActivity1
          lastActivity2 = data.lastActivity2
          lastActivity3 = data.lastActivity3
          lastActivity4 = data.lastActivity4
          ideology1 = ideology1
          ideology2 = ideology2
          ideology3 = ideology3
          ideology4 = ideology4
          ideology5 = ideology5
          following = data.following
          openProjects = data.openProjects
          closedProjects = data.closedProjects
          proposals = data.proposals
          debates = data.debates
          sponsorships = data.sponsorships
          victories = data.victories
          dateOfBirth = data.dateOfBirth
          placeOfBirth = data.placeOfBirth
          institutionalAddress = data.institutionalAddress
          institutionalTelephone = data.institutionalTelephone
          institutionalFax = data.institutionalFax
          institutionalMobilePhone = data.institutionalMobilePhone
          electoralAddress = data.electoralAddress
          electoralTelephone = data.electoralTelephone
          electoralFax = data.electoralFax
          electoralMobile = data.electoralMobile
          phone = data.phone
          assistants = data.assistants
          completeName = data.completeName
          position = data.position
          region = data.region
          institution = data.institution
          constituency = data.constituency
          studies = data.studies
          university = data.university
          profession = data.profession
          cvLink = data.cvLink
          declarationLink = data.declarationLink
          officialWebsite = data.officialWebsite
          politicalExperience = data.politicalExperience
          created_at = data.created_at
          updated_at = data.updated_at
          causes = data.causes
          region_code_alliance = data.region_code_alliance
          region_code_nation = data.region_code_nation
          region_code_state = data.region_code_state
          region_code_county = data.region_code_county
          region_code_city = data.region_code_city
          constituency_code_alliance = data.constituency_code_alliance
          constituency_code_nation = data.constituency_code_nation
          constituency_code_state = data.constituency_code_state
          constituency_code_county = data.constituency_code_county
          constituency_code_city = data.constituency_code_city
          political_leaning_index = data.political_leaning_index
          cause1 = data.cause1
          cause2 = data.cause2
          cause3 = data.cause3
          cause4 = data.cause4
          cause5 = data.cause5
          known_for1 = data.known_for1
          known_for2 = data.known_for2
          known_for3 = data.known_for3
          known_for4 = data.known_for4
          known_for5 = data.known_for5
          known_for_link1 = data.known_for_link1
          known_for_link2 = data.known_for_link2
          known_for_link3 = data.known_for_link3
          known_for_link4 = data.known_for_link4
          known_for_link5 = data.known_for_link5
          lastActivity5 = data.lastActivity5
          lastActivity1Date = data.lastActivity1Date
          lastActivity2Date = data.lastActivity2Date
          lastActivity3Date = data.lastActivity3Date
          lastActivity4Date = data.lastActivity4Date
          lastActivity5Date = data.lastActivity5Date
          lastActivity1Action = data.lastActivity1Action
          lastActivity2Action = data.lastActivity2Action
          lastActivity3Action = data.lastActivity3Action
          lastActivity4Action = data.lastActivity4Action
          lastActivity5Action = data.lastActivity5Action
          lastActivity1Outcome = data.lastActivity1Outcome
          lastActivity2Outcome = data.lastActivity2Outcome
          lastActivity3Outcome = data.lastActivity3Outcome
          lastActivity4Outcome = data.lastActivity4Outcome
          lastActivity5Outcome = data.lastActivity5Outcome
          political_experience1 = data.political_experience1
          political_experience2 = data.political_experience2
          political_experience3 = data.political_experience3
          political_experience4 = data.political_experience4
          political_experience5 = data.political_experience5
          political_experience1_content = data.political_experience1_content
          political_experience2_content = data.political_experience2_content
          political_experience3_content = data.political_experience3_content
          political_experience4_content = data.political_experience4_content
          political_experience5_content = data.political_experience5_content
          political_experience1_date = data.political_experience1_date
          political_experience2_date = data.political_experience2_date
          political_experience3_date = data.political_experience3_date
          political_experience4_date = data.political_experience4_date
          political_experience5_date = data.political_experience5_date
          school = data.school
          family = data.family
          pinterest = data.pinterest
          gender = data.gender
          region_id = data.region_id
          lastActivity1Link = data.lastActivity1Link
          lastActivity2Link = data.lastActivity2Link
          lastActivity3Link = data.lastActivity3Link
          lastActivity4Link = data.lastActivity4Link
          lastActivity5Link = data.lastActivity5Link


          #csv << data.attributes.values_at(*Datum.column_names)
         
          csv << [id ,sourceWebsite ,name ,picture ,politicalParty ,politicalPartyImage ,verified ,likes ,followers ,email ,twitter ,facebook ,linkedin ,googlePlus ,instagram ,blog ,youtubeChannel ,premium ,bio ,quote1 ,quote2 ,sourceActivity ,lastActivity1 ,lastActivity2 ,lastActivity3 ,lastActivity4 ,ideology1 ,ideology2 ,ideology3 ,ideology4 ,ideology5 ,following ,openProjects ,closedProjects ,proposals ,debates ,sponsorships ,victories ,dateOfBirth ,placeOfBirth ,institutionalAddress ,institutionalTelephone ,institutionalFax ,institutionalMobilePhone ,electoralAddress ,electoralTelephone ,electoralFax ,electoralMobile ,phone ,assistants ,completeName ,position ,region ,institution ,constituency ,studies ,university ,profession ,cvLink ,declarationLink ,officialWebsite ,politicalExperience ,causes ,region_code_alliance ,region_code_nation ,region_code_state ,region_code_county ,region_code_city ,constituency_code_alliance ,constituency_code_nation ,constituency_code_state ,constituency_code_county ,constituency_code_city ,political_leaning_index ,cause1 ,cause2 ,cause3 ,cause4 ,cause5 ,known_for1 ,known_for2 ,known_for3 ,known_for4 ,known_for5 ,known_for_link1 ,known_for_link2 ,known_for_link3 ,known_for_link4 ,known_for_link5 ,lastActivity5 ,lastActivity1Date ,lastActivity2Date ,lastActivity3Date ,lastActivity4Date ,lastActivity5Date ,lastActivity1Action ,lastActivity2Action ,lastActivity3Action ,lastActivity4Action ,lastActivity5Action ,lastActivity1Outcome ,lastActivity2Outcome ,lastActivity3Outcome ,lastActivity4Outcome ,lastActivity5Outcome ,political_experience1 ,political_experience2 ,political_experience3 ,political_experience4 ,political_experience5 ,political_experience1_content ,political_experience2_content ,political_experience3_content ,political_experience4_content ,political_experience5_content ,political_experience1_date ,political_experience2_date ,political_experience3_date ,political_experience4_date ,political_experience5_date ,school ,family ,pinterest ,gender, region_id, lastActivity1Link, lastActivity2Link, lastActivity3Link, lastActivity4Link, lastActivity5Link]

         end
    end         
  
   send_data csv_string,
   :type => 'text/csv; charset=iso-8859-1; header=present',
   :disposition => "attachment; filename=politicians.csv" 

  end  


 # def scrape
  #  region_id = params[:region_id]

   # region = Region.find(region_id)
   # region_code = region.iso3166_2 

   # region_file_name = region_code.gsub("-", "_")
    
   # scrape_script = 'scraper_' +  region_file_name
   # scrape_update_script = 'scraper_update_' +  region_file_name

   # region_scraped = region.scraped

   # if (region_scraped == false)
   #   puts "running scrape script..."
   #   %x[rake #{scrape_script}]
   # else
    #  puts "running update script..."
     # %x[rake #{scrape_update_script}]
   # end
    
   # redirect_to :back  
#  end 


end

