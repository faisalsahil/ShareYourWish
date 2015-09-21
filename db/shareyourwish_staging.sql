-- phpMyAdmin SQL Dump
-- version 3.5.2.2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Feb 21, 2013 at 09:20 AM
-- Server version: 5.0.77
-- PHP Version: 5.2.17

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `shareyourwish_staging`
--

-- --------------------------------------------------------

--
-- Table structure for table `active_admin_comments`
--

CREATE TABLE IF NOT EXISTS `active_admin_comments` (
  `id` int(11) NOT NULL auto_increment,
  `resource_id` varchar(255) collate utf8_unicode_ci NOT NULL,
  `resource_type` varchar(255) collate utf8_unicode_ci NOT NULL,
  `author_id` int(11) default NULL,
  `author_type` varchar(255) collate utf8_unicode_ci default NULL,
  `body` text collate utf8_unicode_ci,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `namespace` varchar(255) collate utf8_unicode_ci default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_active_admin_comments_on_author_type_and_author_id` (`author_type`,`author_id`),
  KEY `index_active_admin_comments_on_namespace` (`namespace`),
  KEY `index_admin_notes_on_resource_type_and_resource_id` (`resource_type`,`resource_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `addresses`
--

CREATE TABLE IF NOT EXISTS `addresses` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) NOT NULL,
  `first_name` varchar(255) collate utf8_unicode_ci default NULL,
  `last_name` varchar(255) collate utf8_unicode_ci default NULL,
  `company_name` varchar(255) collate utf8_unicode_ci default NULL,
  `address_1` varchar(255) collate utf8_unicode_ci default NULL,
  `address_2` varchar(255) collate utf8_unicode_ci default NULL,
  `city` varchar(255) collate utf8_unicode_ci default NULL,
  `state_id` int(11) default NULL,
  `postal_code` varchar(255) collate utf8_unicode_ci default NULL,
  `atype` varchar(255) collate utf8_unicode_ci default 'mailing',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=4 ;

--
-- Dumping data for table `addresses`
--

INSERT INTO `addresses` (`id`, `user_id`, `first_name`, `last_name`, `company_name`, `address_1`, `address_2`, `city`, `state_id`, `postal_code`, `atype`) VALUES
(1, 1, 'Joe', 'TwoToes', '', '4 bleh', '', 'dingtown', 44, '12121', 'shipping'),
(2, 1, 'Tree', 'Top', '', 'The Forest', '', 'Place', 44, '44333', 'shipping'),
(3, 2, 'asd', 'asd', 'asd', 'asd', 'asd', 'asd', 28, '10000', 'mailing');

-- --------------------------------------------------------

--
-- Table structure for table `admin_users`
--

