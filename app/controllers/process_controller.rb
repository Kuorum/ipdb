class ProcessController < ApplicationController

  def download_csv()
    
    region_id = params[:region_id]
    @datum = Datum.where(:region_id => region_id)

    region = ""

    csv_string = CSV.generate do |csv|
         #csv << Datum.column_names
         csv << ["id","sourceWebsite","name","picture","politicalParty","politicalPartyImage","verified","likes","followers","email","twitter","facebook","linkedin","googlePlus","instagram","blog","youtubeChannel","premium","bio","quote1","quote2","sourceActivity","lastActivity1","lastActivity2","lastActivity3","lastActivity4","ideology1","ideology2","ideology3","ideology4","ideology5","following","openProjects","closedProjects","proposals","debates","sponsorships","victories","dateOfBirth","placeOfBirth","institutionalAddress","institutionalTelephone","institutionalFax","institutionalMobilePhone","electoralAddress","electoralTelephone","electoralFax","electoralMobile","phone","assistants","completeName","position","region","institution","constituency","studies","university","profession","cvLink","declarationLink","officialWebsite","politicalExperience","causes","region_code_alliance","region_code_nation","region_code_state","region_code_county","region_code_city","constituency_code_alliance","constituency_code_nation","constituency_code_state","constituency_code_county","constituency_code_city","political_leaning_index","cause1","cause2","cause3","cause4","cause5","cause6","known_for1","known_for2","known_for3","known_for4","known_for5","known_for_link1","known_for_link2","known_for_link3","known_for_link4","known_for_link5","lastActivity5","lastActivity1Date","lastActivity2Date","lastActivity3Date","lastActivity4Date","lastActivity5Date","lastActivity1Action","lastActivity2Action","lastActivity3Action","lastActivity4Action","lastActivity5Action","lastActivity1Outcome","lastActivity2Outcome","lastActivity3Outcome","lastActivity4Outcome","lastActivity5Outcome","political_experience1","political_experience2","political_experience3","political_experience4","political_experience5","political_experience1_content","political_experience2_content","political_experience3_content","political_experience4_content","political_experience5_content","political_experience1_date","political_experience2_date","political_experience3_date","political_experience4_date","political_experience5_date","school","family","pinterest","gender","region_id","lastActivity1Link","lastActivity2Link","lastActivity3Link","lastActivity4Link","lastActivity5Link","news1date","news2date","news3date","news4date","news5date","news1title","news2title","news3title","news4title","news5title","news1content","news2content","news3content","news4content","news5content","news1link","news2link","news3link","news4link","news5link","news1picture","news2picture","news3picture","news4picture","news5picture"]
         
         @datum.each do |data|

          id = data.id
          sourceWebsite = data.sourceWebsite
          name = data.name
          picture = data.picture
          politicalParty = data.politicalParty

          party_image = ""  
          leaning_index = 0.5
          ideology1 = 0.5
          ideology2 = 0.5
          ideology3 = 0.5
          ideology4 = 0.5
          ideology5 = 0.5

          party_name = ""

          if data.politicalParty != ""
            political_party = PoliticalParty.where("name = ?",  "#{data.politicalParty}")
            political_party.each do |pp|
              
              if data.politicalPartyImage != "" && !data.politicalPartyImage.blank? 
                party_image = data.politicalPartyImage
              else
                party_image = pp.image
              end

              if data.political_leaning_index != "" && !data.political_leaning_index.blank? 
                leaning_index = data.political_leaning_index        
              else
                leaning_index = pp.leaning_index
              end

              if data.ideology1 != "" && !data.ideology1.blank?
                ideology1 = data.ideology1
              else
                ideology1 = pp.leaning_index  
              end  

              if data.ideology2 != "" && !data.ideology2.blank?
                ideology2 = data.ideology2
              else
                ideology2 = pp.leaning_index  
              end 

              if data.ideology3 != "" && !data.ideology3.blank?
                ideology3 = data.ideology3
              else
                ideology3 = pp.leaning_index  
              end 

              if data.ideology4 != "" && !data.ideology4.blank?
                ideology4 = data.ideology4
              else
                ideology4 = pp.leaning_index  
              end 

              if data.ideology5 != "" && !data.ideology5.blank?
                ideology5 = data.ideology5
              else
                ideology5 = pp.leaning_index  
              end 
              
            end  
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
          
          region_code_alliance = ""  
          if data.region_code_alliance != "" && !data.region_code_alliance.nil?
            region_code_alliance = data.region_code_alliance.reverse[0..1].reverse
          end
          
          region_code_nation = ""
          if data.region_code_nation != "" && !data.region_code_nation.nil?
            region_code_nation = data.region_code_nation.reverse[0..1].reverse
          end

          region_code_state = ""
          if data.region_code_state != "" && !data.region_code_state.nil?
            region_code_state = data.region_code_state.reverse[0..1].reverse
          end

          region_code_county = ""
          if data.region_code_county != "" && !data.region_code_county.nil?
            region_code_county = data.region_code_county.reverse[0..1].reverse
          end

          region_code_city = ""
          if data.region_code_city != "" && !data.region_code_city.nil?
            region_code_city = data.region_code_city.reverse[0..1].reverse
          end

          constituency_code_alliance = ""
          if data.constituency_code_alliance != "" && !data.constituency_code_alliance.nil?
            constituency_code_alliance = data.constituency_code_alliance.reverse[0..1].reverse
          end

          constituency_code_nation = ""
          if data.constituency_code_nation != "" && !data.constituency_code_nation.nil?
            constituency_code_nation = data.constituency_code_nation.reverse[0..1].reverse
          end

          constituency_code_state = ""
          if data.constituency_code_state != "" && !data.constituency_code_state.nil?
            constituency_code_state = data.constituency_code_state.reverse[0..1].reverse
          end

          constituency_code_county = ""
          if data.constituency_code_county != "" && !data.constituency_code_county.nil?
            constituency_code_county = data.constituency_code_county.reverse[0..1].reverse
          end

          constituency_code_city = ""
          if data.constituency_code_city != "" && !data.constituency_code_city.nil?
            constituency_code_city = data.constituency_code_city.reverse[0..1].reverse
          end


          political_leaning_index = data.political_leaning_index
          cause1 = data.cause1
          cause2 = data.cause2
          cause3 = data.cause3
          cause4 = data.cause4
          cause5 = data.cause5
          cause6 = data.cause6
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

          news1date = data.news1date
          news2date = data.news2date
          news3date = data.news3date
          news4date = data.news4date
          news5date = data.news5date
          news1title = data.news1title
          news2title = data.news2title
          news3title = data.news3title
          news4title = data.news4title
          news5title = data.news5title
          news1content = data.news1content
          news2content = data.news2content
          news3content = data.news3content
          news4content = data.news4content
          news5content = data.news5content
          news1link = data.news1link
          news2link = data.news2link
          news3link = data.news3link
          news4link = data.news4link
          news5link = data.news5link
          news1picture = data.news1picture
          news2picture = data.news2picture
          news3picture = data.news3picture
          news4picture = data.news4picture
          news5picture  = data.news5picture        


          #csv << data.attributes.values_at(*Datum.column_names)
         
          csv << [id ,sourceWebsite ,name ,picture ,politicalParty ,politicalPartyImage ,verified ,likes ,followers ,email ,twitter ,facebook ,linkedin ,googlePlus ,instagram ,blog ,youtubeChannel ,premium ,bio ,quote1 ,quote2 ,sourceActivity ,lastActivity1 ,lastActivity2 ,lastActivity3 ,lastActivity4 ,ideology1 ,ideology2 ,ideology3 ,ideology4 ,ideology5 ,following ,openProjects ,closedProjects ,proposals ,debates ,sponsorships ,victories ,dateOfBirth ,placeOfBirth ,institutionalAddress ,institutionalTelephone ,institutionalFax ,institutionalMobilePhone ,electoralAddress ,electoralTelephone ,electoralFax ,electoralMobile ,phone ,assistants ,completeName ,position ,region ,institution ,constituency ,studies ,university ,profession ,cvLink ,declarationLink ,officialWebsite ,politicalExperience ,causes ,region_code_alliance ,region_code_nation ,region_code_state ,region_code_county ,region_code_city ,constituency_code_alliance ,constituency_code_nation ,constituency_code_state ,constituency_code_county ,constituency_code_city ,political_leaning_index ,cause1 ,cause2 ,cause3 ,cause4 ,cause5, cause6 ,known_for1 ,known_for2 ,known_for3 ,known_for4 ,known_for5 ,known_for_link1 ,known_for_link2 ,known_for_link3 ,known_for_link4 ,known_for_link5 ,lastActivity5 ,lastActivity1Date ,lastActivity2Date ,lastActivity3Date ,lastActivity4Date ,lastActivity5Date ,lastActivity1Action ,lastActivity2Action ,lastActivity3Action ,lastActivity4Action ,lastActivity5Action ,lastActivity1Outcome ,lastActivity2Outcome ,lastActivity3Outcome ,lastActivity4Outcome ,lastActivity5Outcome ,political_experience1 ,political_experience2 ,political_experience3 ,political_experience4 ,political_experience5 ,political_experience1_content ,political_experience2_content ,political_experience3_content ,political_experience4_content ,political_experience5_content ,political_experience1_date ,political_experience2_date ,political_experience3_date ,political_experience4_date ,political_experience5_date ,school ,family ,pinterest ,gender, region_id, lastActivity1Link, lastActivity2Link, lastActivity3Link, lastActivity4Link, lastActivity5Link, news1date, news2date, news3date, news4date, news5date, news1title, news2title, news3title, news4title, news5title, news1content, news2content, news3content, news4content, news5content, news1link, news2link, news3link, news4link, news5link, news1picture, news2picture, news3picture, news4picture, news5picture]

         end
    end         

   date = Time.now.strftime("%Y%m%d")
   region = Region.find(region_id)
   region_name = region.name.titleize
  
   send_data csv_string,
   :type => 'text/csv; charset=iso-8859-1; header=present',
   :disposition => "attachment; filename=#{date}_#{region_name}.csv" 

  end  


  def scrape
   #region_id = params[:region_id]

   #region = Region.find(region_id)
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
    
    redirect_to :back  
  end 


end