CREATE TABLE IF NOT EXISTS `admin_users` (
  `id` int(11) NOT NULL auto_increment,
  `email` varchar(255) collate utf8_unicode_ci NOT NULL default '',
  `encrypted_password` varchar(255) collate utf8_unicode_ci NOT NULL default '',
  `reset_password_token` varchar(255) collate utf8_unicode_ci default NULL,
  `reset_password_sent_at` datetime default NULL,
  `remember_created_at` datetime default NULL,
  `sign_in_count` int(11) default '0',
  `current_sign_in_at` datetime default NULL,
  `last_sign_in_at` datetime default NULL,
  `current_sign_in_ip` varchar(255) collate utf8_unicode_ci default NULL,
  `last_sign_in_ip` varchar(255) collate utf8_unicode_ci default NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `index_admin_users_on_email` (`email`),
  UNIQUE KEY `index_admin_users_on_reset_password_token` (`reset_password_token`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=5 ;

--
-- Dumping data for table `admin_users`
--


-- --------------------------------------------------------

--
-- Table structure for table `authentications`
--

CREATE TABLE IF NOT EXISTS `authentications` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) default NULL,
  `provider` varchar(255) collate utf8_unicode_ci default NULL,
  `uid` varchar(255) collate utf8_unicode_ci default NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `token` varchar(255) collate utf8_unicode_ci default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

--
-- Dumping data for table `authentications`
--

INSERT INTO `authentications` (`id`, `user_id`, `provider`, `uid`, `created_at`, `updated_at`, `token`) VALUES
(1, 22, 'facebook', '1316763679', '2012-11-29 18:21:55', '2012-11-29 18:21:55', 'AAACTYWneE5kBAFQzucZCusLm4cdOZC0QggwQvxZCZBpk21qTLRXhLqNq5COmEbmynu49C6HOof9uH5IxZAGDQbmuVD1uzLC2nw2LflttcvQZDZD');

-- --------------------------------------------------------

--
-- Table structure for table `carts`
--

CREATE TABLE IF NOT EXISTS `carts` (
  `id` int(11) NOT NULL auto_increment,
  `event_id` int(11) default NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `user_id` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_carts_on_event_id` (`event_id`),
  KEY `index_carts_on_user_id` (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=104 ;

--
-- Dumping data for table `carts`
--

INSERT INTO `carts` (`id`, `event_id`, `created_at`, `updated_at`, `user_id`) VALUES
(96, 40, '2012-10-02 20:46:35', '2012-10-02 20:46:35', 2),
(97, 30, '2012-10-05 22:26:42', '2012-10-05 22:26:43', 1),
(98, 41, '2012-11-01 12:23:04', '2012-11-01 12:23:04', 5),
(99, 42, '2012-12-18 20:33:17', '2012-12-18 20:33:17', 1),
(100, 43, '2012-12-30 17:11:03', '2012-12-30 17:11:03', 23),
(101, 44, '2013-01-12 14:51:25', '2013-01-12 14:51:26', 3),
(102, 45, '2013-01-15 00:48:36', '2013-01-15 00:48:36', 1),
(103, 46, '2013-01-15 01:04:07', '2013-01-15 01:04:07', 1);

-- --------------------------------------------------------

--
-- Table structure for table `carts_archive`
--

CREATE TABLE IF NOT EXISTS `carts_archive` (
  `id` int(11) NOT NULL auto_increment,
  `event_id` int(11) default NULL,
  `item_id` int(11) default NULL,
  `quantity` int(11) default NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `charities`
--

CREATE TABLE IF NOT EXISTS `charities` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) collate utf8_unicode_ci default NULL,
  `name_alias` varchar(255) collate utf8_unicode_ci default NULL,
  `description` text collate utf8_unicode_ci,
  `city` varchar(255) collate utf8_unicode_ci default NULL,
  `region` varchar(255) collate utf8_unicode_ci default NULL,
  `website_url` varchar(255) collate utf8_unicode_ci default NULL,
  `lookup_charity_code_id` varchar(255) collate utf8_unicode_ci default NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `featured` tinyint(1) default '0',
  `top_recommended` tinyint(1) default '0',
  `syw_altkey` varchar(255) collate utf8_unicode_ci default NULL,
  `vendor1_altkey` varchar(255) collate utf8_unicode_ci default NULL,
  `vendor2_altkey` varchar(255) collate utf8_unicode_ci default NULL,
  `temp_icon_filename` varchar(255) collate utf8_unicode_ci default NULL,
  `deleted_at` datetime default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `index_charities_syw_altkey_uq` (`syw_altkey`),
  UNIQUE KEY `index_charities_vendor1_altkey_uq` (`vendor1_altkey`),
  UNIQUE KEY `index_charities_vendor2_altkey_uq` (`vendor2_altkey`),
  KEY `index_charities_on_name_alias` (`name_alias`),
  KEY `index_charities_on_ntee_code` (`lookup_charity_code_id`),
  KEY `index_charities_on_featured` (`featured`),
  KEY `index_charities_on_top_recommended` (`top_recommended`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=179 ;

--
-- Dumping data for table `charities`
--

INSERT INTO `charities` (`id`, `name`, `name_alias`, `description`, `city`, `region`, `website_url`, `lookup_charity_code_id`, `created_at`, `updated_at`, `featured`, `top_recommended`, `syw_altkey`, `vendor1_altkey`, `vendor2_altkey`, `temp_icon_filename`, `deleted_at`) VALUES
(98, '"I Have a Dream" Foundation"', '', '"Founded in 1986 by businessman Eugene M. Lang, the ""I Have A Dream"" Foundation empowers children in low-income communities to achieve higher education and fulfill their leadership potential by providing them with guaranteed tuition support and equipping them with the skills, knowledge, and habits they need to gain entry to higher education and succeed in college and beyond. By helping our Dreamers gain access to college, we are putting our Dreamers on a different academic and life trajectory. We sponsor entire grade levels of 50-100 students in under-resourced public schools or housing developments and work with these Dreamers from early elementary school all the way through high school. Upon high school graduation, each Dreamer receives guaranteed tuition assistance for higher education."', '', 'U.S.', '', '2', '0000-00-00 00:00:00', '2012-09-28 16:56:32', 0, 0, '10156', NULL, NULL, 'IHaveADreamFoundation.gif', NULL),
(99, 'Advocates for Children of New York', NULL, '"Advocates for Children (AFC) of New York promotes access to the best education New York can provide for all students, especially students of color and students from low-income backgrounds. We use uniquely integrated strategies to advance systemic reform, empower families and communities, and advocate for the educational rights of individual students. Our services include individual case advocacy, a helpline to assist parents and professionals, and workshops."', NULL, 'U.S.', NULL, '6', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 1, '10130', NULL, NULL, 'AdvocatesForChildrenofNewYork.jpeg', NULL),
(100, 'ALSAC - St. Jude Children''s Research Hospital', NULL, '"ALSAC (American Lebanese Syrian Associated Charities) was founded in 1957 and exists for the sole purpose of raising funds to support the operating and maintenance of St. Jude Children''s Research Hospital. The mission of St. Jude Children''s Research Hospital is to find cures for children with cancer and other catastrophic diseases through research and treatment. It is supported primarily by donations raised by ALSAC. Research efforts are directed at understanding the molecular, genetic and chemical bases of catastrophic diseases in children; identifying cures for such diseases; and promoting their prevention. Research is focused specifically on cancers, some acquired and inherited immunodeficiencies, sickle cell disease, infectious diseases and genetic disorders."', NULL, 'U.S.', NULL, '7', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 1, '10125', NULL, NULL, 'ALSACSt. JudesChildrensResearchHospital.jpg', NULL),
(101, 'Alex''s Lemonade Stand', '', 'Alex''s Lemonade Stand Foundation (ALSF) shares the vision of our founder and creator, Alexandra "Alex" Scott - a cure for all children with cancer. Alex''s Lemonade Stand Foundation was started by her parents in 2005 to continue the work that Alex began. Our mission is simple: to raise money for and awareness of childhood cancer cause - especially research into new treatments and cures - and to encourage and educate others, especially children, to get involved and make a difference for children with cancer. The money we''ve raised has helped us to: fund more than 150 cutting-edge research projects; create a travel program to help support families of children receiving treatment; and develop resources to help people everywhere touched by childhood cancer.\r\n', '', 'U.S.', NULL, '7', '0000-00-00 00:00:00', '2012-09-14 15:59:14', 0, 1, '10178', NULL, NULL, 'AlexsLemonadeStand.jpg', NULL),
(102, 'America SCORES', NULL, '"America SCORES empowers students in urban communities using soccer, writing, creative expression, and service-learning. With teamwork as the unifying value, we inspire youth to lead healthy lifestyles, be engaged students, and become agents of change in their communities. We develop programs that use the world''s most popular sport, soccer, to energize and inspire public school students. All of our programs require that our children use the teamwork they learn on the soccer field to support each other as poets and authors in the classroom. The combination is unique and it works. Every day, SCORES programs are creating a bond between thousands of our students and their classmates, their teachers, their schools and their communities."', NULL, 'U.S.', NULL, '10', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 1, '10131', NULL, NULL, 'AmericaSCORES.jpg', NULL),
(103, 'American Cancer Society', NULL, '"Founded in 1913 by 15 well-known doctors and business leaders in New York City, the American Cancer Society (ACS) is the nationwide community-based voluntary health organization dedicated to eliminating cancer as a major health problem by preventing cancer, saving lives, and diminishing suffering from cancer, through research, education, advocacy, and service. The American Cancer Society consists of a National Home Office with 13 chartered Divisions throughout the United States and a presence in most communities. More than two million volunteers carry out the Society''s mission of eliminating cancer and improving quality of life for those individuals facing the disease."', NULL, 'U.S.', NULL, '5', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 1, '10105', NULL, NULL, 'AmericanCancerSociety.jpg', NULL),
(104, 'American Foundation for Disabled Children', NULL, '"Founded in 1991, the American Foundation for Disabled Children works to encourage and maximize the development, productively, dignity and social interaction of challenged and disadvantaged children within society at large. Our programs include: resources for homeless and challenged children; Braille and large print books for the visually challenged; and camps and outdoor experiences."', NULL, 'U.S.', NULL, '8', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 1, '10132', NULL, NULL, 'AmericanFoundationForDisabledChildren.gif', NULL),
(105, 'American Red Cross', NULL, '"Since its founding in 1881 by visionary leader Clara Barton, the American Red Cross has been the nation''s premier emergency response organization. As part of a worldwide movement that offers neutral humanitarian care to the victims of war, the American Red Cross distinguishes itself by also aiding victims of devastating natural disasters. Over the years, the organization has expanded its services, always with the aim of preventing and relieving suffering. Today, in addition to domestic disaster relief, the American Red Cross offers compassionate services in five other areas: community services that help the needy; support and comfort for military members and their families; the collection, processing and distribution of lifesaving blood and blood products; educational programs that promote health and safety; and international relief and development programs."', NULL, 'U.S.', NULL, '1', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 1, '10101', NULL, NULL, 'AmericanRedCross.jpg', NULL),
(106, 'Association to Benefit Children', NULL, '"Association to Benefit Children (ABC) is dedicated to bringing joy and warmth to disadvantaged children and their families through compassionate, sustainable, comprehensive and integrated services, designed to permanently break the cycles of abuse, neglect, sickness and homelessness. ABC''s humane and innovative programs include early educational advocacy, housing assistance, mental health services, family support and preservation, crisis intervention, therapeutic out-of-school and summer day camp programs, youth leadership development and mentoring."', NULL, 'U.S.', NULL, '9', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 1, '10133', NULL, NULL, 'AssociationToBenefitChildren.jpg', NULL),
(107, 'Baby Buggy', NULL, '"Baby Buggy is dedicated to providing New York City''s (NYC) families in need with essential equipment, clothing, and products for their infants and young children. Since 2001, Baby Buggy has delivered over 3,500,000 essential items to thousands of families through our network of over 50 qualified social service partners. Today, over 500,000 children live in poverty in NYC. Baby Buggy''s goal is to help them access the essentials they need to ensure their safety and well-being. By providing concrete resources to their families through our network of social service professionals, we help alleviate the stress of living in poverty, and we help prevent crisis."', NULL, 'U.S.', NULL, '3', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 1, '10123', NULL, NULL, 'BabyBuggy.jpg', NULL),
(108, 'Big Brothers Big Sisters of America', NULL, '"Big Brothers Big Sisters, the nation''s largest donor and volunteer supported mentoring network, holds itself accountable for children in its program to achieve measurable outcomes, including educational success; avoidance of risky behaviors; and higher aspirations, greater confidence and better relationships. Partnering with parents/guardians, schools, corporations and others in the community, Big Brothers Big Sisters carefully pairs children (""Littles"") with screened volunteer mentors (""Bigs"") and monitors and supports these one-to-one mentoring matches in building safe, enduring relationships. The first-ever Big Brothers Big Sisters Youth Outcomes Summary, released in 2012, substantiates that its mentoring programs have proven, positive academic, socio-emotional and behavioral outcomes for youth, areas linked to high school graduation, avoidance of juvenile delinquency and college or job readiness."', NULL, 'U.S.', NULL, '11', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 1, '10135', NULL, NULL, 'BigBrothersBigSistersOfAmerica.jpg', NULL),
(109, 'Big Brothers Big Sisters of NYC', NULL, '"Formed in 1904, Big Brothers Big Sisters of New York City (BBBS NYC) provide mentors to all children who need caring adult role models - special friends who can help expand their horizons, realize their potential and enrich their futures - changing their lives. We seek to train community organizations in every neighborhood, empowering them to establish their own mentoring programs. BBBS NYC offers unique programs, tailored to fit the needs of a diverse pool of youth, including teenage mothers, children with developmental disabilities, or new Americans, as well as a diverse pool of volunteers, including corporate employees and seniors. BBBS NYC remains committed to expanding services, developing ideas, and making history, until every boy and girl who needs a mentor has a Big of his or her own."', NULL, 'U.S.', NULL, '8', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 1, '10134', NULL, NULL, 'BigBrothersBigSistersofNYC.jpg', NULL),
(110, 'Camp Good Days and Special Times', NULL, '"Founded in 1979, Camp Good Days and Special Times is dedicated to improving the quality of life for children, adults and families whose lives have been touched by cancer and other life challenges. All of the programs and services provided by Camp Good Days are offered free of charge for the participants. Camp Good Days provides residential camping programs at our beautiful recreational facility, located on the shores of Keuka Lake in Branchport, New York, as well as year-round recreational and support activities, in the Rochester, Buffalo & Syracuse, New York and Central Florida areas for the entire family. At Camp Good Days, participants have the opportunity to regain some of what cancer, sickle cell anemia, HIV/AIDS, or violence has taken away from them."', NULL, 'U.S.', NULL, '15', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 1, '10136', NULL, NULL, 'CARE.jpg', NULL),
(111, 'CARE', NULL, '"Founded in 1945, CARE is a leading humanitarian organization fighting global poverty. Our mission is to serve individuals and families in the poorest communities in the world. Drawing strength from our global diversity, resources and experience, we promote innovative solutions and are advocates for global responsibility. We facilitate lasting change by: strengthening capacity for self-help; providing economic opportunity; delivering relief in emergencies; influencing policy decisions at all levels; and addressing discrimination in all its forms. We place special focus on working alongside poor women because, equipped with the proper resources, women have the power to help whole families and entire communities escape poverty."', NULL, 'U.S.', NULL, '9', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 1, '10109', NULL, NULL, 'CampGoodDaysAndSpecialTimes.jpg', NULL),
(112, 'Center for Arts Education', NULL, '"Established in 1996, the Center for Arts Education (CAE) is committed to stimulating and sustaining quality arts education as an essential part of every child''s education in the New York City public schools. CAE provides information and resources that demonstrate the benefits of and need for arts education as part of a quality, balanced education. CAE also identifies and supports exemplary partnerships and programs that demonstrate how the arts contribute to learning and student achievement. CAE is dedicated to influencing educational and fiscal policies that will support arts education in all of the city''s public schools."', NULL, 'U.S.', NULL, '12', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 1, '10137', NULL, NULL, 'CenterForArtsEducation.jpg', NULL),
(113, 'Chess-in-the-Schools', NULL, '"Chess-in-the-Schools is dedicated to improving academic performance and building self-esteem among inner-city public school children. Since 1986, Chess-in-the-Schools has taught, inspired, and empowered more than 450,000 students in New York City public schools. All schools served by Chess-in-the-Schools are classified as Title I. In these schools, more than 40% of the students are eligible for free or reduced cost lunch (an indicator of socio-economic disadvantage.) Through structured classroom, after-school, weekend, and summer programs, we use chess as an educational tool to promote learning and to help young people develop skills in critical thinking and problem solving."', NULL, 'U.S.', NULL, '13', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '10138', NULL, NULL, 'ChessInTheSchools.jpg', NULL),
(114, 'Childhood Leukemia Foundation', NULL, '"Founded in 1992, the mission of the Childhood Leukemia Foundation (CLF) is to lift the spirit and enhance the quality of life of children suffering with cancer. Our goal is to make sure children battling cancer know they are not alone. All of our programs have been designed to: educate and entertain; provide a sense of physical normalcy and help raise self esteem; encourage physical participation and therapeutic play; maintain a communications lifeline; and provide care management tools. CLF works with more than 140 specialized treatment centers. The organization serves over 15,000 children nationwide with free program and service offerings for childhood cancer patients and their families."', NULL, 'U.S.', NULL, '3', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '10142', NULL, NULL, 'ChildhoodLeukemiaFoundation.jpeg', NULL),
(115, 'Children for Children', NULL, '"Children for Children (CFC) was founded in 1996 by parents concerned that many New York City children were growing up without meaningful, accessible opportunities to become engaged in their greater community from an early age despite the powerful individual and societal benefits afforded by youth service. CFC fosters community involvement and social responsibility in young people, offers opportunities for young people from preschool through high school to grow involved, through hands-on service and philanthropy programs that teach the value of volunteering and giving. CFC''s programs accommodate a wide range of ages, abilities, interests and busy schedules just right for kids, families, schools, educators and other community youth organizations."', NULL, 'U.S.', NULL, '15', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '10139', NULL, NULL, 'ChildrenForChildren(Generation On).jpeg', NULL),
(116, 'Children''s Brain Tumor Foundation', NULL, '"Children''s Brain Tumor Foundation was founded in 1988 by dedicated parents, physicians and friends. Our mission is to improve the treatment, quality of life and the long term outlook for children with brain and spinal cord tumors through research, support, education, and advocacy to families and survivors. Knowledge is critical for families to access expert care and ensure quality of life. Our free publication ''A Resource Guide for Parents of Children with Brain and Spinal Cord Tumors'' is now in its fourth edition, and is full of practical information to sort out the complexities of medical procedures, interruptions in school and social life, and uncertainty about the future. We also offer a toll-free support line, parent to parent network, and we host and sponsor events which offer families fun while building relationships within the community."', NULL, 'U.S.', NULL, '14', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '10140', NULL, NULL, 'ChildrensBrainTumorFoundation.jpg', NULL),
(117, 'Children''s Cancer & Blood Foundation', NULL, '"The Children''s Cancer and Blood Foundation (CCBF), through its support of the Division of Pediatric Hematology and Oncology at the New York - Presbyterian Hospital Weill Cornell Medical Center, has created a standard of excellence in the treatment of children with chronic, life-threatening blood disorders since 1952. Children and their families receive the most advanced, comprehensive care provided by a team of pediatric specialists in an atmosphere of compassion, hope and wellness. Since our founding, CCBF funding has helped revolutionize the treatment of children suffering from cancers and childhood blood disorders."', NULL, 'U.S.', NULL, '10', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '10141', NULL, NULL, 'ChildrensCancerAndBloodFoundation.jpg', NULL),
(118, 'Children''s Museum of Manhattan', NULL, '"The mission of the Children''s Museum of Manhattan (CMOM) is to inspire children and families to learn about themselves and our culturally diverse world through a unique environment of interactive exhibitions and programs. Last year, CMOM served more than 350,000 people, which included 65,000 children who visited the Museum as part of a school group or through one of the Museum''s off-site partners. CMOM is committed to making its exhibits and programs available to all, and with nearly 50 sites around New York City, we continually reach thousands of families who might not otherwise be able to benefit from our services. CMOM''s four priority areas are meant to impact children in ways that will last a lifetime: early childhood education; creativity in the arts and sciences; healthy lifestyles; and the exploration of world cultures."', NULL, 'U.S.', NULL, '9', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '10143', NULL, NULL, 'ChildrensMuseumOfManhattan.jpg', NULL),
(119, 'Children''s Rights', NULL, '"Children''s Rights is a national advocacy group working to reform America''s failing child welfare systems on behalf of the abused and neglected children who depend on them for protection. Since 1995, Children''s Rights has been fighting to enshrine in the law of the land every child''s right to be protected from abuse and neglect and to grow up in a safe, stable, permanent home. Through tough legal action complemented by substantive policy expertise, we have won landmark victories and brought about sweeping improvements in the lives of abused and neglected children in more than a dozen states across the nation."', NULL, 'U.S.', NULL, '2', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '10144', NULL, NULL, 'ChildrensRights.jpg', NULL),
(120, 'Children''s Scholarship Fund', NULL, '"Founded in 1998, the Children''s Scholarship Fund (CSF) provides partial tuition assistance for low-income families to send their children to private schools. Currently, almost 25,500 children nationwide are using CSF scholarships. These children are attending private school through the generosity of our donors, the efforts of 29 scholarship programs, and the sacrifices made by the families themselves, who pay, on average, 50% of their children''s tuition. CSF provides scholarships for children grades Kindergarten - 8th grade. The Fund focuses on elementary education because the earlier a child receives sound schooling, the better. Scholarships are awarded to all eligible children in a family to attend the school or schools of their choice."', NULL, 'U.S.', NULL, '8', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '10145', NULL, NULL, 'ChildrensScholarshipFund.png', NULL),
(121, 'Christopher and Dana Reeve Foundation', NULL, '"The Christopher and Dana Reeve Foundation is dedicated to curing spinal cord injury by funding innovative research, and improving the quality of life for people living with paralysis through grants, information and advocacy. In 1995, when Christopher Reeve was injured, the American Paralysis Association (APA) was one of the first places that he and Dana turned to. Christopher had formed his own foundation, but in 1999, they came together as the Christopher Reeve Foundation. Today, the Foundation is recognized as the premier spinal cord injury research organization throughout the world. Through the Reeve Foundation''s persistence and promise, neuroscientists around the world agree that repairing the damaged spinal cord is not a question of if, but a question of when."', NULL, 'U.S.', NULL, '18', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 1, '10118', NULL, NULL, 'ChristopherAndDanaReeveFoundation.jpg', NULL),
(122, '"Classroom, Inc."', NULL, '"Classroom, Inc.''s innovative curriculum engages students with the greatest needs and helps them develop academic skills essential for success in school and the workplace. Since 1991, our programs have been in over 700 sites in 15 states, and we have served over 600,000 students. Classroom, Inc.''s content-rich instructional programs turn classrooms into learning environments that motivate students through innovative teaching methods and materials based on the idea that young people learn better when they are compelled by their work. We develop computer software simulations that place students in virtual workplaces, create print curriculum materials corresponding to each simulation, and provide a comprehensive professional development program that helps teachers to effectively integrate our curriculum into their classroom instruction."', NULL, 'U.S.', NULL, '14', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '10146', NULL, NULL, 'ClassroomInc..jpg', NULL),
(123, 'Computers for Youth', NULL, '"Founded in 1999, Computers for Youth (CFY) is a national educational organization dedicated to improving the home learning environment of low-income school children. Our work is built on the belief that the home holds the greatest untapped potential for improving children''s academic and life-long success. CFY partners with schools to improve the educational resources available in children''s homes, enhance parent-child interaction around learning and help teachers make powerful links between the classroom and the home. Our computer-based home learning centers are designed by software experts and tested by students and education executives from around the country. Since beginning operations in 1999, CFY has served more than 20,000 families."', NULL, 'U.S.', NULL, '12', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '10147', NULL, NULL, 'ComputersForYouth.png', NULL),
(124, 'Disabled American Veterans Charitable Serivce Trust', NULL, '"The Disabled American Veterans (DAV) Charitable Service Trust supports physical and psychological rehabilitation programs, meets the special needs of veterans with specific disabilities - such as amputation and blindness - and aids and shelters homeless veterans. Programs supported by the Trust target several groups of physically and psychologically disabled veterans. Key programs include: helping to maintain a volunteer-operated transportation network providing rides to sick and disabled veterans needing transportation to and from VA medical centers for treatment; providing food and shelter and connecting homeless and needy veterans to essential medical care, VA benefits counseling and job training; supporting significant therapeutic initiatives; and many more."', NULL, 'U.S.', NULL, '10', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 1, '10110', NULL, NULL, 'DisabledAmericanVeteransCharitable Service Trust.jpg', NULL),
(125, 'Do Something', NULL, '"Do Something believes young people have the power to make a difference. It is our aim to inspire, support and celebrate a generation of do-ers: people who see the need to do something, believe in their ability to get it done, and then take action. Our website is a community where young people learn, listen, speak, vote, volunteer, ask, and take action to make the world a better place. Currently, only 23% of this generation actively volunteers. Our hope is to create a do something generation: a world where more than 51% of young people are involved with community action."', NULL, 'U.S.', NULL, '1', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '10148', NULL, NULL, 'DoSomething.jpg', NULL),
(126, '"Doctors Without Borders, USA"', NULL, '"Doctors Without Borders, USA (DWB-USA) was founded in 1990 in New York City to raise funds, create awareness, recruit field staff, and advocate with the United Nations and US government on humanitarian concerns. Doctors Without Borders/M', NULL, 'U.S.', NULL, '3', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 1, '10103', NULL, NULL, 'DoctorsWithoutBorders.jpg', NULL),
(127, 'DonorsChoose', NULL, '"Founded in 2000, DonorsChoose allows citizen philanthropists to fund specific project requests from teachers in U.S. public schools. We make it personal: donors choose a project that moves them, and then they hear back from the classroom with photos and updates. DonorsChoose validates the project request and purchases the resources for the teacher. To date, we have funded over 90,000 classroom projects to bring learning alive for students, providing more than two million children with books, technology, supplies, funding for field trips or class visitors, and other resources. Our vision is of a nation where students in every community have the resources they need to learn."', NULL, 'U.S.', NULL, '7', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '10149', NULL, NULL, 'DonorsChoose.jpg', NULL),
(128, 'East Harlem Tutorial Program', NULL, '"Since its pioneering establishment in 1958, East Harlem Tutorial Program (EHTP) has been one of the most successful after-school educational programs in New York. Recognizing that each child has unique talents and learning styles, EHTP''s After School Program relies on the interaction of parents, teachers and children in promoting literacy-based educational enrichment and personal development activities for enrollees between the ages of five and twenty-one. As a vital East Harlem education and enrichment center, EHTP works with children from early childhood through adulthood to ensure that they have the resources needed to access opportunities for academic, social and career advancement while fully engaging parents and caregivers in their children''s development"', NULL, 'U.S.', NULL, '10', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '10150', NULL, NULL, 'EastHarlemTutorialProgram.jpg', NULL),
(129, 'Family to Family', NULL, '"Family-to-Family (F-to-F) is a tax-exempt 501(c)(3), non-profit national hunger relief organization. We are dedicated to connecting, one-to-one, families with ', NULL, 'U.S.', NULL, '6', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '10177', NULL, NULL, 'FamilyToFamily.jpg', NULL),
(130, 'Feed the Children', NULL, '"Feed The Children is a Christian, international relief organization that delivers food, medicine, clothing and other necessities to individuals, children and families who lack these essentials due to famine, war, poverty or natural disaster. Since our founding in 1979, we have grown into one of the world''s largest private organizations dedicated to helping hungry and hurting people. Last year, Feed The Children shipped 133 million pounds of food and other essentials to children and families in all 50 states and around the world. A key goal is to help families in need move past needing help and into becoming self-sufficient members of their community."', NULL, 'U.S.', NULL, '8', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 1, '10108', NULL, NULL, 'FeedTheChildren.jpg', NULL),
(131, 'Food For the Poor', NULL, '"Food For The Poor (FFP) ministers to spiritually renew impoverished people throughout Latin America and the Caribbean. Established in 1982, FFP''s goals are to improve the health, economic, social and spiritual conditions of the men, women and children we serve. Food For The Poor raises funds and provides direct relief assistance to the poor, usually by purchasing specifically requested materials and distributing them through the churches and charity organizations already operating in areas of need. Since its founding FFP has distributed more than 48,000 tractor-trailer loads of aid to the poor. We have also built more than 55,000 housing units for people desperately in need of adequate shelter, and completed more than 750 water projects that provide lifesaving water and sanitation to hundreds of thousands of villagers in need."', NULL, 'U.S.', NULL, '15', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 1, '10124', NULL, NULL, 'FoodForThePoor.jpg', NULL),
(132, 'Fresh Youth Initiatives', NULL, '"Recognizing that young people in Washington Heights lack safe, structured, and engaging ways to spend time in the non-school hours of the day, Fresh Youth Initiatives (FYI) was launched in 1993 as a community-based youth development organization. FYI''s mission is to support and encourage young people in Washington Heights to design and carry out community service projects, develop leadership skills, fulfill their potential and realize their dreams. Participants in FYI clean parks, paint murals, volunteer in community gardens, make and distribute homemade sleeping bags for the homeless, and volunteer in our own youth-run, adult facilitated food pantry, The Helping Hands Food Pantry, among other things."', NULL, 'U.S.', NULL, '10', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '10152', NULL, NULL, 'FreshYouthInitiatives.jpg', NULL),
(133, 'Friends of Karen', NULL, '"Founded in 1978, Friends of Karen provides emotional, financial and advocacy support to children with life-threatening illnesses and their families. Friends of Karen achieves its mission by providing direct financial assistance with medical care, illness-related expenses and household expenses that families cannot afford due to loss of income as a result of their child''s illness; serving as an advocate for the children and their families before government and private agencies; investigating resources available to the children and their families; offering bereavement support for parents who have lost a child and for siblings who have lost a brother or sister; assisting families through the difficult maze of health insurance problem; and acting as a referral source and providing guidance to families with ill children outside our guidelines."', NULL, 'U.S.', NULL, '1', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 1, '10122', NULL, NULL, 'FriendsOfKaren.jpg', NULL),
(134, 'Fund for Public Schools', NULL, '"The Fund for Public Schools works to attract private investment in school reform and to encourage greater involvement of all New Yorkers in the education of our children. This includes working to secure critical funding for system-wide education reform initiatives; facilitating strategic public-private partnerships; managing a targeted set of programs to support city schools; and building city-wide public awareness. In 2002 Mayor Michael R. Bloomberg and Chancellor Joel I. Klein established public-private partnerships as a critical means of supporting public education reform, and The Fund is the primary vehicle for advancing this effort. The Fund has secured unprecedented investment, raising more than $230 million for system-wide reforms and initiatives that support individual schools."', NULL, 'U.S.', NULL, '8', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '10153', NULL, NULL, 'FundForPublicSchools.jpg', NULL),
(135, 'Girls Inc.', NULL, '"Girls Inc. is a national youth organization dedicated to inspiring all girls to be strong, smart, and bold. With roots dating to 1864, Girls Inc. has provided vital educational programs to millions of American girls, particularly those in high-risk, underserved areas. Today, innovative programs help girls confront subtle societal messages about their value and potential, and prepare them to lead successful, independent, and fulfilling lives. Programs based on research gathered at the Girls Inc. National Resource Center encourage girls ages 6-18 to take risks and master physical, intellectual, and emotional challenges. Programs are offered through a network of 1,000 sites nationwide and are facilitated by trained professional staff."', NULL, 'U.S.', NULL, '15', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '10154', NULL, NULL, 'GirlsInc..jpg', NULL),
(136, 'Habitat For Humanity - New York City', NULL, '"Founded in 1984 as an independent affiliate of Habitat for Humanity International, Habitat for Humanity - New York City builds in the five boroughs of New York City. We complete about 25 houses a year. We build the homes with the sweat equity of our family partner homeowners who work side-by-side with volunteers. In addition to building homes, Habitat-NYC is a leading advocate for affordable housing. Our goal is to ensure that every New Yorker has a decent, affordable home, by creating a social movement to end the housing crisis plaguing New York City and by calling on elected officials to make affordable housing a priority."', NULL, 'U.S.', NULL, '4', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 1, '10128', NULL, NULL, 'HabitatForHumanity.jpg', NULL),
(137, 'Habitat For Humanity International', NULL, '"Founded in 1976, Habitat for Humanity International (HFHI) is an ecumenical Christian housing ministry. HFHI seeks to eliminate poverty housing and homelessness from the world, and to make decent shelter a matter of conscience and action. Habitat invites people of all backgrounds, races and religions to build houses together in partnership with families in need. Habitat has built more than 300,000 houses around the world, providing more than 1.5 million people in more than 3,000 communities with safe, decent, affordable shelter. Habitat is founded on the conviction that every man, woman and child should have a simple, decent, affordable place to live in dignity and safety."', NULL, 'U.S.', NULL, '9', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 1, '10129', NULL, NULL, 'HabitatForHumanity.jpg', NULL),
(138, 'Harlem Children''s Zone', NULL, '"Harlem Children''s Zone (HCZ) is an innovative and unique community-based organization, offering education, social-service and community-building programs to children and families since 1970. HCZ has experienced incredible growth - from the number of children we serve to the breadth of our services. But one thing has stayed the same: the agency''s whatever it takes attitude when it comes to helping children to succeed. Today, HCZ continues to offer innovative, efficiently run programs that are aimed at doing nothing less than breaking the cycle of generational poverty for the thousands of children and families it serves. All HCZ programs are offered free to the children and families of Harlem."', NULL, 'U.S.', NULL, '16', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '10155', NULL, NULL, 'HarlemChildrensZone.jpg', NULL),
(139, 'iMentor', NULL, '"iMentor''s mission is to improve the lives of young people from underserved communities through innovative, technology-based approaches to mentoring. Over the past ten years, iMentor has transformed over 20,000 lives. iMentor cultivates relationships between young people and volunteer adult mentors through an innovative combination of e-mail correspondence and in-person meetings. To-date, iMentor has matched over 10,000 mentor-mentee pairs, partnering with 30 NYC schools and after school programs in four of New York City''s five boroughs and programs all over the country through iMentor Interactive. iMentor''s vision is that one day, all youth will be connected to adult role models who motivate and guide them through high school and college graduation."', NULL, 'U.S.', NULL, '9', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '10157', NULL, NULL, 'iMentor.jpg', NULL),
(140, 'Inner-City Scholorship Fund', NULL, '"Inner-City Scholarship Fund (ICSF), a not-for-profit organization, was founded in 1971 by the late Terence Cardinal Cooke and a group of prominent New York executives from many religious backgrounds. ICSF seeks to provide tuition assistance to students from low-income families who wish to attend inner-city Catholic schools within the Archdiocese of New York, thus making values-based Catholic education a viable choice for children of all faiths. Through the generosity of its volunteers, ICSF is also able to supplement the education received with a variety of enrichment programs to benefit these children and the schools they attend."', NULL, 'U.S.', NULL, '19', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '10158', NULL, NULL, 'InnerCityScholarshipFund.jpg', NULL),
(141, 'Invisible Children', NULL, '"The story of Invisible Children (IC) began in 2003, when three young filmmakers traveled to East Africa and filmed a documentary, Invisible Children: The Rough Cut, about the ongoing civil war and child soldier phenomenon in northern Uganda. Upon showing this documentary in the United States, the story of the child soldiers sparked a youth-oriented grassroots movement driven by the desire to transform apathy into activism.This movement led to the establishment of Invisible Children, Inc. as a registered 501(c)3 in 2005. IC''s programs include educational and microeconomic initiatives in Central Africa benefitting over 11,000 people as well as biannual tours, awareness events, and fundraising campaigns stateside. Recently, IC has expanded its operations to Central Africa to address the plight of the most recent victims of the LRA''s reign of terror who live in some of the most remote regions of the world."', NULL, 'U.S.', NULL, '4', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 1, '10104', NULL, NULL, 'InvisibleChildren.jpg', NULL),
(142, 'Joe Torre Safe At Home Foundation', NULL, '"The Joe Torre Safe At Home Foundation was founded in 2002 by Ali and Joe Torre to educate children to end the cycle of domestic violence and save lives. The Foundation aims to educate children about the issue of domestic violence. In 2005, the Foundation opened its first school-based programming initiative, Margaret''s Place, at Hostos-Lincoln Academy, Bronx, NY. Margaret''s Place, a tribute to his mom, is a comprehensive program which provides students with a safe room in school where they can meet with a professional counselor trained in domestic-violence intervention and prevention. Currently there are ten fully funded and operational Margaret''s Places in New York City and Westchester County."', NULL, 'U.S.', NULL, '20', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '10159', NULL, NULL, 'JoeTorreSafeAtHomeFoundation.png', NULL),
(143, 'Juvenile Diabetes Research Foundation International', NULL, '"The Juvenile Diabetes Research Foundation International (JDRF) is the leader in research leading to a cure for type 1 diabetes in the world. It sets the global agenda for diabetes research, and is the largest charitable funder and advocate of diabetes science worldwide. The mission of JDRF is to find a cure for diabetes and its complications through the support of research. Type 1 diabetes is an autoimmune disease that strikes children and adults suddenly, and can be fatal. Since its founding in 1970 by parents of children with type 1 diabetes, JDRF has awarded more than $1.3 billion to diabetes research, including more than $156 million in FY2008."', NULL, 'U.S.', NULL, '20', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 1, '10120', NULL, NULL, 'JuvenileDiabetesResearchFoundation International.jpg', NULL),
(144, 'K.I.D.S.', NULL, '"K.I.D.S. (Kids in Distressed Situations) was founded in 1985 to assist children suffering from famine in Ethiopia. From the initial efforts of a small group of children''s industry leaders, the organization has grown into a global charity dedicated to alleviating poverty conditions among children and assisting in relief efforts following major disasters. K.I.D.S. brings hope and self-esteem to children in need and their families by providing new clothes, shoes, toys, furniture, books and juvenile products through a network of more than a thousand local social service agencies. These agencies serve youth in poverty-stricken communities through homeless shelters, foster-care facilities, hospitals, relief organizations, food banks and other programs in the U.S. and abroad."', NULL, 'U.S.', NULL, '4', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '10160', NULL, NULL, 'K.I.D.S..png', NULL),
(145, 'Keep a Child Alive', NULL, '"Keep a Child Alive is dedicated to providing life-saving anti-retroviral treatment, care and support services to children and families whose lives have been affected by HIV/AIDS in Africa and India by directly engaging the global public in the fight against AIDS. What started as a very personal incident between two mothers has become a tremendous initiative for change. With over 4,000 children and family members on ARV treatment, over 250,000 people under our care, three orphanages receiving funding, and major clinic sites in expansion, Keep a Child Alive is making a direct impact in the lives of so many who need help."', NULL, 'U.S.', NULL, '15', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '10161', NULL, NULL, 'KeepAChildAlive.jpg', NULL),
(146, 'Lance Armstron Foundation', NULL, '"The Lance Armstrong Foundation (LAF) believes that in the battle with cancer, unity is strength, knowledge is power and attitude is everything. Founded in 1997 by cancer survivor and champion cyclist, Lance Armstrong, the LAF inspires and empowers people with cancer. We provide the practical information and tools people with cancer need to live life on their own terms. We take aim at the gaps between what is known and what is done to prevent suffering and death due to cancer. We unite people to fight cancer and pursue an agenda focused on: prevention, access to screening and care, improvement of the quality of life for cancer survivors, and investment in research."', NULL, 'U.S.', NULL, '17', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 1, '10117', NULL, NULL, 'LanceArmstrongFoundation.jpg', NULL),
(147, 'Learning Leaders', NULL, '"Founded in 1956 as the New York City School Volunteer Program, Learning Leaders was the first program of its kind in the country and served as a model for developing school volunteer programs in other major cities. Learning Leaders has grown to become the largest school volunteer and parent engagement program in the city and a valued partner of the New York City Department of Education. Learning Leaders has helped students succeed by providing individualized instructional support through the implementation of the Fundamental Program, essentially the one-on-one tutoring model. This program establishes volunteers to assist with reading, writing, ESL, math and other academic activities. Learning Leaders recruits, trains and supports up to 10,000 school volunteers who work with over 230,000 students."', NULL, 'U.S.', NULL, '18', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '10162', NULL, NULL, 'LearningLeaders.jpg', NULL),
(148, '"Literacy, Inc."', NULL, '"Literacy, Inc. (LINC), founded in 1996, is based on two beliefs: all children can read given enough one-on-one support and every neighborhood has strengths and resources that can be coordinated to support early literacy. LINC works with communities to: develop a dynamic and sustainable network of community activities that achieve unified literacy success; help organizations, community leaders and others to understand the many ways they can support young children as readers; encourage families and other community members to be increasingly engaged as reading partners to young children; create a perceptible shift in the community belief that all its neighborhood children will read on time with community support; and ensure a literacy rich community that will contribute to the success of children entering school by ensuring that they are ready to learn and read on time."', NULL, 'U.S.', NULL, '4', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '10163', NULL, NULL, 'LiteracyInc..png', NULL),
(149, 'Little Kids Rock', NULL, '"Founded in 1996, Little Kids Rock (LKR) believes that all children in our public schools deserve music education. LKR knows that music is a critical component of a first-rate education. We inspire children to express themselves through music, building the creativity, confidence, and self-esteem that are critical to success in school and beyond. We accomplish this by: pioneering innovative teaching methods that are rooted in children''s knowledge of popular music forms such as rock, rap, blues, hip-hop etc; preparing practitioners such as teachers and youth workers to offer classes utilizing our methods and materials; and providing free musical instruments and trained instructors to children, especially to those children who do not receive music education."', NULL, 'U.S.', NULL, '9', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 1, '10127', NULL, NULL, 'LittleKidsRock.jpg', NULL),
(150, 'Make-A-Wish Foundation of America', NULL, '"The Make-A-Wish Foundation grants the wishes of children with life-threatening medical conditions to enrich the human experience with hope, strength and joy. Based in Phoenix, the Foundation is one of the world''s leading children''s charities, serving children in every community in the United States, its territories, and in 47 countries on five continents. With the help of generous donors and more than 30,000 volunteers worldwide, the Make-A-Wish Foundation grants a wish somewhere around the world every 23 minutes. It has granted more than 280,000 wishes since its inception in 1980. Visit the Make-A-Wish Foundation at www.wish.org and discover how you can share the power of a wish', NULL, 'U.S.', NULL, '12', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 1, '10112', NULL, NULL, 'MakeAWishFoundationOfAmerica.jpg', NULL),
(151, 'March of Dimes', NULL, '"President Franklin Roosevelt established the March of Dimes in 1938. March of Dimes has saved the lives of millions of babies since our founding. And we won''t stop until we reach the day when every baby is born healthy. The mission of the March of Dimes is to improve the health of babies by preventing birth defects and infant mortality. We carry out this mission through research, community services, education and advocacy to save babies'' lives. March of Dimes researchers, volunteers, educators, outreach workers and advocates work together to give all babies a fighting chance against the threats to their health: prematurity, birth defects, and low birthweight."', NULL, 'U.S.', NULL, '14', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '10164', NULL, NULL, 'MarchOfDimes.jpg', NULL),
(152, 'Michael J. Fox Foundation for Parkinson''s Research', NULL, '"The Michael J. Fox Foundation for Parkinson''s Research is dedicated to finding a cure for Parkinson''s disease within the decade through an aggressively funded research agenda and to ensuring the development of improved therapies for those living with Parkinson''s today. For The Michael J. Fox Foundation, there is one clear measure of success: delivering patients better treatments and, ultimately, a cure for Parkinson''s disease. We''ve developed a targeted approach to research funding that helps us identify and prioritize the patient-relevant science that will allow us to reach our goal. Since we began in 2000, the Foundation has funded over $149 million in Parkinson''s research, either directly or through partnerships."', NULL, 'U.S.', NULL, '16', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 1, '10116', NULL, NULL, 'MichaelJFoxFoundationForParkinson''s Research.jpg', NULL);
INSERT INTO `charities` (`id`, `name`, `name_alias`, `description`, `city`, `region`, `website_url`, `lookup_charity_code_id`, `created_at`, `updated_at`, `featured`, `top_recommended`, `syw_altkey`, `vendor1_altkey`, `vendor2_altkey`, `temp_icon_filename`, `deleted_at`) VALUES
(153, 'National Children''s Leukemia Foundation', NULL, '"The National Children''s Leukemia Foundation (NCLF) is one of the leading organizations in the fight against leukemia and cancer for children and adults. The mission of the NCLF is to provide the cure for cancer and other life-threatening diseases throughout the world, and to insure that all persons, regardless of race, religion, ethnicity, gender, socioeconomic status or country of residence, have access to life-saving medical care. The NCLF supports medical research and direct patient care programs that ease the financial, social and psychological burdens of families with a diagnosis of cancer or other serious blood disorders. Through our hotline, we offer comprehensive information to any caller, and provide referrals for initial testing, physicians, hospital admissions, and treatment options."', NULL, 'U.S.', NULL, '17', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '10165', NULL, NULL, 'NYCOutwardBoundCenter.jpg', NULL),
(154, 'New Yorkers For Children', NULL, '"There are 17,000 young people in foster care in New York City, and many of them face unique and complex challenges in their efforts to become successful, self-sufficient adults. Much is needed that cannot be provided by government funding, and New Yorkers For Children (NYFC) has become a valuable resource and support system for these youth. Founded in 1996 by former Commissioner of the Administration for Children''s Services Nicholas Scoppetta as the non-profit partner to Children''s Services, NYFC strives to enrich the lives of young people in foster care as they strive for success. Over the past 12 years, donations from individuals, corporations, and foundations have enabled us to reach these youth through scholarships, mentoring, financial literacy training, networking opportunities, and the support needed to succeed in college."', NULL, 'U.S.', NULL, '1', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '10166', NULL, NULL, 'NationalChildrensLeukemiaFoundation.gif', NULL),
(155, 'NYC Outward Bound Center', NULL, '"Founded in 1987, NYC Outward Bound Center is the first independent urban Outward Bound Center in the United States. Our organization traces its roots to 1941, when Outward Bound was founded by the well-known European educator Kurt Hahn. NYC Outward Bound programs are transformational. In New York City, we focus primarily on bringing our educational approach to City youth where they live, reaching them mainly through their public schools. Our educational method is called Expeditionary Learning (EL). It is used successfully in schools nationwide, and is achievement-oriented. Through EL, students reach higher levels than they ever thought possible. Academic learning connects to students'' own experiences, and to real-world issues and concerns."', NULL, 'U.S.', NULL, '3', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '10167', NULL, NULL, 'NewYorkersForChildren.gif', NULL),
(156, 'Parazlyzed Veterans of America', NULL, '"Founded in 1946, Paralyzed Veterans of America (PVA) is the only congressionally chartered veterans service organization dedicated solely to serving the needs of veterans with spinal cord injury or spinal cord dysfunction (SCI/D). PVA has developed a unique expertise on a wide variety of issues involving the special needs of our members - veterans of the armed forces who have experienced SCI/D. PVA uses that expertise to be the leading advocate for: quality health care for our members; research and education addressing SCI/D; benefits available as a result of our members'' military service; and civil rights and opportunities which maximize the independence of our members."', NULL, 'U.S.', NULL, '15', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 1, '10115', NULL, NULL, 'ParalyzedVeteransOfAmerica.jpg', NULL),
(157, 'Pinwheel Project', '', 'The Pinwheel Project is a non-profit, 501(c)(3) children’s charity whose mission is to ensure that no child or family ever feels hopeless or alone during the ordeal of a pediatric hospital stay. The practical help and emotional support, which we provide at no cost, is designed to create an atmosphere that promotes healing.', '', 'U.S.', '', '21', '0000-00-00 00:00:00', '2012-09-10 03:41:43', 0, 1, '10121', NULL, NULL, 'PinwheelProject.gif', NULL),
(158, 'Ronald McDonald House of New York', NULL, '"Founded in 1978, the Ronald McDonald House of New York provides temporary housing for pediatric cancer patients and their families. Here families find a strong, supportive and caring environment which encourages and nurtures the development of child-to-child and parent-to-parent support systems. Ronald McDonald House in New York City is the largest facility of its type in the world. The House can accommodate 83 families, and it is filled to capacity almost every night. The House''s location in Manhattan, in close proximity to 12 major cancer treatment centers, draws children and families from across the country and the world, as well as from the metropolitan New York City area."', NULL, 'U.S.', NULL, '4', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '10170', NULL, NULL, 'RonaldMcDonaldHouseOfNewYork.jpg', NULL),
(159, 'Room to Grow', NULL, '"Founded in 1998, the mission of Room to Grow is to enrich the lives of babies born into poverty throughout their critical first three years of development. Room to Grow''s program provides parents raising babies in poverty with one-on-one parenting support and essential baby items throughout their children''s critical first three years of life. Parents expecting a baby are referred to Room to Grow by selected prenatal programs assisting low-income families. Upon their referral, parents visit Room to Grow''s warm and inviting space once every three months from just before the birth of the baby until their child turns three. During their one-on-one appointments with our staff clinicians, typically lasting two hours, parents receive developmental information, customized support, and all of the needed baby items to ensure a healthy and secure start for their child."', NULL, 'U.S.', NULL, '21', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '10171', NULL, NULL, 'RoomToGrow.jpg', NULL),
(160, 'Save the Children', NULL, '"Save the Children, founded in 1932, is the leading independent organization creating real and lasting change for children in need in the United States and around the world. Save the Children''s unique self-help approach to relief, recovery and ongoing development has nurtured the seeds of hope for millions of children and their families. Our programs focus on the areas of: economic opportunities; education; emergencies; protection; health; hunger and malnutrition; and U.S. literacy and nutrition. We work in more than 50 countries, including the United States. We serve 48 million children and many others working to save and improve children''s lives, including parents, community members, local organizations and government agencies."', NULL, 'U.S.', NULL, '6', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 1, '10106', NULL, NULL, 'SaveTheChildren.jpg', NULL),
(161, 'Special Olympics', NULL, '"Special Olympics is an international organization that changes lives by promoting understanding, acceptance and inclusion between people with and without intellectual disabilities. Through year-round sports training and athletic competition and other related programming for more than 2.5 million children and adults with intellectual disabilities in more than 180 countries, Special Olympics has created a model community that celebrates people''s diverse gifts. Founded in 1968 by Eunice Kennedy Shriver, Special Olympics provides people with intellectual disabilities continuing opportunities to realize their potential, develop physical fitness, demonstrate courage and experience joy and friendship."', NULL, 'U.S.', NULL, '15', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '10172', NULL, NULL, 'SpecialOlympics.jpg', NULL),
(162, 'Starlight Children''s Foundation NY/NJ/CT', NULL, '"Starlight Children''s Foundation NY*NJ*CT helps seriously ill children and their families cope with their pain, fear and isolation through entertainment, education and family activities. Starlight brings together experts from pediatric health care, technology and entertainment to create programs that educate, entertain and inspire seriously ill children. Whether it''s finding friends online, learning more about a disease, or just spending time together as a family, Starlight''s programs help children and families cope with the challenges they face daily. We are proud to say that this past year, our programs benefited more than 275,000 children and their family members in the tri-state area."', NULL, 'U.S.', NULL, '8', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '10173', NULL, NULL, 'StarlightChildrensFoundation.jpg', NULL),
(163, 'Susan G. Komen for the Cure', NULL, '"Nancy G. Brinker promised her dying sister, Susan G. Komen, she would do everything in her power to end breast cancer forever. In 1982, that promise became Susan G. Komen for the Cure and launched the global breast cancer movement. Today, Susan G. Komen for the Cure is the world''s largest grassroots network of breast cancer survivors and activists fighting to save lives, empower people, ensure quality care for all and energize science to find the cures. Thanks to events like the Komen Race for the Cure, we have invested more than $1.9 billion to fulfill our promise, becoming the largest source of nonprofit funds dedicated to the fight against breast cancer in the world."', NULL, 'U.S.', NULL, '7', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 1, '10107', NULL, NULL, 'SusanGKormanForTheCure.jpg', NULL),
(164, 'Teaching Matters', NULL, '"For the past 15 years, Teaching Matters has led the way in the development and implementation of school-level educational innovations made possible by technology in the largest urban school system in America. Partnering with foundations, frontline educators, content experts, and technologists, we pursue a new standard for student success; one that strikes a balance between core academic and 21st century skills and prepares students for their futures. Each day, Teaching Matters works side by side with classroom educators. As such, we are uniquely situated to observe the real constraints that prevent schools from preparing students for success in the digital age. By focusing development to address the specific constraints and challenges of real classrooms, we improve the likelihood that schools will adopt innovations necessary to meet the needs of today''s students."', NULL, 'U.S.', NULL, '21', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '10174', NULL, NULL, 'TeachingMatters.jpg', NULL),
(165, 'The Children''s Aid Society', NULL, '"Founded in 1853, The Children''s Aid Society (CAS) works to ensure the physical and emotional well-being of children and families, and to provide each child with the support and opportunities needed to become a happy, healthy and productive adult. CAS fills the gaps between what children deserve and what life has dealt them. We have been serving children for more than 150 years, a longevity that is a testament to our ability to adapt to the always changing needs of today''s youth. Today CAS serves more than 150,000 children and their families at more than 45 sites throughout New York City."', NULL, 'U.S.', NULL, '15', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 1, '10126', NULL, NULL, 'TheChildrensAidSociety.jpg', NULL),
(166, 'The Children''s Health Fund', NULL, '"Founded in 1987, the Children''s Health Fund (CHF) is committed to providing comprehensive health care to the nation''s most medically underserved children and their families through the development and support of innovative primary care medical programs and the promotion of guaranteed access to appropriate health care for all children. CHF is dedicated to meeting the complex and challenging health needs of underserved children. Children''s Health Fund realizes this mission through the energy and talent of our dedicated team of doctors, nurses, psychologists, social workers, nutritionists, and other clinical and support staff and our partnerships with esteemed academic medical centers."', NULL, 'U.S.', NULL, '19', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 1, '10119', NULL, NULL, 'TheChildrensHealthFund.png', NULL),
(167, 'The Fresh Air Fund', NULL, '"Since 1877, The Fresh Air Fund has provided free summer vacations in the country to more than 1.7 million New York City children from disadvantaged communities. Each year, thousands of children visit volunteer host families in 13 states and Canada through the Friendly Town Program or attend Fresh Air Fund camps. In addition to the Friendly Town Program, each summer, 3,000 children enjoy themselves at one of the five Fresh Air camps in upstate New York. We also offer a career awareness program which focuses on expanding the education and career options of New York City adolescents."', NULL, 'U.S.', NULL, '4', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '10151', NULL, NULL, 'TheFreshAirFund.jpg', NULL),
(168, 'The Parent-Child Home Program', NULL, 'The Parent-Child Home Program''s National Center strives to ensure that families in communities across the country have access to The Parent-Child Home Program. The National Center assists communities in developing Parent-Child Home Program replications and expanding existing sites. The Center works to increase public awareness about the importance of early parent-child verbal interaction and works with public officials to increase the availability of public funds that can be utilized to support Parent-Child Home Program replications around the country.', NULL, 'U.S.', NULL, '15', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '10168', NULL, NULL, 'TheParent-ChildHomeProgram.jpg', NULL),
(169, 'The Perlman Music Program', NULL, '"Founded in 1993, the Perlman Music Program (PMP) welcomes young musicians of rare and special talent into a richly supportive musical community. Through intensive summer programs, year-round mentoring, and on occasion, an international study or performance tour, the program offers unparalleled musical training for students, ages 12 to 30, who play the violin, viola, cello, bass and piano. With a faculty led by Itzhak Perlman and comprising some of the most gifted musical talents of our time, the Program offers an artistic and personal experience that changes students'' lives forever. PMP seeks to ensure that the very best musicians can take advantage of this opportunity, regardless of their economic background or financial means."', NULL, 'U.S.', NULL, '22', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '10169', NULL, NULL, 'ThePerlmanMusicProgram.jpg', NULL),
(170, 'United Sates Fund for UNICEF', NULL, '"The United States Fund for UNICEF was founded in 1947 to support the work of the United Nations Children''s Fund (UNICEF) by raising funds for its programs and increasing awareness of the challenges facing the world''s children. The oldest of 37 national committees for UNICEF worldwide, we are part of a global effort to save, protect and improve children''s lives. Every moment of every day, UNICEF is on the ground providing lifesaving help for children in need. We provide families with clean water and sanitation, we vaccinate against childhood illness, and we help protect children against malaria. We provide nourishment to fight malnutrition, and we care for children affected by AIDS. We protect children from abuse, and we give them an education. We are here to make sure that all children lead a healthy, humane, and dignified life."', NULL, 'U.S.', NULL, '13', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 1, '10113', NULL, NULL, 'UnitedStatesFundForUNICEF.jpg', NULL),
(171, 'Voices Against Brain Cancer', NULL, '"Our mission is to find a cure for brain cancer by advancing scientific research, increasing awareness within the medical community and supporting patients, their families and caregivers afflicted with this devastating disease."', NULL, 'U.S.', NULL, '11', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 1, '10111', NULL, NULL, 'VoicesAgainstBrainCancer.jpg', NULL),
(172, 'World Childhood Foundation', NULL, '"The mission of World Childhood Foundation is to defend the rights of the child and to promote better living conditions for vulnerable and exploited children at risk all over the world. World Childhood Foundation wants to give all children the opportunity to develop into strong, secure and responsible human beings. Childhood was founded in 1999 by H.M. Queen Silvia of Sweden, who felt a compelling need to address the social, emotional and material poverty of children around the world. Over the last five years the organizations has grown to support more than 100 programs in 14 countries. The Foundation', NULL, 'U.S.', NULL, '22', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '10175', NULL, NULL, 'World Childhood Foundation.jpg', NULL),
(173, 'World Vision', NULL, '"World Vision is a Christian humanitarian organization dedicated to working with children, families and their communities worldwide to reach their full potential by tackling the causes of poverty and injustice. Motivated by our faith in Jesus Christ, World Vision serves alongside the poor and oppressed as a demonstration of God''s unconditional love for all people. World Vision serves all people, regardless of religion, race, ethnicity, or gender."', NULL, 'U.S.', NULL, '2', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 1, 1, '10102', NULL, NULL, 'WorldVision.jpg', NULL),
(174, 'Wounded Warrior Project', NULL, '"The mission of Wounded Warrior Project is to honor and empower wounded warriors. Our purpose is: to raise awareness and enlist the public''s aid for the needs of severely injured service men and women; to help severely injured service members aid and assist each other; and to provide unique, direct programs and services to meet the needs of severely injured service members."', NULL, 'U.S.', NULL, '14', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 1, '10114', NULL, NULL, 'WoundedWarriorProject.jpg', NULL),
(175, 'Young Audiences', NULL, '"Founded in 1952, Young Audiences (YA) works to help make the arts an essential part of young people''s education. YA advances the artistic and educational development of youngsters by bringing them together with professional artists of all disciplines to learn, create and participate in the arts. This year, YA''s network of 30 affiliates and 4,600 artists reached seven million children in nearly 7,000 schools with 16,300 performance demonstrations, 60,000 workshops and 3,240 teacher services. YA and its affiliates are engaged in several network projects, including Arts for Learning Lessons, MetLife Dance for Life, and Arts for Learning Interactive Media."', NULL, 'U.S.', NULL, '23', '0000-00-00 00:00:00', '0000-00-00 00:00:00', 0, 0, '10176', NULL, NULL, 'YoungAudiences.jpg', NULL),
(176, 'Toys For Tots', 'Toys For Tots', 'Marine Toys for Tots Foundation is the fund raising, funding and support organization for the U.S. Marine Corps Reserve Toys for Tots Program.  The primary goal of the Foundation is the same as that of the overall Toys for Tots program: to deliver, through a shiny new toy at Christmas, a message of hope to needy youngsters that will motivate them to grow into responsible, productive, patriotic citizens and community leaders.', '', 'U.S.', 'http://www.toysfortots.org/', '16', '2012-09-13 19:35:53', '2012-09-13 19:37:42', 0, 0, NULL, NULL, NULL, NULL, NULL),
(177, '"National MPS Society"', '', '"The National MPS Society exists to find cures for MPS (Mucopolysaccharidoses) and related diseases. We provide hope and support for affected individuals and their families through research, advocacy and awareness of these devastating diseases. Since 1974 the Society has supported individuals and families affected with MPS and related diseases. MPS and related diseases are genetic lysosomal storage diseases caused by the body''s inability to produce specific enzymes. While the symptoms of MPS and related diseases may vary from one syndrome to another, there are many similarities. Affected individuals often have mental retardation, cloudy corneas, short stature, stiff joints, incontinence, speech and hearing impairment, chronic runny nose, hernia, heart disease, hyperactivity, depression, pain and a dramatically shortened life span"', '', 'U.S.', '', '', '2012-09-28 18:19:40', '2012-09-28 18:21:17', 0, 0, NULL, NULL, NULL, NULL, NULL),
(178, 'National MPS Society', '', 'The National MPS Society exists to find cures for MPS (Mucopolysaccharidoses) and related diseases. We provide hope and support for affected individuals and their families through research, advocacy and awareness of these devastating diseases. Since 1974 the Society has supported individuals and families affected with MPS and related diseases. MPS and related diseases are genetic lysosomal storage diseases caused by the body''s inability to produce specific enzymes. While the symptoms of MPS and related diseases may vary from one syndrome to another, there are many similarities. Affected individuals often have mental retardation, cloudy corneas, short stature, stiff joints, incontinence, speech and hearing impairment, chronic runny nose, hernia, heart disease, hyperactivity, depression, pain and a dramatically shortened life span.\r\n\r\n', '', 'U.S.', '', '', '2012-10-02 00:53:18', '2012-10-02 00:53:18', 0, 0, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `charities_events`
--

CREATE TABLE IF NOT EXISTS `charities_events` (
  `event_id` int(11) default NULL,
  `charity_id` int(11) default NULL,
  `id` int(11) NOT NULL auto_increment,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=56 ;

--
-- Dumping data for table `charities_events`
--

INSERT INTO `charities_events` (`event_id`, `charity_id`, `id`) VALUES
(7, 27, 1),
(6, 23, 2),
(6, 25, 3),
(6, 21, 4),
(9, 141, 5),
(8, 103, 6),
(13, 142, 7),
(13, 103, 8),
(13, 123, 9),
(14, 160, 10),
(14, 133, 11),
(15, 157, 12),
(15, 161, 13),
(15, 114, 14),
(18, 103, 15),
(18, 126, 16),
(19, 107, 17),
(19, 109, 18),
(19, 99, 19),
(17, 101, 20),
(17, 107, 21),
(17, 171, 22),
(9, 103, 23),
(21, 101, 24),
(21, 107, 25),
(21, 133, 26),
(3, 160, 27),
(23, 107, 28),
(23, 171, 29),
(25, 148, 30),
(26, 163, 31),
(26, 126, 32),
(29, 107, 33),
(29, 109, 34),
(29, 118, 35),
(27, 101, 36),
(27, 121, 37),
(27, 136, 38),
(31, 171, 39),
(30, 163, 40),
(34, 160, 41),
(24, 102, 42),
(36, 149, 43),
(35, 105, 44),
(37, 171, 45),
(39, 141, 46),
(24, 160, 47),
(24, 105, 48),
(38, 102, 49),
(38, 160, 50),
(42, 103, 51),
(45, 160, 52),
(46, 103, 53),
(46, 156, 54),
(40, 126, 55);

-- --------------------------------------------------------

--
-- Table structure for table `children`
--

CREATE TABLE IF NOT EXISTS `children` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) collate utf8_unicode_ci default NULL,
  `dob` date default NULL,
  `guest_id` int(11) default NULL,
  `event_id` int(11) default NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `index_children_on_guest_id` (`guest_id`),
  KEY `index_children_on_event_id` (`event_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=7 ;

--
-- Dumping data for table `children`
--

INSERT INTO `children` (`id`, `name`, `dob`, `guest_id`, `event_id`, `created_at`, `updated_at`) VALUES
(1, 'hoowhao', NULL, 1000018, 3, '2012-11-13 07:45:49', '2012-11-13 07:45:49'),
(2, 'Ayla', NULL, 1000021, 21, '2013-01-13 02:04:51', '2013-01-13 02:04:51'),
(3, 'MYBoy', NULL, 1000022, 45, '2013-01-15 01:16:39', '2013-01-15 01:16:39'),
(4, 'Bronxy', NULL, 1000023, 42, '2013-01-24 05:09:01', '2013-01-24 05:09:01'),
(5, 'Tippy', NULL, 1000023, 42, '2013-01-24 05:09:40', '2013-01-24 05:09:40'),
(6, 'Ayla', NULL, 1000026, 40, '2013-02-15 19:36:06', '2013-02-15 19:36:06');

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE IF NOT EXISTS `comments` (
  `id` int(11) NOT NULL auto_increment,
  `commentable_type` varchar(255) collate utf8_unicode_ci default NULL,
  `commentable_id` int(11) default NULL,
  `user_id` int(11) default NULL,
  `full_name` varchar(255) collate utf8_unicode_ci default NULL,
  `email` varchar(255) collate utf8_unicode_ci default NULL,
  `content` text collate utf8_unicode_ci,
  `visible` tinyint(1) default NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `guest_id` int(11) default NULL,
  `deleted_at` datetime default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_comments_on_commentable_type` (`commentable_type`),
  KEY `index_comments_on_commentable_id` (`commentable_id`),
  KEY `index_comments_on_guest_id` (`guest_id`),
  KEY `index_comments_on_user_id` (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=4 ;

--
-- Dumping data for table `comments`
--

INSERT INTO `comments` (`id`, `commentable_type`, `commentable_id`, `user_id`, `full_name`, `email`, `content`, `visible`, `created_at`, `updated_at`, `guest_id`, `deleted_at`) VALUES
(3, 'Event', 21, NULL, 'Buck', NULL, 'Tell me this chick doenst look like Kim Basinger?????\r\n', NULL, '2012-09-28 16:41:24', '2012-09-28 16:41:24', 1000008, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `contributions`
--

CREATE TABLE IF NOT EXISTS `contributions` (
  `id` int(11) NOT NULL auto_increment,
  `amount` decimal(10,2) default '0.00',
  `anonymous` tinyint(1) default '0',
  `charity_id` int(11) default NULL,
  `guest_id` int(11) default NULL,
  `event_id` int(11) default NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `deleted_at` datetime default NULL,
  `pay_transaction_fee` tinyint(1) default '0',
  PRIMARY KEY  (`id`),
  KEY `index_contributions_on_charity_id` (`charity_id`),
  KEY `index_contributions_on_guest_id` (`guest_id`),
  KEY `index_contributions_on_event_id` (`event_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=17 ;

--
-- Dumping data for table `contributions`
--

INSERT INTO `contributions` (`id`, `amount`, `anonymous`, `charity_id`, `guest_id`, `event_id`, `created_at`, `updated_at`, `deleted_at`, `pay_transaction_fee`) VALUES
(3, '30.00', 0, 171, 1000000, 23, '2012-09-26 00:29:03', '2012-09-26 00:29:03', NULL, 0),
(4, '20.00', 0, 101, 1000002, 27, '2012-09-27 01:51:32', '2012-09-27 01:51:32', NULL, 0),
(5, '20.00', 0, 101, 1000010, 37, '2012-09-29 00:31:41', '2012-09-29 00:31:41', NULL, 0),
(6, '50.00', 0, 160, 22, 3, '2012-09-30 02:37:10', '2012-09-30 02:37:10', NULL, 0),
(7, '24.00', 1, 160, 3, 3, '2013-01-09 04:02:20', '2013-01-09 04:02:20', NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `events`
--

CREATE TABLE IF NOT EXISTS `events` (
  `id` int(11) NOT NULL auto_increment,
  `title` varchar(255) collate utf8_unicode_ci default NULL,
  `event_date` datetime default NULL,
  `start_time` time default NULL,
  `end_time` time default NULL,
  `charity_donation_percent` decimal(3,2) default NULL,
  `child_full_name` varchar(255) collate utf8_unicode_ci default NULL,
  `host_name` varchar(255) collate utf8_unicode_ci default NULL,
  `child_dob` datetime default NULL,
  `page_content_one` text collate utf8_unicode_ci,
  `page_content_two` text collate utf8_unicode_ci,
  `page_content_three` text collate utf8_unicode_ci,
  `page_content_four` text collate utf8_unicode_ci,
  `other_page_content` text collate utf8_unicode_ci,
  `parental_consent_status` varchar(255) collate utf8_unicode_ci default 'notConfirmed',
  `page_customization_hash` text collate utf8_unicode_ci,
  `magic_phrase` varchar(255) collate utf8_unicode_ci default NULL,
  `icon_picture_id` int(11) default '0',
  `package_id` int(11) default NULL,
  `status` varchar(11) collate utf8_unicode_ci default 'in_progress',
  `user_id` int(11) default NULL,
  `step_id` int(11) default '1',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `child_pronoun` varchar(255) collate utf8_unicode_ci default NULL,
  `location_name` varchar(255) collate utf8_unicode_ci default NULL,
  `location_address` varchar(255) collate utf8_unicode_ci default NULL,
  `state` varchar(11) collate utf8_unicode_ci default 'not_ready',
  `publicly_viewable` tinyint(1) default '0',
  `event_sequence` int(11) default '1',
  `slug` varchar(255) collate utf8_unicode_ci default NULL,
  `gift_fund_locked` tinyint(1) default '1',
  `donation_fund_locked` tinyint(1) default '1',
  `contributions_locked` tinyint(1) default '0',
  `rsvp_by` date default NULL,
  `theme_code` varchar(255) collate utf8_unicode_ci default 'default',
  `deleted_at` datetime default NULL,
  `parents_invited` varchar(255) collate utf8_unicode_ci default 'optional',
  `invite_option` varchar(255) collate utf8_unicode_ci default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_events_on_child_dob` (`child_dob`),
  KEY `index_events_on_event_date` (`event_date`),
  KEY `index_events_on_status` (`status`),
  KEY `index_events_on_step_id` (`step_id`),
  KEY `index_events_on_slug` (`slug`),
  KEY `index_events_on_location_name` (`location_name`),
  KEY `index_events_on_child_full_name` (`child_full_name`),
  KEY `index_events_on_title` (`title`),
  KEY `index_events_on_theme_code` (`theme_code`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=47 ;

--
-- Dumping data for table `events`
--

INSERT INTO `events` (`id`, `title`, `event_date`, `start_time`, `end_time`, `charity_donation_percent`, `child_full_name`, `host_name`, `child_dob`, `page_content_one`, `page_content_two`, `page_content_three`, `page_content_four`, `other_page_content`, `parental_consent_status`, `page_customization_hash`, `magic_phrase`, `icon_picture_id`, `package_id`, `status`, `user_id`, `step_id`, `created_at`, `updated_at`, `child_pronoun`, `location_name`, `location_address`, `state`, `publicly_viewable`, `event_sequence`, `slug`, `gift_fund_locked`, `donation_fund_locked`, `contributions_locked`, `rsvp_by`, `theme_code`, `deleted_at`, `parents_invited`, `invite_option`) VALUES
(3, 'sdfsdfdsf', '2013-06-04 00:00:00', '22:00:00', '05:30:00', '1.00', 'sdfsdfsdf', 'sdfsdfsdf', '2009-06-07 00:00:00', 'sdf ', 'we chose them', 'an airplane 45', '', '', 'notConfirmed', NULL, 'sdf ', 0, 2, 'published', 1, 5, '2012-07-09 21:58:26', '2012-11-13 07:35:15', 'male', NULL, NULL, 'complete', 0, 2, 'sdf', 1, 1, 0, '2013-05-25', 'default', NULL, 'optional', NULL),
(6, 'julian''s bday', '2012-10-12 00:00:00', '11:15:00', '07:45:00', '0.50', 'julian', 'julian', '2001-10-11 00:00:00', 'dddd', 'aaa', 'aaa', '', '', 'notConfirmed', NULL, 'dddd', 0, 1, 'published', 2, 5, '2012-08-19 19:10:32', '2012-11-13 07:35:15', 'male', NULL, NULL, 'complete', 0, 1, 'ddd', 1, 1, 0, '2012-10-02', 'default', NULL, 'optional', NULL),
(8, 'Addyson''s 3rd Birthday', '2013-02-18 00:00:00', '14:45:00', '00:00:00', '0.75', 'Addyson', 'Addyson', '2010-02-20 00:00:00', 'Hi', 'Hi', 'Hi', '', '', 'notConfirmed', NULL, 'cooper', 0, 1, 'published', 7, 5, '2012-09-07 02:02:43', '2012-11-13 07:35:15', 'female', NULL, NULL, 'complete', 0, 1, 'addyson-s-3rd-birthday-party', 1, 1, 0, '2013-02-08', 'default', NULL, 'optional', NULL),
(9, 'Steve Stone''s Rocking Jubilee', '2012-11-12 00:00:00', NULL, NULL, '0.50', 'Steve Stone', 'Steve Stone', '2008-02-03 00:00:00', 'This is our great party', 'We like invisible things', 'A huge dinosaur', '', '', 'notConfirmed', NULL, 'Hallo Mate', 0, 1, 'in_progress', 4, 5, '2012-09-07 16:44:20', '2012-11-13 07:35:15', 'male', NULL, NULL, 'open', 0, 2, 'steve-s-party', 1, 1, 0, '2012-11-02', 'default', NULL, 'optional', NULL),
(10, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'notConfirmed', NULL, NULL, 0, 1, 'in_progress', 8, 1, '2012-09-07 17:13:22', '2012-09-07 17:13:22', NULL, NULL, NULL, 'open', 0, 1, NULL, 1, 1, 0, NULL, 'default', NULL, 'optional', NULL),
(12, 'Rainy Day Birthday Sun', '2012-11-02 00:00:00', NULL, NULL, '1.00', 'Luke Walker', 'Luke Walker', '1997-04-08 00:00:00', NULL, NULL, NULL, NULL, NULL, 'notConfirmed', NULL, NULL, 0, 1, 'in_progress', 11, 2, '2012-09-10 04:03:32', '2012-11-13 07:35:15', 'male', NULL, NULL, 'open', 0, 1, NULL, 1, 1, 0, '2012-10-23', 'default', NULL, 'optional', NULL),
(13, 'Birthday', '2012-12-15 00:00:00', NULL, NULL, '0.75', 'Catherine', 'Catherine', '2007-12-20 00:00:00', NULL, NULL, NULL, NULL, NULL, 'notConfirmed', NULL, NULL, 0, 1, 'in_progress', 12, 3, '2012-09-10 04:41:37', '2012-11-13 07:35:15', 'female', NULL, NULL, 'open', 0, 1, NULL, 1, 1, 0, '2012-12-05', 'default', NULL, 'optional', NULL),
(14, 'Ayla''s Rainbow Jumping Monkey Party!', '2013-01-19 00:00:00', '15:00:00', '17:00:00', '0.50', 'Ayla', 'Ayla', '2008-01-20 00:00:00', 'Hello!', '*Have pre-written responses to choose from here*', 'Drum set!', '', '', 'notConfirmed', NULL, NULL, 0, 1, 'in_progress', 6, 4, '2012-09-10 14:39:21', '2012-11-13 07:35:15', 'female', NULL, NULL, 'open', 0, 1, 'aylas5th', 1, 1, 0, '2013-01-09', 'default', NULL, 'optional', NULL),
(15, 'Ryan''s 5th Birthday', '2013-06-03 00:00:00', '11:00:00', '00:30:00', '0.50', 'Ryan', 'Ryan', '2008-06-03 00:00:00', 'hi', 'We chose...', 'Ryan would like a bike with training wheels.', 'Please join us at...', '', 'notConfirmed', NULL, 'macaroni', 0, 1, 'published', 13, 5, '2012-09-11 01:33:52', '2012-11-13 07:35:15', 'male', NULL, NULL, 'complete', 0, 1, 'ryan-s-5th-birthday', 1, 1, 0, '2013-05-24', 'default', NULL, 'optional', NULL),
(16, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'notConfirmed', NULL, NULL, 0, 1, 'in_progress', 14, 1, '2012-09-11 13:49:24', '2012-09-11 13:49:24', NULL, NULL, NULL, 'open', 0, 1, NULL, 1, 1, 0, NULL, 'default', NULL, 'optional', NULL),
(17, 'Ellis'' 3rd Birthday Party!', '2012-10-21 00:00:00', NULL, NULL, '0.50', 'Ellis', 'Ellis', '2009-10-15 00:00:00', 'We can''t wait to celebrate Ellis'' birthday with all of you!  We are also excited to introduce you to shareyourwish, a site developed for our children :)', 'We selected charities that we have been touched by and that we think do amazing things for others.', 'Ellis is very into drumming on every pot and pan in the house!  SOO, we think a drumset would be an amazing gift.', '', '', 'notConfirmed', NULL, 'Eboy', 0, 1, 'published', 2, 5, '2012-09-12 16:10:29', '2012-11-13 07:35:15', 'male', NULL, NULL, 'complete', 0, 1, 'ellis-party', 1, 1, 0, '2012-10-11', 'default', NULL, 'optional', NULL),
(18, 'Olivia''s ballerina birthday party', '2013-07-30 00:00:00', '13:30:00', '15:00:00', '0.50', 'Olivia', 'Olivia', '2010-07-30 00:00:00', NULL, NULL, NULL, NULL, NULL, 'notConfirmed', NULL, NULL, 0, 1, 'in_progress', 15, 3, '2012-09-12 18:30:44', '2012-11-13 07:35:15', 'female', NULL, NULL, 'open', 0, 1, NULL, 1, 1, 0, '2013-07-20', 'default', NULL, 'optional', NULL),
(19, ' Ellis'' 3rd birthday', '2012-10-21 00:00:00', NULL, NULL, '0.50', 'Ellis', 'Ellis', '2009-10-15 00:00:00', NULL, NULL, NULL, NULL, NULL, 'notConfirmed', NULL, NULL, 0, 1, 'in_progress', 16, 3, '2012-09-12 18:47:09', '2012-11-13 07:35:15', 'male', NULL, NULL, 'open', 0, 1, NULL, 1, 1, 0, '2012-10-11', 'default', NULL, 'optional', NULL),
(20, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'notConfirmed', NULL, NULL, 0, 1, 'in_progress', 17, 1, '2012-09-12 19:41:13', '2012-09-12 19:41:13', NULL, NULL, NULL, 'open', 0, 1, NULL, 1, 1, 0, NULL, 'default', NULL, 'optional', NULL),
(21, 'Ayla''s SuperJumpingMonkey 5th Birthday Party!', '2013-01-21 00:00:00', NULL, NULL, '0.50', 'Ayla', 'Ayla', '2008-01-20 00:00:00', 'We are so excited to celebrate Ayla''s 5th birthday with all of you!  More importantly, we are so excited to see Ayla share her birthday.  Ayla is very fortunate to have so many wonderful toys and we think this is a great opportunity to start to teach her to appreciate what she has, while learning the virtues of being charitable.  Not to mention, her toys are taking over our house!!', 'We sat down with Ayla and told her about some of the charities we thought she might have an interest in and let her pick a couple that she liked.  She immediately wanted Alex''s Lemonade Stand because she wants to do a lemonade stand!  She also like Baby Buggy because she wanted to give babies coats to keep them warm.  We also chose Friends of Karen because we support their cause of helping children with life-threatening diseases, and because they are local.', 'Ayla has always been into music - ever since her very first drum she got when she turned 1.  Since then, she has gotten morracas, tamborines, and a guitar, among others.  But, when we recently went to a friend''s house where they had a drum set, she could not get enough of it.  We think she would love a drum set of her own, even if our ears may not!!', '', 'We just wanted to thank you all for participating in making this party a very special one for Ayla that she will hopefully learn from and take with her for the rest of her life!', 'notConfirmed', NULL, 'Monkey', 0, 1, 'published', 2, 5, '2012-09-14 01:26:59', '2012-11-13 07:35:15', 'female', NULL, NULL, 'complete', 0, 2, 'ayla-s5thbirthday', 1, 1, 0, '2013-01-11', 'default', NULL, 'optional', NULL),
(22, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'notConfirmed', NULL, NULL, 0, 1, 'in_progress', 18, 1, '2012-09-17 16:14:53', '2012-09-17 16:14:53', NULL, NULL, NULL, 'open', 0, 1, NULL, 1, 1, 0, NULL, 'default', NULL, 'optional', NULL),
(23, 'Birthday Party', '2012-10-21 00:00:00', '14:00:00', '15:30:00', '0.50', 'Ellis', 'Ellis', '2009-10-15 00:00:00', 'We hope you can celebrate Ellis'' third birthday with us!  Ellis has brought so much laughter, happiness, and even a bit of messiness into our lives :)  What also makes his party so special is we will be sharing our new business, which was truly inspired by Ellis and his big sister Ayla!  ', 'We chosethree charities that we feel the work they do is wonderful.  Voices Against Brain Cancer is close to our hearts because of a personal connection.  Our dear friends Jodi and Michael Shapiro are facing brain cancer and VABC has been a huge support to them every step of the way.', 'Ellis loves music, especially drumming on anything he can get his hands on!  We know our house will be a bit louder, but he''d love a drumset!', 'Ellis'' party will be at our home.  Weather permitting it will be outdoors with an awesome entertainer Brett Band.', 'Lunch will not be served, but treats certainly will be!', 'notConfirmed', NULL, 'Party time', 0, 1, 'published', 2, 5, '2012-09-19 19:13:21', '2012-11-13 07:35:15', 'male', NULL, NULL, 'complete', 0, 2, 'ellis-rockin-3rd-birthday', 1, 1, 0, '2012-10-11', 'default', NULL, 'optional', NULL),
(24, 'Random Holiday', '2013-05-22 00:00:00', NULL, NULL, '1.00', 'Super Kid', 'Super Kid', '2009-03-18 00:00:00', NULL, NULL, NULL, NULL, NULL, 'notConfirmed', NULL, NULL, 0, 1, 'in_progress', 19, 3, '2012-09-24 16:18:31', '2012-11-13 07:35:15', 'female', NULL, NULL, 'open', 0, 1, NULL, 1, 1, 0, '2013-05-12', 'default', NULL, 'optional', NULL),
(25, 'Birthday Party', '2012-11-09 00:00:00', '13:00:00', NULL, '0.50', 'Share', 'Share', '2009-11-04 00:00:00', 'Some example text here', 'An alternate set of example text ', 'Barbie playhouse', '', '', 'notConfirmed', NULL, 'sharing', 0, 1, 'published', 2, 5, '2012-09-24 17:21:28', '2012-11-13 07:35:15', 'female', NULL, NULL, 'complete', 0, 1, 'sharing-rocks', 1, 1, 0, '2012-10-30', 'default', NULL, 'optional', NULL),
(26, 'Ellis'' Third Bday!', '2012-10-21 00:00:00', NULL, NULL, '0.50', 'Ellis', 'Ellis', '2009-10-15 00:00:00', 'We are so excited to share Ellis'' special day with you!  It is hard to believe that he is already 3 yrs old.  He has brought so much happiness, love, and even some messiness into our lives :)  Ellis and his big sister Ayla have also helped inspire us to start SYW, which our party guests are using before anyone else!  We are very excited to share it with you for E''s bday and hope that you''ll use it when celebrating your children''s special day!  We can celebrate our youngsters and teach them the importance of giving back!', 'We selected charities that we think do incredible things for others.', 'Ellis loves to rock out!  We think it''s time to reclaim our pots and pans and get him a drumset!  ', 'The party will be at our house, weather permitting it will be outside!  Brett Band will entertain us and dessert will be served.', 'Please keep in mind that Shareyourwish is not yet launched to the public.  We realize we have things to still work out so pls feel free to give us some feedback!', 'notConfirmed', NULL, 'share', 0, 1, 'published', 2, 5, '2012-09-24 17:37:22', '2012-11-13 07:35:15', 'male', NULL, NULL, 'complete', 0, 2, 'ellis-rocks', 1, 1, 0, '2012-10-11', 'default', NULL, 'optional', NULL),
(27, 'Ellis'' Rock N'' Roll 3rd Birthday', '2012-10-21 00:00:00', '14:00:00', '15:30:00', '0.50', 'Ellis', 'Ellis', '2009-10-15 00:00:00', 'Some example text here', 'An alternate set of example text ', 'Drum set', 'Brett the Music Man', '', 'notConfirmed', NULL, 'E Boy', 0, 1, 'published', 2, 5, '2012-09-25 15:11:21', '2012-11-13 07:35:15', 'male', NULL, NULL, 'complete', 0, 2, 'eboy-s3rdbday', 1, 1, 0, '2012-10-11', 'default', NULL, 'optional', NULL),
(29, 'Test Birthday', '2013-01-03 00:00:00', '13:00:00', '14:00:00', '0.75', 'Test', 'Test', '2002-01-01 00:00:00', 'Some example text here', 'Some example text here', 'Some example text here', 'Some example text here', '', 'notConfirmed', NULL, NULL, 0, 1, 'in_progress', 20, 5, '2012-09-26 17:41:57', '2012-11-13 07:35:15', 'female', NULL, NULL, 'open', 0, 1, 'testbirthdayfun', 1, 1, 0, '2012-12-24', 'default', NULL, 'optional', NULL),
(31, 'Ellis'' Rockin Bday!', '2012-10-21 00:00:00', '14:00:00', '15:30:00', '0.50', 'Ellis', 'Ellis', '2009-10-15 00:00:00', 'We are so excited to share Ellis'' 3rd birthday with all of you!  It is so hard to believe that he''s going to be 3, time truly flies.  Ellis brings so much happiness, love, and even a bit of messiness to our lives :)  Ellis and his big sister Ayla have also been the inspiration behind our new business Shareyourwish, which is still in private launch, but we couldn''t have his party without it!', 'We have chosen a charity that is very important to us.  ', 'Drumset', 'our house', '', 'notConfirmed', NULL, 'ellis''bday', 0, 1, 'published', 2, 5, '2012-09-28 00:08:10', '2012-11-13 07:35:15', 'male', NULL, NULL, 'complete', 0, 1, 'partytime', 1, 1, 0, '2012-10-11', 'default', NULL, 'optional', NULL),
(34, 'Max Man Birthday Bash', '2013-04-25 00:00:00', NULL, NULL, '0.75', 'Max Arcamone', 'Max Arcamone', '2010-04-27 00:00:00', 'Some example text here', 'Some example text here', 'Some example text here', 'Some example text here', '', 'notConfirmed', NULL, 'Max Maniac', 0, 1, 'published', 2, 5, '2012-09-28 16:02:38', '2012-11-13 07:35:15', 'male', NULL, NULL, 'complete', 0, 2, 'maxman', 1, 1, 0, '2013-04-15', 'default', NULL, 'optional', NULL),
(35, 'Bingo''s Birthday', '2013-03-02 00:00:00', NULL, NULL, '0.50', 'Bingo Rufus', 'Bingo Rufus', '1996-03-02 00:00:00', 'sdfsd sfd', 'sdfsd f', 'sd sdf and so on', '', '', 'notConfirmed', NULL, 'sdfsdfsdf', 0, 2, 'published', 1, 5, '2012-09-28 17:49:30', '2012-11-13 07:35:15', 'male', NULL, NULL, 'complete', 0, 2, 'bleeecj', 1, 1, 0, '2013-02-20', 'default', NULL, 'optional', NULL),
(36, 'Birthday Test', '2012-11-24 00:00:00', NULL, NULL, '0.50', 'Johnnie', 'Johnnie', '2009-11-24 00:00:00', 'Some example text here', 'An alternate set of example text ', 'Some example text here', 'An alternate set of example text ', '', 'notConfirmed', NULL, 'Magic', 0, 2, 'published', 2, 5, '2012-09-28 19:55:47', '2012-11-13 07:35:15', 'female', NULL, NULL, 'complete', 0, 2, 'abcde', 1, 1, 0, '2012-11-14', 'default', NULL, 'optional', NULL),
(37, 'Ellis'' Rocking Third Birthday Party', '2012-10-21 00:00:00', '14:00:00', '15:30:00', '0.50', 'Ellis', 'Ellis', '2009-10-15 00:00:00', 'Some example text here', 'An alternate set of example text ', 'Drum set, skateboard, pads', 'Brett will there!', '', 'notConfirmed', NULL, 'EBoy', 0, 1, 'published', 2, 5, '2012-09-28 21:07:51', '2012-11-13 07:35:15', 'male', NULL, NULL, 'complete', 0, 2, 'ellis-b-day', 1, 1, 0, '2012-10-11', 'default', NULL, 'optional', NULL),
(38, 'None of your business', '2013-03-03 00:00:00', NULL, NULL, '1.00', 'Sneaky Pete', 'Sneaky Pete', '1995-03-04 00:00:00', 'sdf sdfsdf 3', 'dfg sdfg sd fg', 'sdfg sdfg', '', '', 'notConfirmed', NULL, NULL, 0, 1, 'in_progress', 1, 5, '2012-09-28 22:42:58', '2012-12-18 20:33:14', 'female', NULL, NULL, 'open', 0, 1, 'none-of-your-business', 1, 1, 0, '2013-02-21', 'default', '2012-12-18 20:33:14', 'optional', NULL),
(39, 'Test Birthday', '2012-10-21 00:00:00', NULL, NULL, '0.50', 'Ellis', 'Ellis', '2009-10-15 00:00:00', 'Some example text here', 'Some example text here', 'Some example text here', 'Some example text here', '', 'notConfirmed', NULL, 'Test1', 0, 2, 'published', 2, 5, '2012-09-29 00:26:28', '2012-11-13 07:35:15', 'male', NULL, NULL, 'complete', 0, 2, 'test1', 1, 1, 0, '2012-10-11', 'default', NULL, 'optional', NULL),
(40, 'bababa', '2013-03-08 00:00:00', NULL, NULL, '0.50', 'bababa', 'bababa', '2010-03-02 00:00:00', 'blah', 'blah', 'blah', '', '', 'notConfirmed', NULL, 'asdf', 0, 1, 'published', 2, 5, '2012-10-02 20:46:35', '2013-02-15 19:35:21', 'male', '', '', 'complete', 0, 2, 'bababa', 1, 1, 0, '2013-02-25', 'default', NULL, 'optional', NULL),
(41, 'авпы', '2013-01-06 00:00:00', NULL, NULL, '0.25', 'вапавы', 'ваыпваып', '1997-02-05 00:00:00', NULL, NULL, NULL, NULL, NULL, 'notConfirmed', NULL, NULL, 0, 1, 'in_progress', 5, 2, '2012-11-01 12:23:03', '2012-12-07 13:34:06', 'male', '', '', 'open', 0, 1, '', 1, 1, 0, '2012-12-26', 'default', NULL, 'optional', NULL),
(42, 'Levi''s Lego 5th Birthday Party', '2013-01-27 00:00:00', NULL, NULL, '0.50', 'Levi Putter', 'Naomi and Eric', '2008-01-04 00:00:00', 'test', 'test', 'test', '', '', 'notConfirmed', NULL, 'donkey poo', 0, 1, 'published', 1, 5, '2012-12-18 20:33:17', '2013-01-15 00:48:27', 'male', 'Our House', '4 Lakeshore Close, Sleepy Hollow', 'complete', 0, 2, 'levi-s-lego-5th-birthday-party', 1, 1, 0, '2013-01-16', 'default', NULL, 'optional', NULL),
(43, 'jhdf g btrb b', '2013-03-03 00:00:00', NULL, NULL, '0.75', 'dfg dfg', 'dfg dfh', '1998-02-02 00:00:00', NULL, NULL, NULL, NULL, NULL, 'notConfirmed', NULL, NULL, 0, 1, 'in_progress', 23, 2, '2012-12-30 17:11:02', '2012-12-30 17:11:22', 'male', '', '', 'open', 0, 1, 'jhdf-g-btrb-b', 1, 1, 0, '2013-02-20', 'default', NULL, 'optional', NULL),
(44, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'notConfirmed', NULL, NULL, 0, 1, 'in_progress', 3, 1, '2013-01-12 14:51:25', '2013-01-12 14:51:25', NULL, NULL, NULL, 'open', 0, 1, NULL, 1, 1, 0, NULL, 'default', NULL, 'optional', NULL),
(45, 'Test Real CC in Staging', '2013-03-05 00:00:00', NULL, NULL, '0.75', 'Thum', 'Bling and Block', '1996-04-03 00:00:00', 'test1', 'tet2', 'test3', '', '', 'notConfirmed', NULL, 'yummy tumms', 0, 1, 'published', 1, 5, '2013-01-15 00:48:36', '2013-01-15 00:54:46', 'female', '', '', 'complete', 0, 2, 'test-real-cc-in-staging', 1, 1, 0, '2013-02-22', 'default', NULL, 'optional', NULL),
(46, 'My new v99 event', '2013-04-04 00:00:00', NULL, NULL, '0.75', 'Ringo', 'Sam and Bam', '1998-03-03 00:00:00', 'sample text 1 sample text sample text sample text sample text sample text sample text sample text', 'bloo', 'bleh', '', '', 'notConfirmed', NULL, 'igloo', 0, 1, 'in_progress', 1, 5, '2013-01-15 01:04:07', '2013-02-15 05:16:01', 'male', '', '', 'open', 0, 1, 'my-new-v99-event', 1, 1, 0, '2013-03-24', 'default', NULL, 'optional', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `events_log`
--

CREATE TABLE IF NOT EXISTS `events_log` (
  `id` int(11) NOT NULL auto_increment,
  `event_id` int(11) default NULL,
  `content` text collate utf8_unicode_ci,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `event_activity_logs`
--

CREATE TABLE IF NOT EXISTS `event_activity_logs` (
  `id` int(11) NOT NULL auto_increment,
  `message` text collate utf8_unicode_ci,
  `is_internal` tinyint(1) default '1',
  `event_id` int(11) default NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `type_of` int(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_event_activity_logs_on_event_id` (`event_id`),
  KEY `index_event_activity_logs_on_type_of` (`type_of`),
  KEY `index_event_activity_logs_on_is_internal` (`is_internal`),
  KEY `index_event_activity_logs_on_created_at` (`created_at`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=77 ;

--
-- Dumping data for table `event_activity_logs`
--

INSERT INTO `event_activity_logs` (`id`, `message`, `is_internal`, `event_id`, `created_at`, `updated_at`, `type_of`) VALUES
(42, 'Buck status change: Guest has visited your Event page', 0, 36, '2012-10-05 15:20:54', '2012-10-05 15:20:54', 1),
(43, 'george the monkey status change: Invitation has been sent', 0, 3, '2012-11-02 01:27:08', '2012-11-02 01:27:08', 1),
(44, 'Eric created new event ', 0, 42, '2012-12-18 20:33:17', '2012-12-18 20:33:17', 1),
(45, 'test 123 created new event ', 0, 43, '2012-12-30 17:11:02', '2012-12-30 17:11:02', 1),
(46, 'tester has self-registered using the magic phrase', 0, 8, '2013-01-01 19:14:28', '2013-01-01 19:14:28', 1),
(47, 'tester status change: Guest has visited your Event page', 0, 8, '2013-01-01 19:14:29', '2013-01-01 19:14:29', 1),
(48, 'Dingo has self-registered using the magic phrase', 0, 8, '2013-01-01 19:18:26', '2013-01-01 19:18:26', 1),
(49, 'Dingo status change: Guest has visited your Event page', 0, 8, '2013-01-01 19:18:26', '2013-01-01 19:18:26', 1),
(50, 'george the monkey status change: Guest has visited your Event page', 0, 3, '2013-01-09 04:01:27', '2013-01-09 04:01:27', 1),
(51, 'george the monkey has made an undisclosed contribution', 0, 3, '2013-01-09 04:02:24', '2013-01-09 04:02:24', 1),
(52, 'Rebecca created new event ', 0, 44, '2013-01-12 14:51:25', '2013-01-12 14:51:25', 1),
(53, 'Buck status change: Invitation has been sent', 0, 21, '2013-01-13 02:05:09', '2013-01-13 02:05:09', 1),
(54, 'Buck status change: Guest has visited your Event page', 0, 21, '2013-01-13 02:07:14', '2013-01-13 02:07:14', 1),
(59, 'Eric published the event Levi''s Lego 5th Birthday Party', 0, 42, '2013-01-15 00:48:27', '2013-01-15 00:48:27', 1),
(60, 'Eric created new event ', 0, 45, '2013-01-15 00:48:36', '2013-01-15 00:48:36', 1),
(61, 'Eric published the event Test Real CC in Staging', 0, 45, '2013-01-15 00:54:46', '2013-01-15 00:54:46', 1),
(62, 'Eric created new event ', 0, 46, '2013-01-15 01:04:07', '2013-01-15 01:04:07', 1),
(63, 'Jimbo status change: Guest has visited your Event page', 0, 45, '2013-01-15 01:22:02', '2013-01-15 01:22:02', 1),
(69, 'Eric Putter status change: Invitation has been sent', 0, 42, '2013-02-05 14:46:52', '2013-02-05 14:46:52', 1),
(70, 'Eric Putter status change: Guest has visited your Event page', 0, 42, '2013-02-05 14:48:17', '2013-02-05 14:48:17', 1),
(71, 'Jesper status change: Invitation has been sent', 0, 42, '2013-02-05 14:50:02', '2013-02-05 14:50:02', 1),
(72, 'Nobody Real status change: Invitation has been sent', 0, 42, '2013-02-05 14:50:26', '2013-02-05 14:50:26', 1),
(73, 'Buck published the event bababa', 0, 40, '2013-02-15 19:35:21', '2013-02-15 19:35:21', 1),
(74, 'Buck status change: Invitation has been sent', 0, 40, '2013-02-15 19:36:27', '2013-02-15 19:36:27', 1),
(75, 'Buck status change: Guest has visited your Event page', 0, 40, '2013-02-15 19:38:25', '2013-02-15 19:38:25', 1),
(76, 'Buck status change: Guest chose not to participate', 0, 40, '2013-02-15 19:39:15', '2013-02-15 19:39:15', 1);

-- --------------------------------------------------------

--
-- Table structure for table `event_transaction_logs`
--

CREATE TABLE IF NOT EXISTS `event_transaction_logs` (
  `id` int(11) NOT NULL auto_increment,
  `event_transaction_log_category_id` int(11) default NULL,
  `description` varchar(255) collate utf8_unicode_ci default NULL,
  `memo` varchar(255) collate utf8_unicode_ci default NULL,
  `event_fund` decimal(10,2) default '0.00',
  `gift_fund` decimal(10,2) default '0.00',
  `donation_fund` decimal(10,2) default '0.00',
  `syw_fund` decimal(10,2) default '0.00',
  `contribution_id` int(11) default NULL,
  `event_id` int(11) default NULL,
  `payment_id` int(11) default NULL,
  `charity_id` int(11) default NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=13 ;

--
-- Dumping data for table `event_transaction_logs`
--

INSERT INTO `event_transaction_logs` (`id`, `event_transaction_log_category_id`, `description`, `memo`, `event_fund`, `gift_fund`, `donation_fund`, `syw_fund`, `contribution_id`, `event_id`, `payment_id`, `charity_id`, `created_at`, `updated_at`) VALUES
(1, 101, 'Opening Balance', NULL, '0.00', '0.00', '0.00', '0.00', NULL, 42, NULL, NULL, '2012-12-18 20:33:17', '2012-12-18 20:33:17'),
(2, 101, 'Opening Balance', NULL, '0.00', '0.00', '0.00', '0.00', NULL, 43, NULL, NULL, '2012-12-30 17:11:02', '2012-12-30 17:11:02'),
(3, 102, 'Contribution (7) from (george the monkey) (3)', NULL, '24.00', '0.00', '0.00', '0.00', 7, 3, 1, NULL, '2013-01-09 04:02:24', '2013-01-09 04:02:24'),
(4, 103, 'Deduct CC fee from Contribution (7)', NULL, '-1.00', '0.00', '0.00', '1.00', 7, 3, NULL, NULL, '2013-01-09 04:02:24', '2013-01-09 04:02:24'),
(5, 104, 'Deduct SYW fee from Contribution (7)', NULL, '-2.00', '0.00', '0.00', '2.00', 7, 3, NULL, NULL, '2013-01-09 04:02:24', '2013-01-09 04:02:24'),
(6, 105, 'Gift Fund Allocation from Contribution (7)', NULL, '-21.00', '21.00', '0.00', '0.00', 7, 3, NULL, NULL, '2013-01-09 04:02:24', '2013-01-09 04:02:24'),
(7, 106, 'Donation Fund Allocation from Contribution (7)', 'Save the Children (10106)', '0.00', '0.00', '0.00', '0.00', 7, 3, NULL, 160, '2013-01-09 04:02:24', '2013-01-09 04:02:24'),
(8, 101, 'Opening Balance', NULL, '0.00', '0.00', '0.00', '0.00', NULL, 44, NULL, NULL, '2013-01-12 14:51:25', '2013-01-12 14:51:25'),
(9, 107, 'Purchase', 'Upgrade Package', '0.00', '0.00', '0.00', '31.45', NULL, 42, 2, NULL, '2013-01-15 00:48:27', '2013-01-15 00:48:27'),
(10, 101, 'Opening Balance', NULL, '0.00', '0.00', '0.00', '0.00', NULL, 45, NULL, NULL, '2013-01-15 00:48:36', '2013-01-15 00:48:36'),
(11, 107, 'Purchase', 'Upgrade Package', '0.00', '0.00', '0.00', '4.00', NULL, 45, 3, NULL, '2013-01-15 00:54:46', '2013-01-15 00:54:46'),
(12, 101, 'Opening Balance', NULL, '0.00', '0.00', '0.00', '0.00', NULL, 46, NULL, NULL, '2013-01-15 01:04:07', '2013-01-15 01:04:07');

-- --------------------------------------------------------

--
-- Table structure for table `feedbacks`
--

CREATE TABLE IF NOT EXISTS `feedbacks` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) default NULL,
  `name` varchar(255) collate utf8_unicode_ci default NULL,
  `email` varchar(255) collate utf8_unicode_ci default NULL,
  `title` varchar(255) collate utf8_unicode_ci default NULL,
  `message` text collate utf8_unicode_ci,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

--
-- Dumping data for table `feedbacks`
--

INSERT INTO `feedbacks` (`id`, `user_id`, `name`, `email`, `title`, `message`, `created_at`, `updated_at`) VALUES
(1, NULL, 'Joe Tester', 'joe@test.com', 'what is title?', 'Good Day, sir', '2012-09-27 00:21:50', '2012-09-27 00:21:50');

-- --------------------------------------------------------

--
-- Table structure for table `guests`
--

CREATE TABLE IF NOT EXISTS `guests` (
  `id` int(11) NOT NULL auto_increment,
  `event_id` int(11) default NULL,
  `user_id` int(11) default NULL,
  `full_name` varchar(255) collate utf8_unicode_ci default NULL,
  `email` varchar(255) collate utf8_unicode_ci default NULL,
  `lookup_guests_status_id` int(11) default '1',
  `guest_access_token` varchar(255) collate utf8_unicode_ci default NULL,
  `hidden` tinyint(1) default '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `invited_children` varchar(255) collate utf8_unicode_ci default NULL,
  `attendance` varchar(255) collate utf8_unicode_ci default 'no_reply',
  `message` varchar(255) collate utf8_unicode_ci default NULL,
  `braintree_customer_id` int(11) default NULL,
  `deleted_at` datetime default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_guests_on_hidden` (`hidden`),
  KEY `index_guests_on_email` (`email`),
  KEY `index_guests_on_attendance` (`attendance`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1000027 ;

--
-- Dumping data for table `guests`
--

INSERT INTO `guests` (`id`, `event_id`, `user_id`, `full_name`, `email`, `lookup_guests_status_id`, `guest_access_token`, `hidden`, `created_at`, `updated_at`, `invited_children`, `attendance`, `message`, `braintree_customer_id`, `deleted_at`) VALUES
(1, 4, 2, '', '', 1, '55', 0, '2012-07-13 02:48:13', '2012-09-02 04:52:13', NULL, 'no', NULL, NULL, NULL),
(2, 4, 2, 'asdfasdf', 'asdfsadf@asdsdf.com', 1, '0', 0, '2012-07-19 00:48:39', '2012-09-02 04:52:13', NULL, 'no', NULL, NULL, NULL),
(3, 3, 1, 'george the monkey', 'themonkey@jungle.com', 6, '0', 0, '2012-08-15 14:45:01', '2013-01-09 04:02:21', 'what is this', 'yes', NULL, 1503838, NULL),
(4, 5, 2, 'sdf', 'asdf@asdf.com', 1, '0', 0, '2012-08-18 00:21:36', '2012-09-02 04:52:13', NULL, 'no', NULL, NULL, NULL),
(7, 9, NULL, 'tester', 'test@testing.com', 1, '76f22f3c15ab5a96f53150f971ee65eb', 0, '2012-09-10 03:01:31', '2012-09-10 03:01:31', NULL, 'no', NULL, NULL, NULL),
(8, 9, NULL, 'george', 'eric2@ericputter.com', 2, '00923fb76a4697ab86083b82debc199b', 0, '2012-09-10 03:04:32', '2012-09-10 03:13:02', NULL, 'no', NULL, NULL, NULL),
(9, 9, NULL, 'keee', 'eric2@veryinventive.com', 2, '220c10e1b5a87812dbfb7cebdad32f05', 0, '2012-09-10 03:04:47', '2012-09-19 14:40:30', NULL, 'no', NULL, NULL, NULL),
(10, 15, NULL, 'chris arcamone', 'chris.arcamone@otrglobal.com', 1, '7109f22d33f03cbeeaf3122ccb9eb386', 0, '2012-09-11 01:43:49', '2012-09-11 01:43:49', NULL, 'no', NULL, NULL, NULL),
(11, 17, NULL, 'Buck', 'Buckota@aol.com', 2, '6b8c7c64a498f4ea295128b38a760616', 0, '2012-09-13 00:27:02', '2012-09-13 17:01:11', NULL, 'no', NULL, NULL, NULL),
(12, 3, NULL, 'joe', 'franken@doodle.com', 2, '7529134d76cef33ee585e2b0096649fd', 0, '2012-09-21 20:55:17', '2012-09-25 16:13:40', NULL, 'no', NULL, NULL, NULL),
(13, 23, NULL, 'Rebecca', 'Rebecca@shareyourwish.com', 2, '3dbae837ccf5f72234e5822d140686a3', 0, '2012-09-24 16:39:35', '2012-09-26 00:27:20', NULL, 'no', NULL, NULL, NULL),
(14, 25, NULL, 'Rebecca', 'Rluks@yahoo.com', 1, '321f95af8b9fe0c692e2fc5a556ab122', 0, '2012-09-24 17:36:53', '2012-09-24 17:36:53', NULL, 'no', NULL, NULL, NULL),
(15, 26, NULL, 'Alex', 'alexreichgott@gmail.com', 2, '510254a3e5481222a0be21cfa4e5b873', 0, '2012-09-25 14:31:10', '2012-09-25 14:36:53', NULL, 'no', NULL, NULL, NULL),
(17, 26, NULL, 'Rebecca', 'rschleif11@gmail.com', 2, '1b1e6330197b32a2434f697c6454b545', 0, '2012-09-25 14:53:54', '2012-09-25 14:54:06', NULL, 'no', NULL, NULL, NULL),
(18, 26, NULL, 'Buck', 'Buck@ox.com', 2, '84c931112fe09140c1ff3dffb22edb4c', 0, '2012-09-25 14:54:31', '2012-09-25 14:54:59', NULL, 'no', NULL, NULL, NULL),
(19, 26, NULL, 'Joan', 'joan@serenatagroup.com', 2, '5789a84bf12105e85ac6a3c4e4c8b7ac', 0, '2012-09-25 14:59:39', '2012-09-25 15:01:02', NULL, 'no', NULL, NULL, NULL),
(20, 3, NULL, 'eric', 'eric@ericputter2.com', 1, '245f5b9f63efbb0b7ff9dfc28911d71f', 0, '2012-09-25 15:52:43', '2012-09-25 15:52:43', NULL, 'no', NULL, NULL, NULL),
(21, 3, NULL, 'Mister TV', 'eric@ericputter.com', 2, '00923fb76a4697ab86083b82debc199b', 0, '2012-09-25 17:31:36', '2012-11-02 02:17:47', '', 'no', NULL, NULL, NULL),
(22, 3, NULL, 'eric3', 'eric@veryinventive.com', 3, '220c10e1b5a87812dbfb7cebdad32f05', 0, '2012-09-25 17:35:09', '2012-09-26 00:13:44', NULL, 'no', NULL, NULL, NULL),
(999999, NULL, NULL, 'Default Guest', 'default@guest.com', 1, '5', 0, '2012-09-02 04:52:13', '2012-09-02 04:52:13', NULL, 'no', NULL, NULL, NULL),
(1000000, 23, NULL, 'Rebecca', 'Rluks@yahoo.com', 3, '321f95af8b9fe0c692e2fc5a556ab122', 0, '2012-09-26 00:25:29', '2012-09-26 00:28:12', NULL, 'no', NULL, NULL, NULL),
(1000001, 23, NULL, 'Buck', 'Buckota@aol.com', 3, '6b8c7c64a498f4ea295128b38a760616', 0, '2012-09-26 01:42:06', '2012-09-26 01:44:16', NULL, 'no', NULL, NULL, NULL),
(1000002, 27, NULL, 'Buck', 'buck@ox.com', 3, '594c2eb6eeef069f0ff74b411f14a66e', 0, '2012-09-27 01:44:15', '2012-09-27 01:50:47', 'Ellis, Ayla', 'no', NULL, NULL, NULL),
(1000003, 31, NULL, 'Rebecca', 'Rluks@yahoo.com', 3, '321f95af8b9fe0c692e2fc5a556ab122', 0, '2012-09-28 00:34:16', '2012-09-28 00:36:27', 'Ayla', 'no', NULL, NULL, NULL),
(1000005, 30, NULL, 'Some Guy', 'some@guy.com', 1, '4ce7912e144f2d31514032250a80d69f', 0, '2012-09-28 15:37:39', '2012-09-28 15:37:39', '', 'no', NULL, NULL, NULL),
(1000006, 34, NULL, 'ChrisCjhr', 'Chrisarcamone@gmail.com', 2, '1930b19e99a8cdf9a4c4c458fbc29401', 0, '2012-09-28 16:15:12', '2012-09-28 16:18:38', 'list names', 'no', NULL, NULL, NULL),
(1000007, 21, NULL, 'Buck', 'buck@ox.com', 2, '594c2eb6eeef069f0ff74b411f14a66e', 0, '2012-09-28 16:35:04', '2012-09-28 16:35:17', 'Ayla and ELlis', 'no', NULL, NULL, NULL),
(1000008, 21, NULL, 'Chris', 'chris.arcamone@otrglobal.com', 3, '7109f22d33f03cbeeaf3122ccb9eb386', 0, '2012-09-28 16:36:13', '2012-09-28 16:40:50', 'Ryan and Max', 'no', NULL, NULL, NULL),
(1000009, 36, NULL, 'Buck', 'buckota@aol.com', 3, 'db979974c8b0ccf885fef4a47279ddd8', 0, '2012-09-28 20:00:18', '2012-10-05 15:20:53', 'Ayla and Ellis', 'no', NULL, NULL, NULL),
(1000010, 37, NULL, 'Buck', 'buckota@aol.com', 3, 'db979974c8b0ccf885fef4a47279ddd8', 0, '2012-09-28 21:23:14', '2012-09-29 00:28:07', 'Ayla and Ellis', 'no', NULL, NULL, NULL),
(1000011, 35, NULL, 'Eric P', 'eric@ericputter.com', 2, '00923fb76a4697ab86083b82debc199b', 0, '2012-09-28 22:43:22', '2012-09-28 22:43:36', 'Joe and Sally', 'no', NULL, NULL, NULL),
(1000012, 39, NULL, 'Buck Schleifer', 'sywtest1@gmail.com', 3, 'f27595f4254ca6d3840b21c0faf7db62', 0, '2012-10-01 14:18:50', '2012-10-01 16:20:45', 'Ayla and Ellis', 'no', NULL, NULL, NULL),
(1000013, 39, NULL, 'Buck Schleifer', 'buck@ox.com', 3, '594c2eb6eeef069f0ff74b411f14a66e', 0, '2012-10-01 14:28:04', '2012-10-01 14:28:18', 'Ayla and Ellis', 'no', NULL, NULL, NULL),
(1000014, 39, NULL, 'Buck Schleifer', 'buckota@aol.com', 3, 'db979974c8b0ccf885fef4a47279ddd8', 0, '2012-10-01 14:36:32', '2012-10-01 14:39:32', 'Ayla and Ellis', 'no', NULL, NULL, NULL),
(1000015, 39, NULL, 'Buck Schleifer', 'buckschleifer@gmail.com', 3, '3ac43e46e82deaefa4ae1c2409cd465d', 0, '2012-10-01 14:36:48', '2012-10-01 16:18:50', 'Ayla and Ellis', 'no', NULL, NULL, NULL),
(1000016, 3, NULL, 'Wag', 'wagbott@gmail.com', 3, 'fd2f1f96298bc9ec0238957984abb5e0', 0, '2012-10-01 14:53:35', '2012-10-03 14:34:25', '', 'maybe', NULL, NULL, NULL),
(1000017, 38, NULL, 'Firsty Mirsty', 'first@mirst.com', 1, '3f7ef37ba7b8a65ce939597b29e99aa7', 0, '2012-11-08 05:08:32', '2012-12-18 20:33:14', '', 'no_reply', NULL, NULL, '2012-12-18 20:33:14'),
(1000018, 3, NULL, 'Boy ', 'goerge@themonkey.com', 1, '8d8e5e42184720be5b70b316d1fc03ff', 0, '2012-11-13 07:45:49', '2012-11-13 07:45:49', NULL, 'no_reply', NULL, NULL, NULL),
(1000019, 8, NULL, 'tester', 'testing@tester.com', 3, '7764ecfe2a267a77d8b14849f73b276d', 0, '2013-01-01 19:14:28', '2013-01-01 19:14:29', NULL, 'no_reply', NULL, NULL, NULL),
(1000020, 8, NULL, 'Dingo', 'dingo@baby.com', 3, '244388593bd528411c580a629934d9ff', 0, '2013-01-01 19:18:26', '2013-01-01 19:18:26', NULL, 'no_reply', NULL, NULL, NULL),
(1000021, 21, NULL, 'Buck', 'buckota@aol.com', 3, 'db979974c8b0ccf885fef4a47279ddd8', 0, '2013-01-13 02:04:51', '2013-01-13 02:07:24', NULL, 'yes', '', NULL, NULL),
(1000022, 45, NULL, 'Jimbo', 'Test@himbo.com', 3, '00537ae0a8e3eae7785bf38e35a2a5ea', 0, '2013-01-15 01:16:39', '2013-01-15 01:22:02', NULL, 'no_reply', NULL, NULL, NULL),
(1000023, 42, NULL, 'Jesper', 'jesper@doodle.com', 2, 'cd39f8e9d0d7090e791f0b27120a4afb', 0, '2013-01-24 05:08:39', '2013-02-05 14:50:02', NULL, 'no_reply', NULL, NULL, NULL),
(1000024, 42, NULL, 'Eric Putter', 'eric@ericputter.com', 3, '00923fb76a4697ab86083b82debc199b', 0, '2013-02-05 14:46:46', '2013-02-05 14:48:17', NULL, 'no_reply', NULL, NULL, NULL),
(1000025, 42, NULL, 'Nobody Real', 'guest@quikokokoiuloi.com', 2, '39ec18938fdad9df0fca50d67af51024', 0, '2013-02-05 14:50:21', '2013-02-05 14:50:26', NULL, 'no_reply', NULL, NULL, NULL),
(1000026, 40, NULL, 'Buck', 'buckota@aol.com', 5, 'db979974c8b0ccf885fef4a47279ddd8', 0, '2013-02-15 19:36:06', '2013-02-15 19:39:15', NULL, 'no', '', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `help_messages`
--

CREATE TABLE IF NOT EXISTS `help_messages` (
  `id` int(11) NOT NULL auto_increment,
  `code` varchar(255) collate utf8_unicode_ci default NULL,
  `text` text collate utf8_unicode_ci,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `index_help_messages_on_code` (`code`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3 ;

--
-- Dumping data for table `help_messages`
--

INSERT INTO `help_messages` (`id`, `code`, `text`, `created_at`, `updated_at`) VALUES
(1, '101-CVV', 'The Card Verification Code is located on the back of your credit card above the signature line. In the case of American Expres.....', '2012-12-13 21:23:56', '2012-12-13 21:23:56'),
(2, '102-Donation-Fund', 'The donation fund is the portion of each guest''s contribution that is.....', '2012-12-13 21:23:56', '2012-12-13 21:23:56');

-- --------------------------------------------------------

--
-- Table structure for table `items`
--

CREATE TABLE IF NOT EXISTS `items` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) collate utf8_unicode_ci default NULL,
  `description` text collate utf8_unicode_ci,
  `cost` decimal(8,2) default NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `sort_order` int(11) NOT NULL default '1',
  `taxable` tinyint(1) NOT NULL default '1',
  `is_package_proxy` tinyint(1) NOT NULL default '0',
  `is_visible` tinyint(1) NOT NULL default '1',
  `deleted_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1008 ;

--
-- Dumping data for table `items`
--

INSERT INTO `items` (`id`, `name`, `description`, `cost`, `created_at`, `updated_at`, `sort_order`, `taxable`, `is_package_proxy`, `is_visible`, `deleted_at`) VALUES
(2, 'Award Wall', 'A place where your child can see themselves, their own online award.', '0.00', '2012-07-06 18:36:40', '2012-09-12 15:13:47', 1, 1, 0, 0, NULL),
(3, 'Sharing Wish Bear', 'A super plush and huggable 10" bear.  This bear wants to be your child''s sharing friend.  It features a Share Your Wish t-shirt and accompanying tag with an important message for your child, encouraging them to continue sharing!\r\n', '19.95', '2012-07-06 18:36:40', '2012-09-06 00:18:44', 1, 1, 0, 1, NULL),
(4, 'Reward Medal', 'A solid metal award with a ribbon that your child can wear with pride.  As a special treat, you can give this medal to your child - just before the cake!\r\n', '6.95', '2012-07-06 18:36:40', '2012-09-07 14:28:13', 1, 1, 0, 1, NULL),
(1001, 'The Great Basic Event Package', 'This is a description for our basic package', '0.00', '0000-00-00 00:00:00', '2012-09-06 00:05:26', 1, 1, 1, 1, NULL),
(1002, 'Super Sharer Extra Fun Package', 'This is a description for the special upgrade package', '29.95', '0000-00-00 00:00:00', '2012-09-06 18:30:30', 1, 1, 1, 1, NULL),
(1003, '5x7 Magnetic Frame', 'Highly versitile magnetic frame, perfect for displaying your sharing star''s reward certificate or a special photo from their birthday party on your fridge.  And the middle insert comes out and is a stand alone magnet!\r\n', '5.95', '2012-09-05 04:22:46', '2012-09-07 14:38:08', 1, 1, 0, 1, NULL),
(1004, '5x7 Stick-on Frame', 'This reusable peel n'' stick adhesive frame is great for laptops, refrigerators, lockers, mirrors, and windows with no residue and acid free, giving you unlimited options for showing off your little sharing star!\r\n', '4.95', '2012-09-05 04:37:43', '2012-09-07 14:38:56', 1, 1, 0, 1, NULL),
(1005, '8x10 Gold Frame (certificate comes separately)', 'Our finest frame, made of quality metal, perfect for showing off how proud of your little sharing star you are.\r\n', '17.95', '2012-09-05 04:45:19', '2012-09-07 14:27:54', 1, 1, 0, 1, NULL),
(1006, 'SYW Crayons', 'Every child loves crayons, and we hope these will make your child feel extra special.  With these they can choose to write their own name on their certificate, or add their own personal design!  These would also make an excellent favor for guests to remind them of how they helped to make this day special.\r\n', '2.50', '2012-09-05 04:49:48', '2012-09-07 14:28:27', 1, 1, 0, 1, NULL),
(1007, 'Reward Certificate', 'Sharing a birthday is very special gesture, and it deserves recognition.  With this certificate, your little sharing star will always be reminded of the good they did.  They can proudly hang this award in their room; on the wall or in a frame.  Invite them to write in their own name!', '2.00', '2012-09-13 15:37:45', '2012-09-13 16:46:06', 1, 1, 0, 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `items_packages`
--

CREATE TABLE IF NOT EXISTS `items_packages` (
  `package_id` int(11) default NULL,
  `item_id` int(11) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `items_packages`
--

INSERT INTO `items_packages` (`package_id`, `item_id`) VALUES
(1, 2),
(2, 4),
(2, 3),
(2, 2),
(2, 1006),
(2, 1003),
(1, 1007),
(2, 1007);

-- --------------------------------------------------------

--
-- Table structure for table `line_items`
--

CREATE TABLE IF NOT EXISTS `line_items` (
  `id` int(11) NOT NULL auto_increment,
  `cart_id` int(11) default NULL,
  `order_id` int(11) default NULL,
  `item_id` int(11) default NULL,
  `quantity` int(11) default '1',
  `cost` decimal(8,2) NOT NULL default '0.00',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `deleted_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=205 ;

--
-- Dumping data for table `line_items`
--

INSERT INTO `line_items` (`id`, `cart_id`, `order_id`, `item_id`, `quantity`, `cost`, `created_at`, `updated_at`, `deleted_at`) VALUES
(181, 99, NULL, 2, 1, '0.00', '2012-12-18 20:33:17', '2012-12-18 20:33:17', '2013-01-15 00:46:03'),
(182, 99, NULL, 1007, 1, '0.00', '2012-12-18 20:33:17', '2012-12-18 20:33:17', '2013-01-15 00:46:03'),
(183, 99, NULL, 1001, 1, '0.00', '2012-12-18 20:33:17', '2012-12-18 20:33:17', '2013-01-15 00:46:03'),
(184, 100, NULL, 2, 1, '0.00', '2012-12-30 17:11:03', '2012-12-30 17:11:03', NULL),
(185, 100, NULL, 1007, 1, '0.00', '2012-12-30 17:11:03', '2012-12-30 17:11:03', NULL),
(186, 100, NULL, 1001, 1, '0.00', '2012-12-30 17:11:03', '2012-12-30 17:11:03', NULL),
(187, 101, NULL, 2, 1, '0.00', '2013-01-12 14:51:25', '2013-01-12 14:51:25', NULL),
(188, 101, NULL, 1007, 1, '0.00', '2013-01-12 14:51:25', '2013-01-12 14:51:25', NULL),
(189, 101, NULL, 1001, 1, '0.00', '2013-01-12 14:51:25', '2013-01-12 14:51:25', NULL),
(190, 99, NULL, 1003, 1, '5.95', '2013-01-15 00:45:56', '2013-01-15 00:45:56', '2013-01-15 00:46:03'),
(191, 99, 1, 4, 1, '0.00', '2013-01-15 00:46:03', '2013-01-15 00:48:23', NULL),
(192, 99, 1, 3, 1, '0.00', '2013-01-15 00:46:03', '2013-01-15 00:48:23', NULL),
(193, 99, 1, 2, 1, '0.00', '2013-01-15 00:46:03', '2013-01-15 00:48:23', NULL),
(194, 99, 1, 1006, 1, '0.00', '2013-01-15 00:46:03', '2013-01-15 00:48:23', NULL),
(195, 99, 1, 1003, 1, '0.00', '2013-01-15 00:46:03', '2013-01-15 00:48:23', NULL),
(196, 99, 1, 1007, 1, '0.00', '2013-01-15 00:46:03', '2013-01-15 00:48:23', NULL),
(197, 99, 1, 1002, 1, '29.95', '2013-01-15 00:46:03', '2013-01-15 00:48:23', NULL),
(198, 102, 2, 2, 1, '0.00', '2013-01-15 00:48:36', '2013-01-15 00:54:43', NULL),
(199, 102, 2, 1007, 1, '0.00', '2013-01-15 00:48:36', '2013-01-15 00:54:43', NULL),
(200, 102, 2, 1001, 1, '0.00', '2013-01-15 00:48:36', '2013-01-15 00:54:43', NULL),
(201, 102, 2, 1006, 1, '2.50', '2013-01-15 00:49:59', '2013-01-15 00:54:43', NULL),
(202, 103, NULL, 2, 1, '0.00', '2013-01-15 01:04:07', '2013-01-15 01:04:07', NULL),
(203, 103, NULL, 1007, 1, '0.00', '2013-01-15 01:04:07', '2013-01-15 01:04:07', NULL),
(204, 103, NULL, 1001, 1, '0.00', '2013-01-15 01:04:07', '2013-01-15 01:04:07', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `lookup_charity_codes`
--

CREATE TABLE IF NOT EXISTS `lookup_charity_codes` (
  `id` int(11) NOT NULL auto_increment,
  `ntee_code` varchar(255) collate utf8_unicode_ci default NULL,
  `title` varchar(255) collate utf8_unicode_ci default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=27 ;

--
-- Dumping data for table `lookup_charity_codes`
--

INSERT INTO `lookup_charity_codes` (`id`, `ntee_code`, `title`) VALUES
(1, 'A', 'Arts, Culture & Humanities'),
(2, 'B', 'Education'),
(3, 'C', 'Environment'),
(4, 'D', 'Animal-Related'),
(5, 'E', 'Health Care'),
(6, 'F', 'Mental Health & Crisis Intervention'),
(7, 'G', 'Voluntary Health Associations & Medical Disciplines'),
(8, 'H', 'Medical Research'),
(9, 'I', 'Crime & Legal-Related'),
(10, 'J', 'Employment'),
(11, 'K', 'Food, Agriculture, Nutrition'),
(12, 'L', 'Housing & Shelter'),
(13, 'M', 'Public Safety, Disaster Preparedness & Relief'),
(14, 'N', 'Recreation & Sports'),
(15, 'O', 'Youth Development'),
(16, 'P', 'Human Services'),
(17, 'Q', 'International, Foreign Affairs'),
(18, 'R', 'Civil Rights, Social Action & Advocacy'),
(19, 'S', 'Community Improvement & Capacity Building'),
(20, 'T', 'Philanthropy, Voluntarism & Grantmaking Foundations'),
(21, 'U', 'Science & Technology'),
(22, 'V', 'Social Science'),
(23, 'W', 'Public & Societal Benefit'),
(24, 'z', 'Religion-Related'),
(25, 'Y', 'Mutual & Membership Benefit'),
(26, 'Z', 'Unknown');

-- --------------------------------------------------------

--
-- Table structure for table `lookup_event_sequences`
--

CREATE TABLE IF NOT EXISTS `lookup_event_sequences` (
  `code` varchar(255) collate utf8_unicode_ci default NULL,
  `sequence` tinyint(4) NOT NULL default '0',
  `friendly_text` text collate utf8_unicode_ci,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY  (`sequence`),
  KEY `index_lookup_event_states_on_code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `lookup_event_sequences`
--

INSERT INTO `lookup_event_sequences` (`code`, `sequence`, `friendly_text`, `created_at`, `updated_at`) VALUES
('setup_event', 1, 'Setup Event', '2012-09-28 04:43:58', '2012-09-28 04:43:58'),
('send_invitations', 2, 'Send Invitations', '2012-09-28 04:43:58', '2012-09-28 04:43:58'),
('release_gift_fund', 3, 'Release Gift Fund', '2012-09-28 04:43:58', '2012-09-28 04:43:58'),
('day_of_event', 4, 'Day of Event', '2012-09-28 04:43:58', '2012-09-28 04:43:58'),
('release_donation_fund', 5, 'Release Donation Fund', '2012-09-28 04:43:58', '2012-09-28 04:43:58'),
('event_complete', 6, 'Event Complete', '2012-09-28 04:43:58', '2012-12-07 06:55:12');

-- --------------------------------------------------------

--
-- Table structure for table `lookup_guests_statuses`
--

CREATE TABLE IF NOT EXISTS `lookup_guests_statuses` (
  `id` int(11) NOT NULL auto_increment,
  `status_code` varchar(255) collate utf8_unicode_ci default 'inviteNotSent',
  `friendly_text` varchar(255) collate utf8_unicode_ci default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_lookup_guests_statuses_on_status_code` (`status_code`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=7 ;

--
-- Dumping data for table `lookup_guests_statuses`
--

INSERT INTO `lookup_guests_statuses` (`id`, `status_code`, `friendly_text`) VALUES
(1, 'inviteNotSent', 'Invitation not yet sent'),
(2, 'inviteSentNoActivity', 'Invitation has been sent'),
(3, 'hasVisitedSite', 'Guest has visited your Event page'),
(4, 'hasRegisteredAccount', 'Guest created an account'),
(5, 'hasRejectedDonation', 'Guest chose not to participate'),
(6, 'hasMadeDonation', 'Guest has contributed!');

-- --------------------------------------------------------

--
-- Table structure for table `lookup_order_status`
--

CREATE TABLE IF NOT EXISTS `lookup_order_status` (
  `order_status_code` varchar(255) collate utf8_unicode_ci NOT NULL,
  `order_status_friendly_text` varchar(255) collate utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `lookup_shipping_methods`
--

CREATE TABLE IF NOT EXISTS `lookup_shipping_methods` (
  `shipping_method_code` varchar(255) collate utf8_unicode_ci NOT NULL,
  `shipping_method_friendly_text` varchar(255) collate utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE IF NOT EXISTS `orders` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) NOT NULL,
  `event_id` int(11) NOT NULL,
  `billing_address_id` int(11) default NULL,
  `shipping_address_id` int(11) default NULL,
  `shipping_method_code` int(11) NOT NULL default '0',
  `order_status_code` varchar(255) collate utf8_unicode_ci NOT NULL default 'cart',
  `tax_total_cost` decimal(8,2) NOT NULL default '0.00',
  `shipping_total_cost` decimal(8,2) NOT NULL default '0.00',
  `adjustments_total_cost` decimal(8,2) NOT NULL default '0.00',
  `total_cost` decimal(8,2) NOT NULL default '0.00',
  `customer_notes` text collate utf8_unicode_ci,
  `internal_notes` text collate utf8_unicode_ci,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `deleted_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3 ;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `event_id`, `billing_address_id`, `shipping_address_id`, `shipping_method_code`, `order_status_code`, `tax_total_cost`, `shipping_total_cost`, `adjustments_total_cost`, `total_cost`, `customer_notes`, `internal_notes`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 42, NULL, 1, 0, 'cart', '0.00', '1.50', '0.00', '31.45', NULL, NULL, '2013-01-15 00:48:23', '2013-01-15 00:48:23', NULL),
(2, 1, 45, NULL, 2, 0, 'cart', '0.00', '1.50', '0.00', '4.00', NULL, NULL, '2013-01-15 00:54:43', '2013-01-15 00:54:43', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `packages`
--

CREATE TABLE IF NOT EXISTS `packages` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) collate utf8_unicode_ci default NULL,
  `description` text collate utf8_unicode_ci,
  `cost` decimal(8,2) default NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `proxy_item_id` int(11) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3 ;

--
-- Dumping data for table `packages`
--

INSERT INTO `packages` (`id`, `name`, `description`, `cost`, `created_at`, `updated_at`, `proxy_item_id`) VALUES
(1, 'The Great Basic Event Package', 'Our basic package is free and includes the most important rewards for your Child\r\n\r\n', '0.00', '2012-07-06 18:36:40', '2012-09-06 00:52:05', 1001),
(2, 'Super Sharer Extra Fun Package', 'It''s such a nice thing to Share Your Wish; these items will not only reward your child with a little extra recognition, but will also serve as valuable teaching tools and a reminder of the good they have done.', '29.95', '2012-07-06 18:36:40', '2012-09-06 18:43:29', 1002);

-- --------------------------------------------------------

--
-- Table structure for table `pages`
--

CREATE TABLE IF NOT EXISTS `pages` (
  `id` int(11) NOT NULL auto_increment,
  `title` varchar(255) collate utf8_unicode_ci default NULL,
  `teaser` text collate utf8_unicode_ci,
  `text` text collate utf8_unicode_ci,
  `slug` varchar(255) collate utf8_unicode_ci default NULL,
  `order` mediumint(9) default '0',
  `show_in_menu` tinyint(1) default '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `index_pages_on_order` (`order`),
  KEY `index_pages_on_show_in_menu` (`show_in_menu`),
  KEY `index_pages_on_slug` (`slug`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=20 ;

--
-- Dumping data for table `pages`
--

INSERT INTO `pages` (`id`, `title`, `teaser`, `text`, `slug`, `order`, `show_in_menu`, `created_at`, `updated_at`) VALUES
(1, 'About Us', '', '<p>About<strong> Us text</strong></p>', 'about-us', 1, 1, '2012-11-13 07:35:14', '2012-11-13 07:35:14'),
(2, 'Contact Us', NULL, 'Contact Us text', 'contact-us', 2, 1, '2012-11-13 07:35:14', '2012-11-13 07:35:14'),
(3, 'Our Mission', '', '<div class="indent-me">\r\n<p>Share Your Wish helps parents teach children the virtues of genorosity and selflessnes, while facilitating a more efficient gift exchange that benefits both gift giver and gift receiver. We empower kids and equip parents to simultaneously reduce excessive and frivolous gift giving, support a healthier planet, promote social responsibility, and practice good values while rewarding kids with better personalized gifts.</p>\r\n<p>We are proud to be a mission-driven social enterprise committed to supporting the needs of parents, of children, of those who have, of those in need of help, and of the world we share.</p>\r\n</div>\r\n<h1>Our Values</h1>\r\n<div class="indent-me">\r\n<p style="font-weight: bolder;">Integrity, above all else</p>\r\n<p class="indent-me">By staying true to our mission and grounded in our core values we earn the trust of parents and children, our customers and communities</p>\r\n<p style="font-weight: bolder;">Teach social responsibility</p>\r\n<p class="indent-me">When children practice charity they learn compassion, empathy, self-esteem, pride, generosity, empowerment and in turn become better stewards of the world</p>\r\n<p style="font-weight: bolder;">Help yourself by helping others first</p>\r\n<p class="indent-me">Charitable acts prove that considering the needs of others first can lead to a better outcome for everyone, including yourself</p>\r\n<p style="font-weight: bolder;">Open communication</p>\r\n<p class="indent-me">Encourage the frequent and open exchange of ideas between parents, kids, employees and customers to breed innovation and better relationships</p>\r\n</div>\r\n<h1>Our Vision</h1>\r\n<p class="indent-me">Influence children towards a lifetime of social responsibility by teaching them to sow and reap the good fortune of a generous spirit, making the world a little better for everyone</p>', 'mission', 4, 1, '2012-11-13 07:35:14', '2012-11-13 07:35:14'),
(4, 'Our Team', NULL, 'Our Team text', 'team', 5, 1, '2012-11-13 07:35:14', '2012-11-13 07:35:14'),
(5, 'Press', NULL, 'Press text', 'press', 6, 1, '2012-11-13 07:35:14', '2012-11-13 07:35:14'),
(6, 'Terms of Service', NULL, '	<div class="indent-me">\r\n\r\n		<h2>Agreement between user and http://www.shareyourwish.com</h2>\r\n		<p>\r\n			Welcome to http://www.shareyourwish.com. The http://www.shareyourwish.com website (the "Site") is comprised of various web pages operated by Share Your Wish, LLC ("SYW"). http://www.shareyourwish.com is offered to you conditioned on your acceptance without modification of the terms, conditions, and notices contained herein (the "Terms"). Your use of http://www.shareyourwish.com constitutes your agreement to all such Terms. Please read these terms carefully, and keep a copy of them for your reference.\r\n		<p>\r\n			http://www.shareyourwish.com is an Event Site. Hosts may create an event page, free with optional paid upgrade, that their guests may visit and use to contribute funds to the event. These funds, less transaction fees and other costs, will be distributed with the intent of purchasing a gift for the host child''s event and making a charitable donation in the child''s name.\r\n\r\n			<h2>Privacy</h2>\r\n		<p>\r\n			Your use of http://www.shareyourwish.com is subject to SYW''s Privacy Policy. Please review our Privacy Policy, which also governs the Site and informs users of our data collection practices.\r\n\r\n			<h2>Electronic Communications</h2>\r\n		<p>\r\n			Visiting http://www.shareyourwish.com or sending emails to SYW constitutes electronic communications. You consent to receive electronic communications and you agree that all agreements, notices, disclosures and other communications that we provide to you electronically, via email and on the Site, satisfy any legal requirement that such communications be in writing.\r\n\r\n			<h2>Your account</h2>\r\n		<p>\r\n			If you use this site, you are responsible for maintaining the confidentiality of your account and password and for restricting access to your computer, and you agree to accept responsibility for all activities that occur under your account or password. You may not assign or otherwise transfer your account to any other person or entity. You acknowledge that SYW is not responsible for third party access to your account that results from theft or misappropriation of your account. SYW and its associates reserve the right to refuse or cancel service, terminate accounts, or remove or edit content in our sole discretion.\r\n		<p>\r\n			SYW collects personally identifiable information from children under the age of thirteen. SYW collects this information for the following reason(s):\r\n		<p>\r\n			ShareYourWish collects limited personal information about children under the age of 13 for the sole purpose of personalizing the Host''s event page correctly. Specifically: Name, Date of Birth, Gender. This information is never disclosed to any party other than the Host and invited Guests, unless the Host has specifically opted to allow disclosure of Name on the ShareYourWish "Award Wall" (or other medium in any format).\r\n		<p>\r\n			We provide information about our personal data practices for children wherever we knowingly collect personal data from children on our Web site. If you are under the age of thirteen, you must ask your parent or guardian for permission to use this website. If you are a parent and you have questions regarding our data collection practices, please contact us using the information provided at the end of this Agreement. If you are under 18, you may use http://www.shareyourwish.com only with permission of a parent or guardian.\r\n\r\n			<h2>Cancellation/Refund Policy</h2>\r\n		<p>\r\n			Hosts may request a refund for their Event upgrade and purchased items within 30 days of purchase. Guests may request a refund for their contribution in the proportion that funds have not yet been disbursed. Disbursement is made, as a percentage of the Host''s chosen Donation Level, approximately seven days prior to the Event date (the Gift Fund portion) and the day after the Event date (the Donation Fund portion). All users should use the form at https://www.shareyourwish.com/contact-us/ with their request for refund, or any other questions. Guests may also contact admin@shareyourwish.com.\r\n\r\n			<h2>Links to third party sites/Third party services</h2>\r\n		<p>\r\n			http://www.shareyourwish.com may contain links to other websites ("Linked Sites"). The Linked Sites are not under the control of SYW and SYW is not responsible for the contents of any Linked Site, including without limitation any link contained in a Linked Site, or any changes or updates to a Linked Site. SYW is providing these links to you only as a convenience, and the inclusion of any link does not imply endorsement by SYW of the site or any association with its operators.\r\n		<p>\r\n			Certain services made available via http://www.shareyourwish.com are delivered by third party sites and organizations. By using any product, service or functionality originating from the http://www.shareyourwish.com domain, you hereby acknowledge and consent that SYW may share such information and data with any third party with whom SYW has a contractual relationship to provide the requested product, service or functionality on behalf of http://www.shareyourwish.com users and customers.\r\n\r\n			<h2>No unlawful or prohibited use/Intellectual Property</h2>\r\n		<p>\r\n			You are granted a non-exclusive, non-transferable, revocable license to access and use http://www.shareyourwish.com strictly in accordance with these terms of use. As a condition of your use of the Site, you warrant to SYW that you will not use the Site for any purpose that is unlawful or prohibited by these Terms. You may not use the Site in any manner which could damage, disable, overburden, or impair the Site or interfere with any other party''s use and enjoyment of the Site. You may not obtain or attempt to obtain any materials or information through any means not intentionally made available or provided for through the Site.\r\n		<p>\r\n			All content included as part of the Service, such as text, graphics, logos, images, as well as the compilation thereof, and any software used on the Site, is the property of SYW or its suppliers and protected by copyright and other laws that protect intellectual property and proprietary rights. You agree to observe and abide by all copyright and other proprietary notices, legends or other restrictions contained in any such content and will not make any changes thereto.\r\n		<p>\r\n			You will not modify, publish, transmit, reverse engineer, participate in the transfer or sale, create derivative works, or in any way exploit any of the content, in whole or in part, found on the Site.\r\n		<p>\r\n			SYW content is not for resale. Your use of the Site does not entitle you to make any unauthorized use of any protected content, and in particular you will not delete or alter any proprietary rights or attribution notices in any content. You will use protected content solely for your personal use, and will make no other use of the content without the express written permission of SYW and the copyright owner. You agree that you do not acquire any ownership rights in any protected content. We do not grant you any licenses, express or implied, to the intellectual property of SYW or our licensors except as expressly authorized by these Terms.\r\n\r\n			<h2>Use of communication services</h2>\r\n		<p>\r\n			The Site may contain bulletin board services, chat areas, news groups, forums, communities, personal web pages, calendars, and/or other message or communication facilities designed to enable you to communicate with the public at large or with a group (collectively, "Communication Services"), you agree to use the Communication Services only to post, send and receive messages and material that are proper and related to the particular Communication Service.\r\n		<p>\r\n			By way of example, and not as a limitation, you agree that when using a Communication Service, you will not: defame, abuse, harass, stalk, threaten or otherwise violate the legal rights (such as rights of privacy and publicity) of others; publish, post, upload, distribute or disseminate any inappropriate, profane, defamatory, infringing, obscene, indecent or unlawful topic, name, material or information; upload files that contain software or other material protected by intellectual property laws (or by rights of privacy of publicity) unless you own or control the rights thereto or have received all necessary consents; upload files that contain viruses, corrupted files, or any other similar software or programs that may damage the operation of another''s computer; advertise or offer to sell or buy any goods or services for any business purpose, unless such Communication Service specifically allows such messages; conduct or forward surveys, contests, pyramid schemes or chain letters; download any file posted by another user of a Communication Service that you know, or reasonably should know, cannot be legally distributed in such manner; falsify or delete any author attributions, legal or other proper notices or proprietary designations or labels of the origin or source of software or other material contained in a file that is uploaded, restrict or inhibit any other user from using and enjoying the Communication Services; violate any code of conduct or other guidelines which may be applicable for any particular Communication Service; harvest or otherwise collect information about others, including e-mail addresses, without their consent; violate any applicable laws or regulations.\r\n		<p>\r\n			SYW has no obligation to monitor the Communication Services. However, SYW reserves the right to review materials posted to a Communication Service and to remove any materials in its sole discretion. SYW reserves the right to terminate your access to any or all of the Communication Services at any time without notice for any reason whatsoever.\r\n		<p>\r\n			SYW reserves the right at all times to disclose any information as necessary to satisfy any applicable law, regulation, legal process or governmental request, or to edit, refuse to post or to remove any information or materials, in whole or in part, in SYW''s sole discretion.\r\n		<p>\r\n			Always use caution when giving out any personally identifying information about yourself or your children in any Communication Service. SYW does not control or endorse the content, messages or information found in any Communication Service and, therefore, SYW specifically disclaims anyliability with regard to the Communication Services and any actions resulting from your participation in any Communication Service. Managers and hosts are not authorized SYW spokespersons, and their views do not necessarily reflect those of SYW.\r\n		<p>\r\n			Materials uploaded to a Communication Service may be subject to posted limitations on usage, reproduction and/or dissemination. You are responsible for adhering to such limitations if you upload the materials.\r\n\r\n			<h2>Materials provided to http://www.shareyourwish.com or posted on any SYW web page</h2>\r\n		<p>\r\n			SYW does not claim ownership of the materials you provide to http://www.shareyourwish.com (including feedback and suggestions) or post, upload, input or submit to any SYW Site or our associated services (collectively "Submissions"). However, by posting, uploading, inputting, providing or submitting your Submission you are granting SYW, our affiliated companies and necessary sublicensees permission to use your Submission in connection with the operation of their Internet businesses including, without limitation, the rights to: copy, distribute, transmit, publicly display, publicly perform, reproduce, edit, translate and reformat your Submission; and to publish your name in connection with your Submission.\r\n		<p>\r\n			No compensation will be paid with respect to the use of your Submission, as provided herein. SYW is under no obligation to post or use any Submission you may provide and may remove any Submission at any time in SYW''s sole discretion.\r\n		<p>\r\n			By posting, uploading, inputting, providing or submitting your Submission you warrant and represent that you own or otherwise control all of the rights to your Submission as described in this section including, without limitation, all the rights necessary for you to provide, post, upload, input or submit the Submissions.\r\n\r\n			<h2>Third Party Accounts</h2>\r\n		<p>\r\n			You will be able to connect your SYW account to third party accounts. By connecting your SYW account to your third party account, you acknowledge and agree that you are consenting to the continuous release of information about you to others (in accordance with your privacy settings on those third party sites). If you do not want information about you to be shared in this manner, do not use this feature.\r\n\r\n			<h2>International Users</h2>\r\n		<p>\r\n			The Service is controlled, operated and administered by SYW from our offices within the USA. If you access the Service from a location outside the USA, you are responsible for compliance with all local laws. You agree that you will not use the SYW Content accessed through http://www.shareyourwish.com in any country or in any manner prohibited by any applicable laws, restrictions or regulations.\r\n\r\n			<h2>Indemnification</h2>\r\n		<p>\r\n			You agree to indemnify, defend and hold harmless SYW, its officers, directors, employees, agents and third parties, for any losses, costs, liabilities and expenses (including reasonable attorneys'' fees) relating to or arising out of your use of or inability to use the Site or services, any user postings made by you, your violation of any terms of this Agreement or your violation of any rights of a third party, or your violation of any applicable laws, rules or regulations. SYW reserves the right, at its own cost, to assume the exclusive defense and control of any matter otherwise subject to indemnification by you, in which event you will fully cooperate with SYW in asserting any available defenses.\r\n\r\n			<h2>Liability disclaimer</h2>\r\n		<p>\r\n			THE INFORMATION, SOFTWARE, PRODUCTS, AND SERVICES INCLUDED IN OR AVAILABLE THROUGH THE SITE MAY INCLUDE INACCURACIES OR TYPOGRAPHICAL ERRORS. CHANGES ARE PERIODICALLY ADDED TO THE INFORMATION HEREIN. SHARE YOUR WISH, LLC AND/OR ITS SUPPLIERS MAY MAKE IMPROVEMENTS AND/OR CHANGES IN THE SITE AT ANY TIME.\r\n		<p>\r\n			SHARE YOUR WISH, LLC AND/OR ITS SUPPLIERS MAKE NO REPRESENTATIONS ABOUT THE SUITABILITY, RELIABILITY, AVAILABILITY, TIMELINESS, AND ACCURACY OF THE INFORMATION, SOFTWARE, PRODUCTS, SERVICES AND RELATED GRAPHICS CONTAINED ON THE SITE FOR ANY PURPOSE. TO THE MAXIMUM EXTENT PERMITTED BY APPLICABLE LAW, ALL SUCH INFORMATION, SOFTWARE, PRODUCTS, SERVICES AND RELATED GRAPHICS ARE PROVIDED "AS IS" WITHOUT WARRANTY OR CONDITION OF ANY KIND. SHARE YOUR WISH, LLC AND/OR ITS SUPPLIERS HEREBY DISCLAIM ALL WARRANTIES AND CONDITIONS WITH REGARD TO THIS INFORMATION, SOFTWARE, PRODUCTS, SERVICES AND RELATED GRAPHICS, INCLUDING ALL IMPLIED WARRANTIES OR CONDITIONS OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, TITLE AND NON-INFRINGEMENT.\r\n		<p>\r\n			TO THE MAXIMUM EXTENT PERMITTED BY APPLICABLE LAW, IN NO EVENT SHALL SHARE YOUR WISH, LLC AND/OR ITS SUPPLIERS BE LIABLE FOR ANY DIRECT, INDIRECT, PUNITIVE, INCIDENTAL, SPECIAL, CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER INCLUDING, WITHOUT LIMITATION, DAMAGES FOR LOSS OF USE, DATA OR PROFITS, ARISING OUT OF OR IN ANY WAY CONNECTED WITH THE USE OR PERFORMANCE OF THE SITE, WITH THE DELAY OR INABILITY TO USE THE SITE OR RELATED SERVICES, THE PROVISION OF OR FAILURE TO PROVIDE SERVICES, OR FOR ANY INFORMATION, SOFTWARE, PRODUCTS, SERVICES AND RELATED GRAPHICS OBTAINED THROUGH THE SITE, OR OTHERWISE ARISING OUT OF THE USE OF THE SITE, WHETHER BASED ON CONTRACT, TORT, NEGLIGENCE, STRICT LIABILITY OR OTHERWISE, EVEN IF SHARE YOUR WISH, LLC OR ANY OF ITS SUPPLIERS HAS BEEN ADVISED OF THE POSSIBILITY OF DAMAGES. BECAUSE SOME STATES/JURISDICTIONS DO NOT ALLOW THE EXCLUSION OR LIMITATION OF LIABILITY FOR CONSEQUENTIAL OR INCIDENTAL DAMAGES, THE ABOVE LIMITATION MAY NOT APPLY TO YOU. IF YOU ARE DISSATISFIED WITH ANY PORTION OF THE SITE, OR WITH ANY OF THESE TERMS OF USE, YOUR SOLE AND EXCLUSIVE REMEDY IS TO DISCONTINUE USING THE SITE.\r\n\r\n			<h2>Termination/access restriction</h2>\r\n		<p>\r\n			SYW reserves the right, in its sole discretion, to terminate your access to the Site and the related services or any portion thereof at any time, without notice. To the maximum extent permitted by law, this agreement is governed by the laws of the State of New York and you hereby consent to the exclusive jurisdiction and venue of courts in New York in all disputes arising out of or relating to the use of the Site. Use of the Site is unauthorized in any jurisdiction that does not give effect to all provisions of these Terms, including, without limitation, this section.\r\n		<p>\r\n			You agree that no joint venture, partnership, employment, or agency relationship exists between you and SYW as a result of this agreement or use of the Site. SYW''s performance of this agreement is subject to existing laws and legal process, and nothing contained in this agreement is in derogation of SYW''s right to comply with governmental, court and law enforcement requests or requirements relating to your use of the Site or information provided to or gathered by SYW with respect to such use. If any part of this agreement is determined to be invalid or unenforceable pursuant to applicable law including, but not limited to, the warranty disclaimers and liability limitations set forth above, then the invalid or unenforceable provision will be deemed superseded by a valid, enforceable provision that most closely matches the intent of the original provision and the remainder of the agreement shall continue in effect.\r\n		<p>\r\n			Unless otherwise specified herein, this agreement constitutes the entire agreement between the user and SYW with respect to the Site and it supersedes all prior or contemporaneous communications and proposals, whether electronic, oral or written, between the user and SYW with respect to the Site. A printed version of this agreement and of any notice given in electronic form shall be admissible in judicial or administrative proceedings based upon or relating to this agreement to the same extent an d subject to the same conditions as other business documents and records originally generated and maintained in printed form. It is the express wish to the parties that this agreement and all related documents be written in English.\r\n\r\n			<h2>Changes to Terms</h2>\r\n		<p>\r\n			SYW reserves the right, in its sole discretion, to change the Terms under which http://www.shareyourwish.com is offered. The most current version of the Terms will supersede all previous versions. SYW encourages you to periodically review the Terms to stay informed of our updates.\r\n\r\n			<h2>Contact Us</h2>\r\n		<p>\r\n			SYW welcomes your questions or comments regarding the Terms:\r\n		<p>\r\n			Share Your Wish, LLC\r\n			39 Evergreen Way\r\n			Sleepy Hollow, New York 10591\r\n			Email Address: info@shareyourwish.com\r\n		<p>\r\n			Effective as of September 01, 2012\r\n\r\n		<p>\r\n			This is a RocketLawyer.com document.\r\n\r\n	</div>', 'terms-of-service', 0, 0, '2012-11-13 07:35:14', '2012-11-13 07:35:14'),
(7, 'Privacy Policy', '', '<div class="indent-me">\r\n<h2>What information do we collect?</h2>\r\n<p>We collect information from you when you register on our site or publish an event.</p>\r\n<p>When ordering or registering on our site, as appropriate, you may be asked to enter your: name, e-mail address, mailing address, phone number or credit card information. You may, however, visit our site anonymously.</p>\r\n<p>Google, as a third party vendor, uses cookies to serve ads on your site.</p>\r\n<p>Google''s use of the DART cookie enables it to serve ads to your users based on their visit to your sites and other sites on the Internet.</p>\r\n<p>Users may opt out of the use of the DART cookie by visiting the Google ad and content network privacy policy.</p>\r\n<h2>What do we use your information for?</h2>\r\n<p>Any of the information we collect from you may be used in one of the following ways:</p>\r\n<p>; To personalize your experience <br /> (your information helps us to better respond to your individual needs)</p>\r\n<p>; To improve our website <br /> (we continually strive to improve our website offerings based on the information and feedback we receive from you)</p>\r\n<p>; To improve customer service <br /> (your information helps us to more effectively respond to your customer service requests and support needs)</p>\r\n<p>; To process transactions </p>\r\n<blockquote>Your information, whether public or private, will not be sold, exchanged, transferred, or given to any other company for any reason whatsoever, without your consent, other than for the express purpose of delivering the purchased product or service requested.</blockquote>\r\n<p><br /> ; To send periodic emails </p>\r\n<blockquote>The email address you provide for order processing, may be used to send you information and updates pertaining to your order, in addition to receiving occasional company news, updates, related product or service information, etc.</blockquote>\r\n<p>Note: If at any time you would like to unsubscribe from receiving future emails, we include detailed unsubscribe instructions at the bottom of each email.</p>\r\n<h2>How do we protect your information?</h2>\r\n<p>We implement a variety of security measures to maintain the safety of your personal information when you place an order or enter, submit, or access your personal information. <br /> <br /> We offer the use of a secure server. All supplied sensitive/credit information is transmitted via Secure Socket Layer (SSL) technology and then encrypted into our Payment gateway providers database only to be accessible by those authorized with special access rights to such systems, and are required to?keep the information confidential.</p>\r\n<p>After a transaction, your private information (credit cards, social security numbers, financials, etc.) will not be stored on our servers.</p>\r\n<h2>Do we use cookies?</h2>\r\n<p>Yes (Cookies are small files that a site or its service provider transfers to your computers hard drive through your Web browser (if you allow) that enables the sites or service providers systems to recognize your browser and capture and remember certain information</p>\r\n<p>We use cookies to help us remember and process the items in your shopping cart, understand and save your preferences for future visits, keep track of advertisements and compile aggregate data about site traffic and site interaction so that we can offer better site experiences and tools in the future. We may contract with third-party service providers to assist us in better understanding our site visitors. These service providers are not permitted to use the information collected on our behalf except to help us conduct and improve our business.</p>\r\n<h2>Do we disclose any information to outside parties?</h2>\r\n<p>We do not sell, trade, or otherwise transfer to outside parties your personally identifiable information. This does not include trusted third parties who assist us in operating our website, conducting our business, or servicing you, so long as those parties agree to keep this information confidential. We may also release your information when we believe release is appropriate to comply with the law, enforce our site policies, or protect ours or others rights, property, or safety. However, non-personally identifiable visitor information may be provided to other parties for marketing, advertising, or other uses.</p>\r\n<h2>Third party links</h2>\r\n<p>Occasionally, at our discretion, we may include or offer third party products or services on our website. These third party sites have separate and independent privacy policies. We therefore have no responsibility or liability for the content and activities of these linked sites. Nonetheless, we seek to protect the integrity of our site and welcome any feedback about these sites.</p>\r\n<h2>Childrens Online Privacy Protection Act Compliance</h2>\r\n<p>We are in compliance with the requirements of COPPA (Childrens Online Privacy Protection Act), we do not collect any information from anyone under 13 years of age. Our website, products and services are all directed to people who are at least 13 years old or older.</p>\r\n<h2>Online Privacy Policy Only</h2>\r\n<p>This online privacy policy applies only to information collected through our website and not to information collected offline.</p>\r\n<h2>Terms and Conditions</h2>\r\n<p>Please also visit our Terms and Conditions section establishing the use, disclaimers, and limitations of liability governing the use of our website at <a href="http://www.shareyourwish.com/terms-of-service"> http://www.shareyourwish.com/terms-of-service</a></p>\r\n<h2>Changes to our Privacy Policy</h2>\r\n<p>If we decide to change our privacy policy, we will post those changes on this page, and/or update the Privacy Policy modification date below.</p>\r\n<p>This policy was last modified on Oct 18, 2012</p>\r\n<h2>Contacting Us</h2>\r\n<p>If there are any questions regarding this privacy policy you may contact us using the information below.</p>\r\n<p>http://www.shareyouwish.com <br /> 39 Evergreen Way <br /> Sleepy Hollow, New York 10591 <br /> United States <br /> admin@shareyourwish.com</p>\r\n<p>&nbsp;</p>\r\n</div>', 'privacy-policy', 1, 0, '2012-11-13 07:35:14', '2012-11-13 07:35:14'),
(10, 'Learn - Overview', NULL, 'Learn - Overview text', 'learn', 0, 0, '2012-11-13 07:35:14', '2012-11-13 07:35:14'),
(18, 'Browse - Overview', NULL, 'Browse - Overview text', 'browse', 0, 0, '2012-11-13 07:35:14', '2012-11-13 07:35:14'),
(19, 'Browse - Award Wall', NULL, 'Browse - Award Wall text', 'browse/award-wall', 0, 0, '2012-11-13 07:35:14', '2012-11-13 07:35:14');

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE IF NOT EXISTS `payments` (
  `id` int(11) NOT NULL auto_increment,
  `order_id` varchar(255) collate utf8_unicode_ci default NULL,
  `amount` decimal(8,2) NOT NULL default '0.00',
  `payment_method` varchar(255) collate utf8_unicode_ci default 'braintree',
  `last_four_digits` varchar(255) collate utf8_unicode_ci default NULL,
  `processing_response` varchar(255) collate utf8_unicode_ci default 'awaiting processing',
  `status` varchar(255) collate utf8_unicode_ci default NULL,
  `contribution_id` int(11) default NULL,
  `deleted_at` datetime default NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=4 ;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`id`, `order_id`, `amount`, `payment_method`, `last_four_digits`, `processing_response`, `status`, `contribution_id`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, NULL, '24.00', 'braintree', '1111', '1000', 'submitted_for_settlement', 7, NULL, '2013-01-09 04:02:24', '2013-01-09 04:02:24'),
(2, '1', '31.45', 'braintree', '1111', '1000', 'submitted_for_settlement', NULL, NULL, '2013-01-15 00:48:27', '2013-01-15 00:48:27'),
(3, '2', '4.00', 'braintree', '1019', '1000', 'submitted_for_settlement', NULL, NULL, '2013-01-15 00:54:46', '2013-01-15 00:54:46');

-- --------------------------------------------------------

--
-- Table structure for table `pictures`
--

CREATE TABLE IF NOT EXISTS `pictures` (
  `id` int(11) NOT NULL auto_increment,
  `imageable_type` varchar(255) collate utf8_unicode_ci default NULL,
  `imageable_id` int(11) default NULL,
  `sort_order` int(11) default NULL,
  `layout_section` varchar(255) collate utf8_unicode_ci default NULL,
  `layout_slot` int(11) default NULL,
  `image_file_name` varchar(255) collate utf8_unicode_ci default NULL,
  `image_content_type` varchar(255) collate utf8_unicode_ci default NULL,
  `image_file_size` int(11) default NULL,
  `image_updated_at` datetime default NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `index_pictures_on_sort_order` (`sort_order`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=199 ;

--
-- Dumping data for table `pictures`
--

INSERT INTO `pictures` (`id`, `imageable_type`, `imageable_id`, `sort_order`, `layout_section`, `layout_slot`, `image_file_name`, `image_content_type`, `image_file_size`, `image_updated_at`, `created_at`, `updated_at`) VALUES
(1, 'charity', 1, 1, 'layout1', 1, '_14kb_size_jpg.jpg', 'image/jpeg', 14420, '2012-07-06 18:36:24', '2012-07-06 18:36:25', '2012-07-06 18:36:25'),
(2, 'charity', 2, 1, 'layout1', 1, '_14kb_size_jpg.jpg', 'image/jpeg', 14420, '2012-07-06 18:36:25', '2012-07-06 18:36:25', '2012-07-06 18:36:25'),
(3, 'charity', 3, 1, 'layout1', 1, '_14kb_size_jpg.jpg', 'image/jpeg', 14420, '2012-07-06 18:36:25', '2012-07-06 18:36:26', '2012-07-06 18:36:26'),
(4, 'charity', 4, 1, 'layout1', 1, '_14kb_size_jpg.jpg', 'image/jpeg', 14420, '2012-07-06 18:36:26', '2012-07-06 18:36:26', '2012-07-06 18:36:26'),
(5, 'charity', 5, 1, 'layout1', 1, '_14kb_size_jpg.jpg', 'image/jpeg', 14420, '2012-07-06 18:36:26', '2012-07-06 18:36:27', '2012-07-06 18:36:27'),
(6, 'charity', 6, 1, 'layout1', 1, '_14kb_size_jpg.jpg', 'image/jpeg', 14420, '2012-07-06 18:36:27', '2012-07-06 18:36:27', '2012-07-06 18:36:27'),
(7, 'charity', 7, 1, 'layout1', 1, '_14kb_size_jpg.jpg', 'image/jpeg', 14420, '2012-07-06 18:36:27', '2012-07-06 18:36:28', '2012-07-06 18:36:28'),
(8, 'charity', 8, 1, 'layout1', 1, '_14kb_size_jpg.jpg', 'image/jpeg', 14420, '2012-07-06 18:36:28', '2012-07-06 18:36:28', '2012-07-06 18:36:28'),
(9, 'charity', 9, 1, 'layout1', 1, '_14kb_size_jpg.jpg', 'image/jpeg', 14420, '2012-07-06 18:36:28', '2012-07-06 18:36:29', '2012-07-06 18:36:29'),
(11, 'charity', 11, 1, 'layout1', 1, '_14kb_size_jpg.jpg', 'image/jpeg', 14420, '2012-07-06 18:36:30', '2012-07-06 18:36:30', '2012-07-06 18:36:30'),
(12, 'charity', 12, 1, 'layout1', 1, '_14kb_size_jpg.jpg', 'image/jpeg', 14420, '2012-07-06 18:36:30', '2012-07-06 18:36:31', '2012-07-06 18:36:31'),
(13, 'charity', 13, 1, 'layout1', 1, '_14kb_size_jpg.jpg', 'image/jpeg', 14420, '2012-07-06 18:36:31', '2012-07-06 18:36:31', '2012-07-06 18:36:31'),
(14, 'charity', 14, 1, 'layout1', 1, '_14kb_size_jpg.jpg', 'image/jpeg', 14420, '2012-07-06 18:36:31', '2012-07-06 18:36:32', '2012-07-06 18:36:32'),
(15, 'charity', 15, 1, 'layout1', 1, '_14kb_size_jpg.jpg', 'image/jpeg', 14420, '2012-07-06 18:36:32', '2012-07-06 18:36:32', '2012-07-06 18:36:32'),
(16, 'charity', 16, 1, 'layout1', 1, '_14kb_size_jpg.jpg', 'image/jpeg', 14420, '2012-07-06 18:36:32', '2012-07-06 18:36:33', '2012-07-06 18:36:33'),
(17, 'charity', 17, 1, 'layout1', 1, '_14kb_size_jpg.jpg', 'image/jpeg', 14420, '2012-07-06 18:36:33', '2012-07-06 18:36:33', '2012-07-06 18:36:33'),
(18, 'charity', 18, 1, 'layout1', 1, '_14kb_size_jpg.jpg', 'image/jpeg', 14420, '2012-07-06 18:36:33', '2012-07-06 18:36:34', '2012-07-06 18:36:34'),
(19, 'charity', 19, 1, 'layout1', 1, '_14kb_size_jpg.jpg', 'image/jpeg', 14420, '2012-07-06 18:36:34', '2012-07-06 18:36:34', '2012-07-06 18:36:34'),
(20, 'charity', 20, 1, 'layout1', 1, '_14kb_size_jpg.jpg', 'image/jpeg', 14420, '2012-07-06 18:36:34', '2012-07-06 18:36:35', '2012-07-06 18:36:35'),
(23, 'package', 3, 1, 'layout1', 1, '_14kb_size_jpg.jpg', 'image/jpeg', 14420, '2012-07-06 18:36:36', '2012-07-06 18:36:36', '2012-07-06 18:36:36'),
(24, 'package', 4, 1, 'layout1', 1, '_14kb_size_jpg.jpg', 'image/jpeg', 14420, '2012-07-06 18:36:36', '2012-07-06 18:36:37', '2012-07-06 18:36:37'),
(25, 'package', 5, 1, 'layout1', 1, '_14kb_size_jpg.jpg', 'image/jpeg', 14420, '2012-07-06 18:36:37', '2012-07-06 18:36:37', '2012-07-06 18:36:37'),
(34, 'Item', 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-07-30 23:55:01', '2012-07-30 23:55:01'),
(37, 'Item', 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-07-30 23:58:41', '2012-07-30 23:58:41'),
(40, NULL, 10, NULL, NULL, NULL, 'freinds_of_karen.jpeg', 'image/jpeg', 15538, '2012-07-31 00:38:22', '2012-07-31 00:38:23', '2012-07-31 00:38:23'),
(41, NULL, 10, NULL, NULL, NULL, 'freinds_of_karen.jpeg', 'image/jpeg', 15538, '2012-07-31 00:38:48', '2012-07-31 00:38:48', '2012-07-31 00:38:48'),
(44, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-08-27 23:21:37', '2012-08-27 23:21:37'),
(45, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-08-27 23:22:01', '2012-08-27 23:22:01'),
(47, 'event', 7, NULL, NULL, NULL, 'Darnell_Jones.jpg', 'image/jpeg', 45914, '2012-09-02 16:50:54', '2012-09-02 16:50:55', '2012-09-02 16:50:55'),
(49, 'event', 7, NULL, NULL, NULL, '12878781-original.jpg', 'image/jpeg', 188444, '2012-09-03 17:23:52', '2012-09-03 17:23:54', '2012-09-03 17:23:54'),
(50, 'event', 7, NULL, NULL, NULL, 'IMG_1065.JPG', 'image/jpeg', 453267, '2012-09-03 17:29:05', '2012-09-03 17:29:07', '2012-09-03 17:29:07'),
(51, 'event', 7, NULL, NULL, NULL, 'forfacebook-av.png', 'image/png', 46910, '2012-09-03 17:29:08', '2012-09-03 17:29:09', '2012-09-03 17:29:09'),
(52, 'Charity', 27, NULL, NULL, NULL, 'Susan_G._Korman_for_the_Cure.jpg', 'image/jpeg', 8219, '2012-09-05 01:56:34', '2012-09-05 01:56:35', '2012-09-05 01:56:35'),
(56, NULL, NULL, NULL, NULL, NULL, 'share-your-wish-frame_mag.jpg', 'image/jpeg', 82837, '2012-09-05 04:06:58', '2012-09-05 04:06:59', '2012-09-05 04:06:59'),
(57, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-09-05 04:11:20', '2012-09-05 04:11:20'),
(74, 'Item', 1001, NULL, NULL, NULL, 'share-your-wish-frame_mag.jpg', 'image/jpeg', 82837, '2012-09-06 00:50:14', '2012-09-06 00:50:16', '2012-09-06 00:50:16'),
(77, 'Package', 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-09-06 00:52:04', '2012-09-06 00:52:05'),
(78, 'Item', 1006, NULL, NULL, NULL, 'ShareYourWishCrayon.jpg', 'image/jpeg', 75211, '2012-09-06 01:20:25', '2012-09-06 01:20:26', '2012-09-06 01:20:27'),
(79, 'Item', 1005, NULL, NULL, NULL, 'SYW_Certificate_Frame2.jpg', 'image/jpeg', 83201, '2012-09-06 14:11:51', '2012-09-06 14:11:52', '2012-09-06 14:11:53'),
(80, 'Item', 1004, NULL, NULL, NULL, 'share-your-wish-frame.jpg', 'image/jpeg', 70273, '2012-09-06 14:12:45', '2012-09-06 14:12:47', '2012-09-06 14:12:47'),
(81, 'Item', 1003, NULL, NULL, NULL, 'share-your-wish-frame_mag.jpg', 'image/jpeg', 82837, '2012-09-06 14:12:59', '2012-09-06 14:13:01', '2012-09-06 14:13:01'),
(82, 'Item', 4, NULL, NULL, NULL, 'shareyourwish_medal.jpg', 'image/jpeg', 42723, '2012-09-06 14:14:10', '2012-09-06 14:14:11', '2012-09-06 14:14:11'),
(83, 'Item', 3, NULL, NULL, NULL, 'Share-Your-Wish-Teddy-Bear.jpg', 'image/jpeg', 167866, '2012-09-06 14:14:39', '2012-09-06 14:14:42', '2012-09-06 14:14:42'),
(87, 'Item', 1002, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-09-06 18:30:29', '2012-09-06 18:30:30'),
(88, 'Package', 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-09-06 18:31:05', '2012-09-06 18:31:06'),
(89, 'charity', 98, 1, 'layout1', 1, 'IHaveADreamFoundation.gif', 'image/gif', 4437, '2012-09-07 16:21:44', '2012-09-07 16:21:45', '2012-09-07 16:21:45'),
(90, 'charity', 122, 1, 'layout1', 1, 'ClassroomInc..jpg', 'image/jpeg', 4539, '2012-09-07 16:21:46', '2012-09-07 16:21:46', '2012-09-07 16:21:46'),
(91, 'charity', 126, 1, 'layout1', 1, 'DoctorsWithoutBorders.jpg', 'image/jpeg', 10330, '2012-09-07 16:21:47', '2012-09-07 16:21:47', '2012-09-07 16:21:47'),
(92, 'charity', 148, 1, 'layout1', 1, 'LiteracyInc..png', 'image/png', 1618, '2012-09-07 16:21:47', '2012-09-07 16:21:48', '2012-09-07 16:21:48'),
(93, 'charity', 99, 1, 'layout1', 1, 'AdvocatesForChildrenofNewYork.jpeg', 'image/jpeg', 7350, '2012-09-07 16:21:48', '2012-09-07 16:21:49', '2012-09-07 16:21:49'),
(94, 'charity', 101, 1, 'layout1', 1, 'AlexsLemonadeStand.jpg', 'image/jpeg', 13658, '2012-09-07 16:21:50', '2012-09-07 16:21:50', '2012-09-07 16:21:50'),
(95, 'charity', 100, 1, 'layout1', 1, 'ALSACSt._JudesChildrensResearchHospital.jpg', 'image/jpeg', 6343, '2012-09-07 16:21:50', '2012-09-07 16:21:51', '2012-09-07 16:21:51'),
(96, 'charity', 102, 1, 'layout1', 1, 'AmericaSCORES.jpg', 'image/jpeg', 10802, '2012-09-07 16:21:51', '2012-09-07 16:21:52', '2012-09-07 16:21:52'),
(97, 'charity', 103, 1, 'layout1', 1, 'AmericanCancerSociety.jpg', 'image/jpeg', 8383, '2012-09-07 16:21:52', '2012-09-07 16:21:53', '2012-09-07 16:21:53'),
(98, 'charity', 104, 1, 'layout1', 1, 'AmericanFoundationForDisabledChildren.gif', 'image/gif', 9834, '2012-09-07 16:21:53', '2012-09-07 16:21:54', '2012-09-07 16:21:54'),
(99, 'charity', 105, 1, 'layout1', 1, 'AmericanRedCross.jpg', 'image/jpeg', 36130, '2012-09-07 16:21:55', '2012-09-07 16:21:56', '2012-09-07 16:21:56'),
(100, 'charity', 106, 1, 'layout1', 1, 'AssociationToBenefitChildren.jpg', 'image/jpeg', 7130, '2012-09-07 16:21:56', '2012-09-07 16:21:57', '2012-09-07 16:21:57'),
(101, 'charity', 107, 1, 'layout1', 1, 'BabyBuggy.jpg', 'image/jpeg', 6037, '2012-09-07 16:21:57', '2012-09-07 16:21:57', '2012-09-07 16:21:57'),
(102, 'charity', 108, 1, 'layout1', 1, 'BigBrothersBigSistersOfAmerica.jpg', 'image/jpeg', 3842, '2012-09-07 16:21:58', '2012-09-07 16:21:58', '2012-09-07 16:21:58'),
(103, 'charity', 109, 1, 'layout1', 1, 'BigBrothersBigSistersofNYC.jpg', 'image/jpeg', 7711, '2012-09-07 16:21:59', '2012-09-07 16:21:59', '2012-09-07 16:21:59'),
(104, 'charity', 110, 1, 'layout1', 1, 'CARE.jpg', 'image/jpeg', 9616, '2012-09-07 16:21:59', '2012-09-07 16:22:00', '2012-09-07 16:22:00'),
(105, 'charity', 111, 1, 'layout1', 1, 'CampGoodDaysAndSpecialTimes.jpg', 'image/jpeg', 7241, '2012-09-07 16:22:00', '2012-09-07 16:22:01', '2012-09-07 16:22:01'),
(106, 'charity', 112, 1, 'layout1', 1, 'CenterForArtsEducation.jpg', 'image/jpeg', 4973, '2012-09-07 16:22:01', '2012-09-07 16:22:02', '2012-09-07 16:22:02'),
(107, 'charity', 113, 1, 'layout1', 1, 'ChessInTheSchools.jpg', 'image/jpeg', 3842, '2012-09-07 16:22:02', '2012-09-07 16:22:03', '2012-09-07 16:22:03'),
(108, 'charity', 114, 1, 'layout1', 1, 'ChildhoodLeukemiaFoundation.jpeg', 'image/jpeg', 7994, '2012-09-07 16:22:03', '2012-09-07 16:22:04', '2012-09-07 16:22:04'),
(109, 'charity', 115, 1, 'layout1', 1, 'ChildrenForChildren(Generation_On).jpeg', 'image/jpeg', 12019, '2012-09-07 16:22:04', '2012-09-07 16:22:05', '2012-09-07 16:22:05'),
(110, 'charity', 116, 1, 'layout1', 1, 'ChildrensBrainTumorFoundation.jpg', 'image/jpeg', 10394, '2012-09-07 16:22:05', '2012-09-07 16:22:06', '2012-09-07 16:22:06'),
(111, 'charity', 117, 1, 'layout1', 1, 'ChildrensCancerAndBloodFoundation.jpg', 'image/jpeg', 7540, '2012-09-07 16:22:06', '2012-09-07 16:22:07', '2012-09-07 16:22:07'),
(112, 'charity', 118, 1, 'layout1', 1, 'ChildrensMuseumOfManhattan.jpg', 'image/jpeg', 10772, '2012-09-07 16:22:07', '2012-09-07 16:22:08', '2012-09-07 16:22:08'),
(113, 'charity', 119, 1, 'layout1', 1, 'ChildrensRights.jpg', 'image/jpeg', 6684, '2012-09-07 16:22:08', '2012-09-07 16:22:09', '2012-09-07 16:22:09'),
(114, 'charity', 120, 1, 'layout1', 1, 'ChildrensScholarshipFund.png', 'image/png', 26210, '2012-09-07 16:22:09', '2012-09-07 16:22:10', '2012-09-07 16:22:10'),
(115, 'charity', 121, 1, 'layout1', 1, 'ChristopherAndDanaReeveFoundation.jpg', 'image/jpeg', 7519, '2012-09-07 16:22:10', '2012-09-07 16:22:11', '2012-09-07 16:22:11'),
(116, 'charity', 123, 1, 'layout1', 1, 'ComputersForYouth.png', 'image/png', 3391, '2012-09-07 16:22:11', '2012-09-07 16:22:12', '2012-09-07 16:22:12'),
(117, 'charity', 124, 1, 'layout1', 1, 'DisabledAmericanVeteransCharitable_Service_Trust.jpg', 'image/jpeg', 15180, '2012-09-07 16:22:12', '2012-09-07 16:22:13', '2012-09-07 16:22:13'),
(118, 'charity', 125, 1, 'layout1', 1, 'DoSomething.jpg', 'image/jpeg', 7989, '2012-09-07 16:22:13', '2012-09-07 16:22:14', '2012-09-07 16:22:14'),
(119, 'charity', 127, 1, 'layout1', 1, 'DonorsChoose.jpg', 'image/jpeg', 7113, '2012-09-07 16:22:14', '2012-09-07 16:22:15', '2012-09-07 16:22:15'),
(120, 'charity', 128, 1, 'layout1', 1, 'EastHarlemTutorialProgram.jpg', 'image/jpeg', 4377, '2012-09-07 16:22:15', '2012-09-07 16:22:16', '2012-09-07 16:22:16'),
(121, 'charity', 129, 1, 'layout1', 1, 'FamilyToFamily.jpg', 'image/jpeg', 7884, '2012-09-07 16:22:16', '2012-09-07 16:22:17', '2012-09-07 16:22:17'),
(122, 'charity', 130, 1, 'layout1', 1, 'FeedTheChildren.jpg', 'image/jpeg', 8524, '2012-09-07 16:22:17', '2012-09-07 16:22:18', '2012-09-07 16:22:18'),
(123, 'charity', 131, 1, 'layout1', 1, 'FoodForThePoor.jpg', 'image/jpeg', 7278, '2012-09-07 16:22:18', '2012-09-07 16:22:19', '2012-09-07 16:22:19'),
(124, 'charity', 132, 1, 'layout1', 1, 'FreshYouthInitiatives.jpg', 'image/jpeg', 7781, '2012-09-07 16:22:19', '2012-09-07 16:22:20', '2012-09-07 16:22:20'),
(125, 'charity', 133, 1, 'layout1', 1, 'FriendsOfKaren.jpg', 'image/jpeg', 9075, '2012-09-07 16:22:20', '2012-09-07 16:22:21', '2012-09-07 16:22:21'),
(126, 'charity', 134, 1, 'layout1', 1, 'FundForPublicSchools.jpg', 'image/jpeg', 14822, '2012-09-07 16:22:21', '2012-09-07 16:22:22', '2012-09-07 16:22:22'),
(127, 'charity', 135, 1, 'layout1', 1, 'GirlsInc..jpg', 'image/jpeg', 7105, '2012-09-07 16:22:22', '2012-09-07 16:22:23', '2012-09-07 16:22:23'),
(128, 'charity', 136, 1, 'layout1', 1, 'HabitatForHumanity.jpg', 'image/jpeg', 9730, '2012-09-07 16:22:23', '2012-09-07 16:22:24', '2012-09-07 16:22:24'),
(129, 'charity', 137, 1, 'layout1', 1, 'HabitatForHumanity.jpg', 'image/jpeg', 9730, '2012-09-07 16:22:24', '2012-09-07 16:22:24', '2012-09-07 16:22:24'),
(130, 'charity', 138, 1, 'layout1', 1, 'HarlemChildrensZone.jpg', 'image/jpeg', 5768, '2012-09-07 16:22:25', '2012-09-07 16:22:25', '2012-09-07 16:22:25'),
(131, 'charity', 139, 1, 'layout1', 1, 'iMentor.jpg', 'image/jpeg', 5899, '2012-09-07 16:22:25', '2012-09-07 16:22:26', '2012-09-07 16:22:26'),
(132, 'charity', 140, 1, 'layout1', 1, 'InnerCityScholarshipFund.jpg', 'image/jpeg', 11028, '2012-09-07 16:22:26', '2012-09-07 16:22:27', '2012-09-07 16:22:27'),
(133, 'charity', 141, 1, 'layout1', 1, 'InvisibleChildren.jpg', 'image/jpeg', 5320, '2012-09-07 16:22:27', '2012-09-07 16:22:28', '2012-09-07 16:22:28'),
(134, 'charity', 142, 1, 'layout1', 1, 'JoeTorreSafeAtHomeFoundation.png', 'image/png', 6298, '2012-09-07 16:22:28', '2012-09-07 16:22:29', '2012-09-07 16:22:29'),
(135, 'charity', 143, 1, 'layout1', 1, 'JuvenileDiabetesResearchFoundation_International.jpg', 'image/jpeg', 8318, '2012-09-07 16:22:29', '2012-09-07 16:22:30', '2012-09-07 16:22:30'),
(136, 'charity', 144, 1, 'layout1', 1, 'K.I.D.S..png', 'image/png', 21635, '2012-09-07 16:22:30', '2012-09-07 16:22:30', '2012-09-07 16:22:30'),
(137, 'charity', 145, 1, 'layout1', 1, 'KeepAChildAlive.jpg', 'image/jpeg', 9202, '2012-09-07 16:22:31', '2012-09-07 16:22:31', '2012-09-07 16:22:31'),
(138, 'charity', 146, 1, 'layout1', 1, 'LanceArmstrongFoundation.jpg', 'image/jpeg', 2986, '2012-09-07 16:22:32', '2012-09-07 16:22:32', '2012-09-07 16:22:32'),
(139, 'charity', 147, 1, 'layout1', 1, 'LearningLeaders.jpg', 'image/jpeg', 6897, '2012-09-07 16:22:32', '2012-09-07 16:22:33', '2012-09-07 16:22:33'),
(140, 'charity', 149, 1, 'layout1', 1, 'LittleKidsRock.jpg', 'image/jpeg', 9699, '2012-09-07 16:22:33', '2012-09-07 16:22:34', '2012-09-07 16:22:34'),
(141, 'charity', 150, 1, 'layout1', 1, 'MakeAWishFoundationOfAmerica.jpg', 'image/jpeg', 5677, '2012-09-07 16:22:34', '2012-09-07 16:22:35', '2012-09-07 16:22:35'),
(142, 'charity', 151, 1, 'layout1', 1, 'MarchOfDimes.jpg', 'image/jpeg', 6325, '2012-09-07 16:22:35', '2012-09-07 16:22:36', '2012-09-07 16:22:36'),
(143, 'charity', 152, 1, 'layout1', 1, 'MichaelJFoxFoundationForParkinson''s_Research.jpg', 'image/jpeg', 7609, '2012-09-07 16:22:36', '2012-09-07 16:22:37', '2012-09-07 16:22:37'),
(144, 'charity', 153, 1, 'layout1', 1, 'NYCOutwardBoundCenter.jpg', 'image/jpeg', 6372, '2012-09-07 16:22:37', '2012-09-07 16:22:38', '2012-09-07 16:22:38'),
(145, 'charity', 154, 1, 'layout1', 1, 'NationalChildrensLeukemiaFoundation.gif', 'image/gif', 11106, '2012-09-07 16:22:38', '2012-09-07 16:22:39', '2012-09-07 16:22:39'),
(146, 'charity', 155, 1, 'layout1', 1, 'NewYorkersForChildren.gif', 'image/gif', 3440, '2012-09-07 16:22:39', '2012-09-07 16:22:40', '2012-09-07 16:22:40'),
(147, 'charity', 156, 1, 'layout1', 1, 'ParalyzedVeteransOfAmerica.jpg', 'image/jpeg', 7614, '2012-09-07 16:22:40', '2012-09-07 16:22:40', '2012-09-07 16:22:40'),
(148, 'charity', 157, 1, 'layout1', 1, 'PinwheelProject.gif', 'image/gif', 51500, '2012-09-07 16:22:41', '2012-09-07 16:22:42', '2012-09-07 16:22:42'),
(149, 'charity', 158, 1, 'layout1', 1, 'RonaldMcDonaldHouseOfNewYork.jpg', 'image/jpeg', 8082, '2012-09-07 16:22:42', '2012-09-07 16:22:43', '2012-09-07 16:22:43'),
(150, 'charity', 159, 1, 'layout1', 1, 'RoomToGrow.jpg', 'image/jpeg', 8345, '2012-09-07 16:22:43', '2012-09-07 16:22:44', '2012-09-07 16:22:44'),
(151, 'charity', 160, 1, 'layout1', 1, 'SaveTheChildren.jpg', 'image/jpeg', 7691, '2012-09-07 16:22:44', '2012-09-07 16:22:45', '2012-09-07 16:22:45'),
(152, 'charity', 161, 1, 'layout1', 1, 'SpecialOlympics.jpg', 'image/jpeg', 6422, '2012-09-07 16:22:45', '2012-09-07 16:22:46', '2012-09-07 16:22:46'),
(153, 'charity', 162, 1, 'layout1', 1, 'StarlightChildrensFoundation.jpg', 'image/jpeg', 8041, '2012-09-07 16:22:46', '2012-09-07 16:22:46', '2012-09-07 16:22:46'),
(154, 'charity', 163, 1, 'layout1', 1, 'SusanGKormanForTheCure.jpg', 'image/jpeg', 8219, '2012-09-07 16:22:47', '2012-09-07 16:22:47', '2012-09-07 16:22:47'),
(155, 'charity', 164, 1, 'layout1', 1, 'TeachingMatters.jpg', 'image/jpeg', 4127, '2012-09-07 16:22:48', '2012-09-07 16:22:48', '2012-09-07 16:22:48'),
(156, 'charity', 165, 1, 'layout1', 1, 'TheChildrensAidSociety.jpg', 'image/jpeg', 13857, '2012-09-07 16:22:48', '2012-09-07 16:22:49', '2012-09-07 16:22:49'),
(157, 'charity', 166, 1, 'layout1', 1, 'TheChildrensHealthFund.png', 'image/png', 24678, '2012-09-07 16:22:49', '2012-09-07 16:22:50', '2012-09-07 16:22:50'),
(158, 'charity', 167, 1, 'layout1', 1, 'TheFreshAirFund.jpg', 'image/jpeg', 1742, '2012-09-07 16:22:50', '2012-09-07 16:22:51', '2012-09-07 16:22:51'),
(159, 'charity', 168, 1, 'layout1', 1, 'TheParent-ChildHomeProgram.jpg', 'image/jpeg', 4496, '2012-09-07 16:22:51', '2012-09-07 16:22:52', '2012-09-07 16:22:52'),
(160, 'charity', 169, 1, 'layout1', 1, 'ThePerlmanMusicProgram.jpg', 'image/jpeg', 12628, '2012-09-07 16:22:52', '2012-09-07 16:22:53', '2012-09-07 16:22:53'),
(161, 'charity', 170, 1, 'layout1', 1, 'UnitedStatesFundForUNICEF.jpg', 'image/jpeg', 8343, '2012-09-07 16:22:53', '2012-09-07 16:22:54', '2012-09-07 16:22:54'),
(162, 'charity', 171, 1, 'layout1', 1, 'VoicesAgainstBrainCancer.jpg', 'image/jpeg', 6323, '2012-09-07 16:22:54', '2012-09-07 16:22:55', '2012-09-07 16:22:55'),
(163, 'charity', 172, 1, 'layout1', 1, 'World_Childhood_Foundation.jpg', 'image/jpeg', 4956, '2012-09-07 16:22:55', '2012-09-07 16:22:56', '2012-09-07 16:22:56'),
(164, 'charity', 173, 1, 'layout1', 1, 'WorldVision.jpg', 'image/jpeg', 3774, '2012-09-07 16:22:56', '2012-09-07 16:22:57', '2012-09-07 16:22:57'),
(165, 'charity', 174, 1, 'layout1', 1, 'WoundedWarriorProject.jpg', 'image/jpeg', 8210, '2012-09-07 16:22:57', '2012-09-07 16:22:58', '2012-09-07 16:22:58'),
(166, 'charity', 175, 1, 'layout1', 1, 'YoungAudiences.jpg', 'image/jpeg', 5168, '2012-09-07 16:22:58', '2012-09-07 16:22:59', '2012-09-07 16:22:59'),
(167, 'event', 9, NULL, NULL, NULL, 'AdinNolanPutter.JPG', 'image/jpeg', 178899, '2012-09-07 16:46:14', '2012-09-07 16:46:17', '2012-09-07 16:46:17'),
(168, 'event', 9, NULL, NULL, NULL, 'periodic_memes.jpg', 'image/jpeg', 238816, '2012-09-07 16:46:17', '2012-09-07 16:46:19', '2012-09-07 16:46:19'),
(169, 'event', 9, NULL, NULL, NULL, 'temp_color.png', 'image/png', 602882, '2012-09-07 16:48:52', '2012-09-07 16:48:54', '2012-09-07 16:48:54'),
(170, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2012-09-11 01:43:58', '2012-09-11 01:43:58'),
(171, 'event', 18, NULL, NULL, NULL, 'IMG-20120812-00051.jpeg', 'image/jpeg', 23534, '2012-09-12 18:37:27', '2012-09-12 18:37:28', '2012-09-12 18:37:28'),
(172, 'Item', 1007, NULL, NULL, NULL, 'reward_certificate_no_frame.jpg', 'image/jpeg', 68815, '2012-09-13 15:37:43', '2012-09-13 15:37:45', '2012-09-13 15:37:45'),
(173, 'event', 17, NULL, NULL, NULL, 'IMG00097-20120731-0854.jpg', 'image/jpeg', 555096, '2012-09-13 16:50:18', '2012-09-13 16:50:26', '2012-09-13 16:50:26'),
(174, 'event', 17, NULL, NULL, NULL, 'photo.JPG', 'image/jpeg', 109620, '2012-09-13 16:51:16', '2012-09-13 16:51:17', '2012-09-13 16:51:17'),
(175, 'Charity', 176, NULL, NULL, NULL, 'ToysForTots.jpg', 'image/jpeg', 6169, '2012-09-13 19:35:52', '2012-09-13 19:35:53', '2012-09-13 19:35:53'),
(176, 'event', 21, NULL, NULL, NULL, 'IMG00049-20120621-1033.jpg', 'image/jpeg', 506206, '2012-09-19 15:56:39', '2012-09-19 15:56:48', '2012-09-19 15:56:48'),
(177, 'event', 21, NULL, NULL, NULL, 'IMG00236-20120309-0838.jpg', 'image/jpeg', 391283, '2012-09-19 15:56:49', '2012-09-19 15:56:53', '2012-09-19 15:56:53'),
(178, 'event', 21, NULL, NULL, NULL, 'IMG00153-20111230-1153.jpg', 'image/jpeg', 470547, '2012-09-19 15:56:54', '2012-09-19 15:56:58', '2012-09-19 15:56:58'),
(180, 'event', 23, NULL, NULL, NULL, '1282563991816.png', 'image/png', 225207, '2012-09-26 02:15:09', '2012-09-26 02:15:11', '2012-09-26 02:15:11'),
(181, 'event', 23, NULL, NULL, NULL, 'CIMG2000.JPG', 'image/jpeg', 955828, '2012-09-26 02:21:25', '2012-09-26 02:21:34', '2012-09-26 02:21:34'),
(182, 'event', 27, NULL, NULL, NULL, 'CIMG2000.JPG', 'image/jpeg', 955828, '2012-09-27 01:30:51', '2012-09-27 01:31:01', '2012-09-27 01:31:01'),
(183, 'event', 32, NULL, NULL, NULL, 'photo.JPG', 'image/jpeg', 109620, '2012-09-28 15:14:50', '2012-09-28 15:14:51', '2012-09-28 15:14:51'),
(184, 'event', 24, NULL, NULL, NULL, '1012catmew.jpg', 'image/jpeg', 170694, '2012-09-28 17:25:47', '2012-09-28 17:25:51', '2012-09-28 17:25:51'),
(185, 'Charity', 177, NULL, NULL, NULL, 'NationalMPSSociety.png', 'image/png', 52855, '2012-09-28 18:19:39', '2012-09-28 18:19:40', '2012-09-28 18:19:40'),
(186, 'event', 24, NULL, NULL, NULL, '1282558740486.png', 'image/png', 53793, '2012-09-28 18:43:03', '2012-09-28 18:43:05', '2012-09-28 18:43:05'),
(187, 'event', 36, NULL, NULL, NULL, 'photo.JPG', 'image/jpeg', 109620, '2012-09-28 19:57:41', '2012-09-28 19:57:43', '2012-09-28 19:57:43'),
(188, 'event', 37, NULL, NULL, NULL, 'CIMG1890.JPG', 'image/jpeg', 311476, '2012-09-28 21:23:31', '2012-09-28 21:23:36', '2012-09-28 21:23:36'),
(189, 'event', 37, NULL, NULL, NULL, 'CIMG1878.JPG', 'image/jpeg', 906752, '2012-09-28 21:23:43', '2012-09-28 21:23:52', '2012-09-28 21:23:52'),
(190, 'event', 39, NULL, NULL, NULL, 'photo.JPG', 'image/jpeg', 109620, '2012-10-01 14:17:10', '2012-10-01 14:17:11', '2012-10-01 14:17:11'),
(191, 'event', 38, NULL, NULL, NULL, 'Darnell_Jones.jpg', 'image/jpeg', 45914, '2012-10-02 18:02:04', '2012-10-02 18:02:05', '2012-10-02 18:02:05'),
(192, 'event', 3, NULL, NULL, NULL, 'AdinNolanPutter.JPG', 'image/jpeg', 178899, '2012-11-01 02:48:22', '2012-11-01 02:48:26', '2012-11-01 02:48:26'),
(194, 'event', 38, NULL, NULL, NULL, 'Horses.gif', 'image/gif', 36614, '2012-11-27 18:38:57', '2012-11-27 18:38:59', '2012-11-27 18:38:59'),
(196, 'event', 38, NULL, NULL, NULL, '7160542937_e4ca180414_b.jpeg', 'image/jpeg', 537419, '2012-11-27 22:55:58', '2012-11-27 22:56:01', '2012-11-27 22:56:01'),
(197, 'event', 34, NULL, NULL, NULL, 'Ellis3.jpg', 'image/jpeg', 638631, '2013-02-15 18:03:08', '2013-02-15 18:03:12', '2013-02-15 18:03:12'),
(198, 'event', 40, NULL, NULL, NULL, 'Ellis3.jpg', 'image/jpeg', 638631, '2013-02-15 18:09:36', '2013-02-15 18:09:40', '2013-02-15 18:09:40');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE IF NOT EXISTS `posts` (
  `id` int(11) NOT NULL auto_increment,
  `title` varchar(255) collate utf8_unicode_ci default NULL,
  `slug` varchar(255) collate utf8_unicode_ci default NULL,
  `tags` varchar(255) collate utf8_unicode_ci default NULL,
  `content` text collate utf8_unicode_ci,
  `posts_category_id` int(11) default NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `author` varchar(255) collate utf8_unicode_ci default NULL,
  `deleted_at` datetime default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `index_posts_on_slug` (`slug`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=10 ;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`id`, `title`, `slug`, `tags`, `content`, `posts_category_id`, `created_at`, `updated_at`, `author`, `deleted_at`) VALUES
(3, 'What Do You Want To Be When You Grow Up?', 'what-do-you-want-to-be-when-you-grow-up', '', '<p>\r\nHow often have we all been asked this very question throughout our lives?  I am sure that many of us have answered this the same way - successful, rich, smart, etc.  But did you ever say you wanted to be kind?  Did you ever tell people you hoped to inspire others?  Have you ever daydreamed about being more charitable?  Truthfully, I didn’t.  I have always had a good heart and cared about others, but I would be lying if I said being charitable was on the top of my list.\r\nHowever, in my thirties I would like to change my answer.  It is imperative for me to teach my young children what is truly important.  I want to make certain that I teach my children the virtues of sharing and inspire them to do the same, especially now at their very young and impressionable ages.\r\n<p>\r\nIt''s so difficult living in the indulgent world we all live in now. Perhaps you may feel you just can''t keep up and give your youngsters enough.  Or maybe you can afford it, but are simply not willing to give into every demand for fear you will create a spoiled and unappreciative child.  Are we unknowingly teaching them to want more stuff?  Perhaps we are focusing less on the message of helping others or teaching our children to value the things they are given.\r\n<p>\r\nI would be remiss if I said that part of me wasn’t materialistic.  I am not proud of this, but it is the truth.  However, I always worked very hard for the things I wanted, and to be honest giving back to others makes me feel better than any pair of shoes, bag, or clothing I have ever purchased.  This year I have had several opportunities to help local charities and it made me feel incredibly blessed and helped me to teach a lesson to my most important audience, my very young children.\r\n<p>\r\nSo what do I want to be when I grow up?  More inspiring to my children!  And SYW is one way I hope to teach, share, and inspire them.  Are you in?\r\n', 1, '2012-04-23 00:00:00', '2012-11-13 07:53:17', 'Rebecca Schleifer', NULL),
(4, 'Reflecting on Being a Mommy as Mother''s Day Approaches', 'reflecting-on-being-a-mommy-as-mother-s-day-approaches', '', '<p>\r\nWho in your life helps to teach you new things, shares their own experiences, and inspires you?\r\n<p>\r\nAs Mother''s Day approaches, I can''t help but reflect on being a mommy!  \r\n<p>\r\nLooking back at the last 4 plus years of my life as a mom, I can''t believe how fast they have flown by.  It used to annoy me when people would see me walking down the street with my newborn and they would say, "Enjoy it because the time flies by."  I would think, "Well, I hope so because I am exhausted and can''t wait for the time to come when this kid actually sleeps more than three hours!"  BUT, now I totally get it. \r\n<p>\r\nI truly can''t believe how fast it goes.  I can cry thinking that my daughter is going to attend her last year of preschool in September.  My son is 2 1/2 yrs old and it feels like yesterday the doctor said, "It’s a boy!"  \r\n<p>\r\nDon''t get me wrong, there are definitely days I would love to press fast forward, like when my son has a tantrum that just won''t stop or figuring out how to handle a friendship situation with my 4 year old daughter, which makes me fear for when she''s a teenager.  And trying to get my kids out of the house each morning can be more exhausting than running a marathon (I assume, I have never actually ran one).\r\n<p>\r\nHowever, there is nothing sweeter than the sound of my children laughing, singing, or telling me they love me.  Those are the things I want to savor for ever. \r\n<p>\r\nSince my husband and I are in the throes of starting a website that focuses so much "teaching, sharing, and inspiring" I thought I would reflect on those who "teach, share, and inspire” me!\r\n<p>\r\nEveryday my amazing children teach me to be a bit more patient!  It''s amazing how much a four and two-year old can teach us without even knowing.  They remind me of what is truly important in life, that it''s ok to be silly and that they''ll love me even if the house isn''t clean.  They teach me to let the kid in me come out more!  They also keep me on my toes, and always let me know that whatever I do or say they''re watching and repeating, whether I like it or not!\r\n<p>\r\nI thank all the incredible moms in my life who share with me on a daily basis.  Whether it''s their stories, laughs, tears, or friendship, they are honest and not afraid to admit that as much as we love and adore our children it can be overwhelming and exhausting.  \r\n<p>\r\nI am truly fortunate to know so many inspirational moms who inspire me to be a better mom, friend, and wife.  I am in awe of those who juggle so much and even under a great deal of stress always seem to have a smile on their face.  My own mother is one of the most incredible women and mothers I know - the sacrifices she made for me in my life I will never forget, and I only hope I inspire my children half as much as she has inspired me.\r\n<p>\r\nMoms, I hope this Mother''s Day you can take time to reflect on those who "teach, share, and inspire" you on a daily basis.  I hope you get a break from the laundry, dishwashing, and vacuuming too :)\r\n<p>\r\nHappy Mother''s Day!\r\n', 1, '2012-05-11 17:41:55', '2012-11-13 07:53:17', 'Rebecca Schleifer', NULL),
(5, 'Is One Gift Enough??', 'is-one-gift-enough', '', '<p>\r\nWhenever I tell people about our website I usually get a very positive reaction, which of course makes me feel good!  BUT, then I get the same questions - "Can you only pick one gift?  Won''t the birthday boy/girl be disappointed?  Is that enough?"\r\n\r\n<p>\r\nI have been thinking about this a lot!  And I always come back to the same answer, which is YES!  One, or a few, special gifts are enough!  \r\n\r\n<p>\r\nThinking back to my childhood, I don''t remember every gift I ever received, but I do remember the special ones - like my first pair of earrings, my roller skates, the Guess jeans with the zippers on the sides that I wanted so badly, and Tavern on the Green with my mom for my 16th birthday where she gave me the beautiful necklace she was given on her 16th birthday!  All of these "presents" were special to me because they elicit wonderful memories from my childhood.\r\n\r\n<p>\r\nShareYourWish.com isn''t just about giving back. It''s about helping to create memories that our children will look back on in years to come.  Hopefully they''ll continue to teach, share, and inspire because they were taught at a young age the importance of giving back and truly learning to appreciate what''s really important!', 1, '2012-06-05 20:26:32', '2012-11-13 07:53:17', 'Rebecca Schleifer', NULL),
(6, 'The Most Important Men in Our Lives', 'the-most-important-men-in-our-lives', '', '<p>I hope this Father''s Day we can all celebrate some of the amazing men in our lives! I dedicate this blog to my husband Buck,  who is truly an exceptional husband and father.\r\n <p>\r\nEvery day when Buck walks in the door after work he is greeted by screams similar to how Tweens watching a Justin Beiber concert would react.\r\n  <p>\r\nBefore my children were born, I think my husband read every book out there geared towards fathers.  The truth is, he was a complete natural and could probably write a book of his own!  Being there for your children, showing love and respect cannot be learned in a book.     \r\n  <p>\r\nFathers are so important in our lives.  They help shape the person we''ll become and they make us feel safe and protected.  They also tend to be far less bossy than mommy!  Well, at least in my house!\r\n  <p>\r\nMy husband and I are trying to create a business and lifestyle that we hope helps to "Teach, Share, and Inspire" our own children.  I interviewed two very important munchkins about what''s special about their daddy.  Here is what Ayla and Ellis had to say about my husband and the most important man in their lives!  \r\n  <p>\r\n<span style="font-weight: bold;">What do you love about daddy?</span><br>\r\n<span style="font-style: italic;">"Going out with him without Ellis - go for pizza and ice cream."</span>\r\n  <p>\r\n<span style="font-weight: bold;">Describe daddy:</span><br>\r\n<span style="font-style: italic;">"I like him.  He''s handsome.  He''s funny!"</span>\r\n  <p>\r\n<span style="font-weight: bold;">What does daddy like to do?</span><br>\r\n<span style="font-style: italic;">"Paint with us and go to his office."</span>\r\n  <p>\r\n<span style="font-weight: bold;">How much do you love Daddy? </span><br>\r\n<span style="font-style: italic;">"So much in the whole wide world."</span>\r\n  <p>\r\nI don''t think I could have said it any better myself.  I wish all of you dads a very Happy Father''s Day!  Take time to reflect on how you "Teach, Share, and Inspire" your children.', 1, '2012-06-14 18:55:15', '2012-11-13 07:53:17', 'Rebecca Schleifer', NULL),
(7, 'The End to Bullying Starts at Home', 'the-end-to-bullying-starts-at-home', '', '<p>It seems like every time I turn on the news I see another story about children bullying others or getting bullied themselves.   I am sure most of us have heard about Karen Klein, the bus monitor who was bullied by a group of kids.  I even caught a glimpse of Matt Lauer interviewing her and remember thinking how upset he was because at that moment he was a furious parent, not a reporter.  Watching the video of this woman being utterly harassed by a group of youngsters was horrifying.   I was struck by the fact that individually these are probably decent children, but in a group it seemed none of them could remember what I am hopeful their parents taught them at some point, which is to respect others and that bullying is wrong and will not be tolerated ever.  \r\n<p>\r\n I have definitely had my share of being bullied as a child.  I remember the middle school bully who everyday would torment me and my friends; she knew she was the school bully and it didn’t seem to bother her at all.  In fact, she seemed to wear that title proudly.  Thankfully, her wrath towards me and my friends didn’t last for long, but I do remember the mean things she’d say and obviously now as an adult I realize she just had her own issues and preyed on others to make herself feel better. \r\n<p>\r\nI know I can’t protect my children from everything, but I really hope that they never experience being bullied, and I certainly hope they never bully anyone.  Yes I know, I am living in lala land, but I would prefer it to our reality, which is youngsters tormenting others or those being tortured so badly they rather take their own lives than show their face in school.   How do we stop this?  How do we put an end to bullying?  How can parents and schools work together to end what seems like an epidemic in our society?  Obviously, nobody wants to raise a bully or the child that is constantly getting picked on.  It needs to stop.  I can’t even imagine the day my babies come home from school and tell me they were teased, it will break my heart and I truly DO NOT believe that it makes you stronger and I can’t stand when people say that either.  That to me is something you say when you have no clue how to address the situation.  Thankfully, when I was growing up there wasn’t cyber bullying, but nowadays kids no longer feel safe in their own homes.\r\n<p>\r\nI think the end to bullying starts at home.  We need to be extremely careful with what we say in front of our children.  I am certain we are all guilty of not always taking kindly about neighbors, friends, or family members, but I think in front of our children we must model respect and if we want to gossip make certain little ears are not around to hear it. \r\n<p> \r\nEducating children at a young age about feelings is extremely valuable.  So many of us talk to our children about problems as they arise, but maybe we need to address situations preemptively.  I sometimes create scenarios with my daughter and ask how she’d handle it.  I also think creating puppet shows and finding books on the topic are important too.  One of the books that I think is amazing for young children is the book called, “One” by Kathryn Otoshi.   If you don’t have it on your bookshelf please order it now!  And NO, I do not know the author, but I think the message speaks volumes.\r\n<p>\r\nI worry if perhaps our schools are not doing enough to handle the problem of bullying.  We are so concerned with reading and math scores.  Of course I want my children to do well in school, but my main priority is to raise children who are kind and confident because that goes a very long way in life.  As adults, I think many of us realize that nobody is that impressed with your SAT scores!   In fact, I don’t even remember the last time my SAT scores came up in a conversation – thankfully, because let’s just say they weren’t exactly stellar.  \r\n<p>\r\nOur website is about helping to “teach, share, and inspire” young children.  Let’s work together to teach our youngsters how to treat others, share ways to problem solve, and inspire them to be their own person.   \r\n', 1, '2012-07-11 18:12:10', '2012-11-13 07:53:17', 'Rebecca Schleifer', NULL),
(8, 'What It Really Means To "Share"', 'what-it-really-means-to-share', '', '<p>What is the most overused word in your vocabulary?  Having two kids, I know mine - and no, it''s not a four letter word! I must tell my children to "share" about fifty times a day.  It''s their least favorite word.  My 4 year old usually says, "No, I don''t want to share."  I get it!  It''s really hard to teach children to share, but I feel like I am obsessed with it.  You never want to be that parent that goes in for your preschool conference and the teacher tells you that your "pride and joy" has a hard time sharing!  Do you pretend to act shocked or do you give her the 411 that your child is on a sharing strike?\r\n<p>I think my children have worn me down and I am going to stop insisting they share and rather teach them to "take turns" - that can be my next overused phrase!  After all, ya both can''t use the red marker at the same time, but you can use it and then give it to your friend or sibling.\r\n<p>My children might have trouble sharing in the playroom, but I am more concerned about them sharing with others in life.  It''s really important that my youngsters are aware of how fortunate they are and that giving back to others is sharing.  I hope to teach my children to value the things they have and try in some ways to share with others who could use some help.  \r\n<p>I also think it''s important for parents to begin having conversations with their children at a young age and teaching ways to give back.  It can be simple -  donating a can of food a week to a food pantry, or donating a winter coat to a coat drive.  Learning the real meaning and value of sharing will hopefully create a generation of children who know that sharing goes far deeper than the playroom.     ', 1, '2012-08-28 01:58:49', '2012-11-13 07:53:17', 'Rebecca Schleifer', NULL),
(9, 'Sandy Provides a Teachable Moment', 'sandy-provides-a-teachable-moment', '', '<p>As I sat on a line waiting to fill my car up with gas, I could not help but think of all those completely devastated by Hurricane Sandy.  My heart aches for those who lost their lives and homes.  I watch the destruction on television and feel sick.  \r\n\r\n<p>I am truly fortunate - my family is safe and I have power, which even made me feel a bit guilty because so many were, and still remain, without.  I am eager to help others who truly need it due to this devastating storm. I also want my children to get involved.  \r\n\r\n<p>So, I took my almost 5 year old and 3 year old to Target yesterday.  I explained that we are not shopping for us, but we are going to shop for people who can’t be in their homes right now.  I was careful with what I said because I don’t want to scare my young children.  When we went to Target and they helped select some warm clothes and necessities for children who need them.  Of course they tried to get things for themselves too, but I really stressed the importance that today we were shopping for others.  I did get them a pack of gum on our way out, which in this house is quite the reward!  I thanked my children for being good helpers and told them that there were a lot of children that would smile because of them. \r\n\r\n<p>I want my children to be kind and appreciative, let''s not forget to teach our youngsters that people are more important than things.\r\nWe need to keep in mind they emulate us, so let’s teach them to be good citizens and remember it starts with us. Donate to a cause, volunteer, or help a friend who may not have a place to go, don''t let this hurricane take away our kindness, after all it''s one of the most important qualities a person can have.\r\n', 1, '2012-11-05 18:39:29', '2012-11-13 07:53:17', 'Rebecca Schleifer', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `posts_categories`
--

CREATE TABLE IF NOT EXISTS `posts_categories` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) collate utf8_unicode_ci default NULL,
  `description` text collate utf8_unicode_ci,
  `slug` varchar(255) collate utf8_unicode_ci default NULL,
  `sequence` smallint(6) default '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `index_posts_categories_on_slug` (`slug`),
  KEY `index_posts_categories_on_sequence` (`sequence`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=4 ;

--
-- Dumping data for table `posts_categories`
--

INSERT INTO `posts_categories` (`id`, `name`, `description`, `slug`, `sequence`, `created_at`, `updated_at`) VALUES
(1, 'Our Blog', 'Our Blog Description', 'our-blog', 0, '2012-12-22 02:01:46', '2012-12-22 02:01:46'),
(2, 'Tips and Tools', 'Tips and Tools Description', 'tips-and-tools', 1, '2012-12-22 02:01:46', '2012-12-22 02:01:46'),
(3, 'In The News', 'In The News Description', 'in-the-news', 2, '2012-12-22 02:01:46', '2012-12-22 02:01:46');

-- --------------------------------------------------------

--
-- Table structure for table `schema_migrations`
--

CREATE TABLE IF NOT EXISTS `schema_migrations` (
  `version` varchar(255) collate utf8_unicode_ci NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `schema_migrations`
--

INSERT INTO `schema_migrations` (`version`) VALUES
('20120330170606'),
('20120425160119'),
('20120425194745'),
('20120425200726'),
('20120510005348'),
('20120510204011'),
('20120511125254'),
('20120511134631'),
('20120511140405'),
('20120511141340'),
('20120511150327'),
('20120511150548'),
('20120512005821'),
('20120515181738'),
('20120516133845'),
('20120516145229'),
('20120624170725'),
('20120624172235'),
('20120624172403'),
('20120624172926'),
('20120624173848'),
('20120626015536'),
('20120704171836'),
('20120705131935'),
('20120705133344'),
('20120705195228'),
('20120712201340'),
('20120806190304'),
('20120806214249'),
('20120807220435'),
('20120813192844'),
('20120815004255'),
('20120829162533'),
('20120831081303'),
('20120831134514'),
('20120831134608'),
('20120901204714'),
('20120902020501'),
('20120906001007'),
('20120906221812'),
('20120911063746'),
('20120912070552'),
('20120913062725'),
('20120913063044'),
('20120913065701'),
('20120921075012'),
('20120921075432'),
('20120924115641'),
('20120925155710'),
('20120925224336'),
('20120926145815'),
('20120926175250'),
('20120926222033'),
('20120928031558'),
('20120928033518'),
('20120928035745'),
('20120928043706'),
('20120930004155'),
('20121003072905'),
('20121003192031'),
('20121010093959'),
('20121011072935'),
('20121011103102'),
('20121011134258'),
('20121011150535'),
('20121012153238'),
('20121015020611'),
('20121015063916'),
('20121018100844'),
('20121018105650'),
('20121018155428'),
('20121019141714'),
('20121019141808'),
('20121019141824'),
('20121019142739'),
('20121019164900'),
('20121020025708'),
('20121024104142'),
('20121024122328'),
('20121024131040'),
('20121030085620'),
('20121030151512'),
('20121030152107'),
('20121030152121'),
('20121030152135'),
('20121030152150'),
('20121030152204'),
('20121030152219'),
('20121030152233'),
('20121030152248'),
('20121030152302'),
('20121030152316'),
('20121102170606'),
('20121102174026'),
('20121106123701'),
('20121106154647'),
('20121107092610'),
('20121108071736'),
('20121109145706'),
('20121109151329'),
('20121120134801'),
('20121129080340'),
('20121204115310'),
('20121205160409'),
('20121205165045'),
('20121205171332'),
('20121210153310'),
('20121217181435'),
('20121219152736'),
('20121219152832'),
('20121221133734'),
('20130115184701'),
('20130219015306');

-- --------------------------------------------------------

--
-- Table structure for table `shipments`
--

CREATE TABLE IF NOT EXISTS `shipments` (
  `id` int(11) NOT NULL auto_increment,
  `order_id` int(11) NOT NULL,
  `shipping_method_code` int(11) default NULL,
  `shipment_tracking_number` varchar(255) collate utf8_unicode_ci default NULL,
  `special_instructions` varchar(255) collate utf8_unicode_ci default NULL,
  `shipment_date` datetime default NULL,
  `internal_notes` text collate utf8_unicode_ci,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `states`
--

CREATE TABLE IF NOT EXISTS `states` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) collate utf8_unicode_ci NOT NULL,
  `abbr` varchar(255) collate utf8_unicode_ci NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=51 ;

--
-- Dumping data for table `states`
--

INSERT INTO `states` (`id`, `name`, `abbr`) VALUES
(1, 'Alaska', 'AK'),
(2, 'Arizona', 'AZ'),
(3, 'Arkansas', 'AR'),
(4, 'California', 'CA'),
(5, 'Colorado', 'CO'),
(6, 'Connecticut', 'CT'),
(7, 'Delaware', 'DE'),
(8, 'Florida', 'FL'),
(9, 'Georgia', 'GA'),
(10, 'Hawaii', 'HI'),
(11, 'Idaho', 'ID'),
(12, 'Illinois', 'IL'),
(13, 'Indiana', 'IN'),
(14, 'Iowa', 'IA'),
(15, 'Kansas', 'KS'),
(16, 'Kentucky', 'KY'),
(17, 'Louisiana', 'LA'),
(18, 'Maine', 'ME'),
(19, 'Maryland', 'MD'),
(20, 'Massachusetts', 'MA'),
(21, 'Michigan', 'MI'),
(22, 'Minnesota', 'MN'),
(23, 'Mississippi', 'MS'),
(24, 'Missouri', 'MO'),
(25, 'Montana', 'MT'),
(26, 'Nebraska', 'NE'),
(27, 'Nevada', 'NV'),
(28, 'New Hampshire', 'NH'),
(29, 'New Jersey', 'NJ'),
(30, 'New Mexico', 'NM'),
(31, 'New York', 'NY'),
(32, 'North Carolina', 'NC'),
(33, 'North Dakota', 'ND'),
(34, 'Ohio', 'OH'),
(35, 'Oklahoma', 'OK'),
(36, 'Oregon', 'OR'),
(37, 'Pennsylvania', 'PA'),
(38, 'Rhode Island', 'RI'),
(39, 'South Carolina', 'SC'),
(40, 'South Dakota', 'SD'),
(41, 'Tennessee', 'TN'),
(42, 'Texas', 'TX'),
(43, 'Utah', 'UT'),
(44, 'Vermont', 'VT'),
(45, 'Virginia', 'VA'),
(46, 'Washington', 'WA'),
(47, 'West Virginia', 'WV'),
(48, 'Wisconsin', 'WI'),
(49, 'Wyoming', 'WY'),
(50, 'District of Columbia', 'DC');

-- --------------------------------------------------------

--
-- Table structure for table `steps`
--

CREATE TABLE IF NOT EXISTS `steps` (
  `id` int(11) NOT NULL auto_increment,
  `title` varchar(255) collate utf8_unicode_ci default NULL,
  `order` smallint(6) default '0',
  `slug` varchar(255) collate utf8_unicode_ci default NULL,
  `locked_on_completion` tinyint(1) default '0',
  `must_complete` tinyint(1) default '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `index_steps_on_order` (`order`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=7 ;

--
-- Dumping data for table `steps`
--

INSERT INTO `steps` (`id`, `title`, `order`, `slug`, `locked_on_completion`, `must_complete`, `created_at`, `updated_at`) VALUES
(1, 'Event Details', 1, 'event-details', 0, 1, '2012-07-06 18:36:23', '2012-07-06 18:36:23'),
(2, 'Select Charity', 2, 'select-charity', 0, 0, '2012-07-06 18:36:23', '2012-07-06 18:36:23'),
(3, 'Personalize Page', 3, 'personalize-page', 0, 0, '2012-07-06 18:36:23', '2012-07-06 18:36:23'),
(4, 'Invite Guests', 4, 'invite-guests', 0, 0, '2012-07-06 18:36:23', '2012-07-06 18:36:23'),
(5, 'Publish', 5, 'publish', 1, 0, '2012-07-06 18:36:24', '2012-09-02 02:06:01');

-- --------------------------------------------------------

--
-- Table structure for table `subscribers`
--

CREATE TABLE IF NOT EXISTS `subscribers` (
  `id` int(11) NOT NULL auto_increment,
  `full_name` text collate utf8_unicode_ci,
  `email` text collate utf8_unicode_ci,
  `comment` text collate utf8_unicode_ci,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `displayme` tinyint(1) default '1',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `taggings`
--

CREATE TABLE IF NOT EXISTS `taggings` (
  `id` int(11) NOT NULL auto_increment,
  `tag_id` int(11) default NULL,
  `taggable_id` int(11) default NULL,
  `taggable_type` varchar(255) collate utf8_unicode_ci default NULL,
  `tagger_id` int(11) default NULL,
  `tagger_type` varchar(255) collate utf8_unicode_ci default NULL,
  `context` varchar(128) collate utf8_unicode_ci default NULL,
  `created_at` datetime default NULL,
  PRIMARY KEY  (`id`),
  KEY `index_taggings_on_tag_id` (`tag_id`),
  KEY `index_taggings_on_taggable_id_and_taggable_type_and_context` (`taggable_id`,`taggable_type`,`context`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `tags`
--

CREATE TABLE IF NOT EXISTS `tags` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(255) collate utf8_unicode_ci default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `themes`
--

CREATE TABLE IF NOT EXISTS `themes` (
  `code` varchar(25) collate utf8_unicode_ci NOT NULL,
  `friendly_name` varchar(255) collate utf8_unicode_ci default NULL,
  `is_premium` tinyint(1) default '0',
  `cost` decimal(8,2) default '0.00',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY  (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `themes`
--

INSERT INTO `themes` (`code`, `friendly_name`, `is_premium`, `cost`, `created_at`, `updated_at`) VALUES
('default', 'Default', 0, '0.00', '2012-10-18 21:55:54', '2012-10-18 21:55:54'),
('fifth', 'Fifth', 1, '10.00', '2012-10-18 21:55:54', '2012-10-18 21:55:54'),
('first', 'First', 0, '0.00', '2012-10-18 21:55:54', '2012-10-18 21:55:54'),
('fourth', 'Fourth', 0, '0.00', '2012-10-18 21:55:54', '2012-10-18 21:55:54'),
('second', 'Second', 0, '0.00', '2012-10-18 21:55:54', '2012-10-18 21:55:54'),
('third', 'Third', 0, '0.00', '2012-10-18 21:55:54', '2012-10-18 21:55:54');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL auto_increment,
  `email` varchar(255) collate utf8_unicode_ci NOT NULL default '',
  `encrypted_password` varchar(255) collate utf8_unicode_ci NOT NULL default '',
  `reset_password_token` varchar(255) collate utf8_unicode_ci default NULL,
  `reset_password_sent_at` datetime default NULL,
  `remember_created_at` datetime default NULL,
  `sign_in_count` int(11) default '0',
  `current_sign_in_at` datetime default NULL,
  `last_sign_in_at` datetime default NULL,
  `current_sign_in_ip` varchar(255) collate utf8_unicode_ci default NULL,
  `last_sign_in_ip` varchar(255) collate utf8_unicode_ci default NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `full_name` varchar(255) collate utf8_unicode_ci NOT NULL,
  `user_name` varchar(255) collate utf8_unicode_ci default NULL,
  `cached_slug` varchar(255) collate utf8_unicode_ci default NULL,
  `language` varchar(255) collate utf8_unicode_ci default 'en',
  `is_under_age` tinyint(1) default '0',
  `terms_of_use` tinyint(1) default '0',
  `subscriber_opt_in` tinyint(1) default '0',
  `role` varchar(255) collate utf8_unicode_ci default 'user',
  `braintree_customer_id` int(11) default NULL,
  `deleted_at` datetime default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `index_users_on_email` (`email`),
  UNIQUE KEY `index_users_on_reset_password_token` (`reset_password_token`),
  KEY `index_users_on_is_under_age` (`is_under_age`),
  KEY `index_users_on_role` (`role`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=24 ;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `email`, `encrypted_password`, `reset_password_token`, `reset_password_sent_at`, `remember_created_at`, `sign_in_count`, `current_sign_in_at`, `last_sign_in_at`, `current_sign_in_ip`, `last_sign_in_ip`, `created_at`, `updated_at`, `full_name`, `user_name`, `cached_slug`, `language`, `is_under_age`, `terms_of_use`, `subscriber_opt_in`, `role`, `braintree_customer_id`, `deleted_at`) VALUES
(1, 'eric@veryinventive.com', '$2a$10$H5bJON9OAOdQ9HrQfGSjeOobNb2jNUkkyeVEUGgaRQOrCPq1bEwzG', NULL, NULL, '2013-02-18 18:00:23', 23, '2013-02-18 18:00:23', '2013-02-15 04:58:50', '71.190.168.187', '71.190.168.187', '2012-06-22 21:00:50', '2013-02-18 18:00:23', 'Eric', '', NULL, 'en', 0, 0, 0, 'admin', 3357892, NULL),
(2, 'buck@shareyourwish.com', '$2a$10$N8XOyl/IENp7MgAwGqZDTOOxzmH0Gf.E1aYSpKeo87cBUPDx17Xt.', NULL, NULL, '2013-02-15 16:42:55', 118, '2013-02-15 17:59:44', '2013-02-15 17:58:29', '129.77.117.70', '129.77.117.70', '2012-07-09 19:36:58', '2013-02-15 17:59:44', 'Buck', 'Buck', NULL, 'en', 0, 1, 0, 'admin', NULL, NULL),
(3, 'rebecca@shareyourwish.com', '$2a$10$0yx5Cw/2KBgLwWrfCL39Q.lWUpFIjBHU5a2JKYlm/f.MzLytqdk2m', NULL, NULL, NULL, 4, '2013-01-12 15:13:17', '2013-01-12 14:51:06', '71.190.168.187', '108.6.182.159', '2012-07-09 19:37:25', '2013-01-14 21:18:08', 'Rebecca', 'Rebecca', NULL, 'en', 0, 0, 0, 'admin', NULL, NULL),
(4, 'test@useroo.com', '$2a$10$pXNUFxDPEmUSSjmS5H8QqO8nAoCku4dLfvYgTcK12cvR8EKvem4bC', NULL, NULL, NULL, 1, '2012-09-02 16:47:10', '2012-09-02 16:47:10', '71.183.45.68', '71.183.45.68', '2012-09-02 16:47:09', '2012-09-19 14:52:26', 'Test Useroo', NULL, NULL, 'en', 0, 0, 1, 'tester', NULL, NULL),
(5, 'chernyakov.sergey@skykillers.com', '$2a$10$WHurzBlnW7oCO5pms3DkeOAkPMgtUjxL2BNgBIn06RgYO4RflhdvG', NULL, NULL, NULL, 6, '2012-11-06 15:12:48', '2012-11-01 12:25:13', '178.92.223.193', '95.135.3.25', '2012-09-03 13:02:54', '2012-11-27 11:38:43', 'Sergey Chernyakov', '', NULL, 'en', 0, 0, 0, 'tester', NULL, NULL),
(6, 'buckota@aol.com', '$2a$10$ZB22K2c8rtze5RxMhUyGj.g5blS6c/Ko6/lfF/cnp8n5idre6YoqS', NULL, NULL, '2012-09-26 14:41:48', 3, '2012-09-26 14:41:48', '2012-09-10 14:39:18', '129.77.117.70', '129.77.117.70', '2012-09-06 13:46:44', '2012-09-26 14:41:48', 'Buck Schleifer', NULL, NULL, 'en', 0, 1, 1, 'tester', NULL, NULL),
(7, 'tobispino@gmail.com', '$2a$10$.SZyWDZBTaMfvWI1yajEe.SAF2ZeosE9hzloRaOEEDd/O.CtQEXDi', NULL, NULL, '2012-09-07 02:01:56', 8, '2012-09-18 00:27:07', '2012-09-17 19:37:52', '69.116.218.16', '69.116.218.16', '2012-09-07 02:01:56', '2012-09-18 00:27:07', 'Tobi Spino', NULL, NULL, 'en', 0, 1, 1, 'tester', NULL, NULL),
(8, 'lgschleifer@verizon.net', '$2a$10$XqwmsifciAClVs06OMXOCeShPS76cPNpaVwIEgAN7AUDXtnzRDjGu', NULL, NULL, '2012-09-07 17:13:17', 1, '2012-09-07 17:13:17', '2012-09-07 17:13:17', '173.210.90.226', '173.210.90.226', '2012-09-07 17:13:17', '2012-09-07 17:13:17', 'Leah Schleifer', NULL, NULL, 'en', 0, 1, 1, 'tester', NULL, NULL),
(9, 'lbnemeroff@gmail.com', '$2a$10$HboF1RSoLnqGXYdBXaQCsOCBIrCuXMglJYIbdiwG5IftIiHUfMGJa', NULL, NULL, '2012-09-08 12:52:10', 1, '2012-09-08 12:52:10', '2012-09-08 12:52:10', '108.41.191.66', '108.41.191.66', '2012-09-08 12:52:10', '2012-09-08 12:52:10', 'Lisa Nemeroff', NULL, NULL, 'en', 0, 1, 1, 'tester', NULL, NULL),
(10, 'alexreichgott@gmail.com', '$2a$10$u/xqLq0wc5BjsBEaafbypu2GOggZQ1.xvgwvRLrm8D4JpVJY5hfrC', NULL, NULL, '2012-09-09 02:42:07', 1, '2012-09-09 02:42:07', '2012-09-09 02:42:07', '96.224.247.223', '96.224.247.223', '2012-09-09 02:42:06', '2012-09-09 02:42:07', 'Alex Reichgott', NULL, NULL, 'en', 0, 1, 1, 'tester', NULL, NULL),
(11, 'joe@test.com', '$2a$10$smfDQYum/S9rWecuZjI4NelHDPHqaNNDzTjNe0cUAYH9NNeql2dcu', NULL, NULL, NULL, 1, '2012-09-10 04:03:27', '2012-09-10 04:03:27', '71.183.45.68', '71.183.45.68', '2012-09-10 04:03:26', '2012-09-10 04:08:02', 'Joe Test', NULL, NULL, 'en', 0, 1, 1, 'tester', NULL, NULL),
(12, 'staceydarcy@gmail.com', '$2a$10$wwD/wIZD7RBEWaX2KIZpp.xJremiabFS3OpTMe2.7ik8lJOkIozLS', NULL, NULL, '2012-09-10 04:41:11', 1, '2012-09-10 04:41:11', '2012-09-10 04:41:11', '74.101.27.151', '74.101.27.151', '2012-09-10 04:41:11', '2012-09-21 20:41:26', 'Stacey D''Arcy', '', NULL, 'en', 0, 1, 1, 'tester', NULL, NULL),
(13, 'arcamone725@verizon.net', '$2a$10$FtYlk9XohQ46UV23WhBXF.TMxVixZdulmxuJxgDZRiT/CirtRHcwK', NULL, NULL, NULL, 1, '2012-09-11 01:33:25', '2012-09-11 01:33:25', '173.68.158.119', '173.68.158.119', '2012-09-11 01:33:25', '2012-09-21 20:41:15', 'tami arcamone', '', NULL, 'en', 0, 1, 1, 'tester', NULL, NULL),
(14, 'evanbarth@gmail.com', '$2a$10$28I6GyqeMuIu5IVnsIyI9.GToINUg9xC6cor.GUPYtd8cUYYuPHDG', NULL, NULL, '2012-09-12 12:46:19', 4, '2012-09-12 12:46:21', '2012-09-12 12:46:19', '166.137.88.174', '166.137.88.174', '2012-09-11 13:49:12', '2012-09-21 20:41:03', 'Evan Barth', '', NULL, 'en', 0, 1, 1, 'tester', NULL, NULL),
(15, 'jsavitsky@jandellselections.com', '$2a$10$bSLx0PVujBZOudzmqZ0eleMfEdBxBe1w2.9Yus54TtFj.d7p08rjS', NULL, NULL, NULL, 1, '2012-09-12 18:30:39', '2012-09-12 18:30:39', '69.38.244.162', '69.38.244.162', '2012-09-12 18:30:39', '2012-09-21 20:40:39', 'Jason Savitsky', '', NULL, 'en', 0, 1, 1, 'tester', NULL, NULL),
(16, 'rluks@yahoo.com', '$2a$10$udLMbybOtA6LmfP276zA2e0rjw2q3w8A/ClBNK3ntkNvuRX9NEOoG', NULL, NULL, '2012-09-12 18:46:59', 2, '2012-09-18 17:45:40', '2012-09-12 18:46:59', '70.192.70.71', '70.192.65.76', '2012-09-12 18:46:59', '2012-09-21 20:40:22', 'rebecca', '', NULL, 'en', 0, 1, 1, 'tester', NULL, NULL),
(17, 'joey@donuts.com', '$2a$10$Golb/vuqY54Vd0AKz/2mr.86.vxf0gjM6Isp5rwJBMOInXcAx.vWq', NULL, NULL, '2012-09-12 19:41:05', 1, '2012-09-12 19:41:05', '2012-09-12 19:41:05', '71.183.45.68', '71.183.45.68', '2012-09-12 19:41:05', '2012-09-12 19:41:05', 'Joey Bagodonuts', NULL, NULL, 'en', 0, 0, 1, 'tester', NULL, NULL),
(18, 'russelljlev@gmail.com', '$2a$10$jbARps/07iYScoETXa9hzuhbSnuyv.4qFfNgeyO7b9bBEC6QymUQa', NULL, NULL, '2012-09-17 16:03:12', 1, '2012-09-17 16:03:12', '2012-09-17 16:03:12', '69.126.50.139', '69.126.50.139', '2012-09-17 16:03:12', '2012-09-21 20:40:48', 'Russell Lev', '', NULL, 'en', 0, 1, 1, 'tester', NULL, NULL),
(19, 'tester@random.com', '$2a$10$ZOiYnSFUIriAVbMdh9p.IOOYXwEAztZqwnjfEAYwaZU9Wp81S2mp2', NULL, NULL, '2012-09-24 16:11:21', 2, '2012-09-26 02:14:33', '2012-09-24 16:11:21', '71.183.45.68', '71.183.45.68', '2012-09-24 16:11:20', '2012-09-26 02:14:33', 'Random Tester', '', NULL, 'en', 0, 0, 1, 'tester', NULL, NULL),
(20, 'ehanratty@me.com', '$2a$10$i8W2a822rwmwlwrhdB/ro.xqhxAiXGmwZ/.eY.oLl02wJUjVdgC76', NULL, NULL, '2012-09-26 17:40:50', 1, '2012-09-26 17:40:50', '2012-09-26 17:40:50', '69.117.43.207', '69.117.43.207', '2012-09-26 17:40:50', '2012-09-26 17:40:50', 'Emma Hanratty', NULL, NULL, 'en', 0, 1, 1, 'user', NULL, NULL),
(21, 'boy@george.com', '$2a$10$/Zhk16K6TvuL7GDJIxrCyuM.UnMs8jYRdFiHMy772VKOifCV4eyk6', NULL, NULL, NULL, 2, '2012-10-19 03:31:30', '2012-10-19 03:30:29', '71.183.45.68', '71.183.45.68', '2012-10-19 03:30:29', '2012-10-19 03:32:08', 'Boy', NULL, NULL, 'en', 0, 1, 1, 'user', NULL, NULL),
(22, 'eric@ericputter.com', '', NULL, NULL, NULL, 6, '2012-12-13 21:30:11', '2012-12-05 06:18:21', '71.183.45.68', '71.183.45.68', '2012-11-29 18:21:55', '2012-12-13 21:30:11', 'Eric R Putter', NULL, NULL, 'en', 0, 1, 1, 'user', NULL, NULL),
(23, 'test@boof.com', '$2a$10$iT5CbSlY1Drhg3iid5nIquV.EaMIb5Mp6wwVz17hh9MiIgPs8j.vu', NULL, NULL, '2012-12-30 17:09:54', 1, '2012-12-30 17:09:54', '2012-12-30 17:09:54', '71.183.45.68', '71.183.45.68', '2012-12-30 17:09:53', '2012-12-30 17:09:54', 'test 123', NULL, NULL, 'en', 0, 1, 1, 'tester', NULL, NULL);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
