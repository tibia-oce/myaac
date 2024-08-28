-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: database:3306
-- Generation Time: Aug 28, 2024 at 08:11 AM
-- Server version: 11.5.2-MariaDB-ubu2404
-- PHP Version: 8.2.22

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `forgottenserver`
--

-- --------------------------------------------------------

--
-- Table structure for table `accounts`
--

CREATE TABLE `accounts` (
  `id` int(11) NOT NULL,
  `name` varchar(32) NOT NULL,
  `password` char(40) NOT NULL,
  `secret` char(16) DEFAULT NULL,
  `type` int(11) NOT NULL DEFAULT 1,
  `premium_ends_at` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `email` varchar(255) NOT NULL DEFAULT '',
  `created` int(11) NOT NULL DEFAULT 0,
  `rlname` varchar(255) NOT NULL DEFAULT '',
  `location` varchar(255) NOT NULL DEFAULT '',
  `country` varchar(3) NOT NULL DEFAULT '',
  `web_lastlogin` int(11) NOT NULL DEFAULT 0,
  `web_flags` int(11) NOT NULL DEFAULT 0,
  `email_hash` varchar(32) NOT NULL DEFAULT '',
  `email_new` varchar(255) NOT NULL DEFAULT '',
  `email_new_time` int(11) NOT NULL DEFAULT 0,
  `email_code` varchar(255) NOT NULL DEFAULT '',
  `email_next` int(11) NOT NULL DEFAULT 0,
  `premium_points` int(11) NOT NULL DEFAULT 0,
  `email_verified` tinyint(1) NOT NULL DEFAULT 0,
  `key` varchar(64) NOT NULL DEFAULT '',
  `creation` int(11) NOT NULL DEFAULT 0,
  `premdays` int(11) NOT NULL DEFAULT 0,
  `lastday` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `vote` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_uca1400_ai_ci;

--
-- Dumping data for table `accounts`
--

INSERT INTO `accounts` (`id`, `name`, `password`, `secret`, `type`, `premium_ends_at`, `email`, `created`, `rlname`, `location`, `country`, `web_lastlogin`, `web_flags`, `email_hash`, `email_new`, `email_new_time`, `email_code`, `email_next`, `premium_points`, `email_verified`, `key`, `creation`, `premdays`, `lastday`, `vote`) VALUES
(1, 'god', '21298df8a3277357ee55b01df9530b535cf08ec1', NULL, 5, 1756337472, 'jordan.hoare@outlook.com', 0, 'Jordan', '', 'au', 0, 3, '', '', 0, '', 0, 50000, 1, '', 0, 300, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `account_bans`
--

CREATE TABLE `account_bans` (
  `account_id` int(11) NOT NULL,
  `reason` varchar(255) NOT NULL,
  `banned_at` bigint(20) NOT NULL,
  `expires_at` bigint(20) NOT NULL,
  `banned_by` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `account_ban_history`
--

CREATE TABLE `account_ban_history` (
  `id` int(10) UNSIGNED NOT NULL,
  `account_id` int(11) NOT NULL,
  `reason` varchar(255) NOT NULL,
  `banned_at` bigint(20) NOT NULL,
  `expired_at` bigint(20) NOT NULL,
  `banned_by` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `account_storage`
--

CREATE TABLE `account_storage` (
  `account_id` int(11) NOT NULL,
  `key` int(10) UNSIGNED NOT NULL,
  `value` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `account_viplist`
--

CREATE TABLE `account_viplist` (
  `account_id` int(11) NOT NULL COMMENT 'id of account whose viplist entry it is',
  `player_id` int(11) NOT NULL COMMENT 'id of target player of viplist entry',
  `description` varchar(128) NOT NULL DEFAULT '',
  `icon` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `notify` tinyint(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `guilds`
--

CREATE TABLE `guilds` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `ownerid` int(11) NOT NULL,
  `creationdata` int(11) NOT NULL,
  `motd` varchar(255) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  `logo_name` varchar(255) NOT NULL DEFAULT 'default.gif'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_uca1400_ai_ci;

--
-- Triggers `guilds`
--
DELIMITER $$
CREATE TRIGGER `oncreate_guilds` AFTER INSERT ON `guilds` FOR EACH ROW BEGIN
    INSERT INTO `guild_ranks` (`name`, `level`, `guild_id`) VALUES ('the Leader', 3, NEW.`id`);
    INSERT INTO `guild_ranks` (`name`, `level`, `guild_id`) VALUES ('a Vice-Leader', 2, NEW.`id`);
    INSERT INTO `guild_ranks` (`name`, `level`, `guild_id`) VALUES ('a Member', 1, NEW.`id`);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `guildwar_kills`
--

CREATE TABLE `guildwar_kills` (
  `id` int(11) NOT NULL,
  `killer` varchar(50) NOT NULL,
  `target` varchar(50) NOT NULL,
  `killerguild` int(11) NOT NULL DEFAULT 0,
  `targetguild` int(11) NOT NULL DEFAULT 0,
  `warid` int(11) NOT NULL DEFAULT 0,
  `time` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `guild_invites`
--

CREATE TABLE `guild_invites` (
  `player_id` int(11) NOT NULL DEFAULT 0,
  `guild_id` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `guild_membership`
--

CREATE TABLE `guild_membership` (
  `player_id` int(11) NOT NULL,
  `guild_id` int(11) NOT NULL,
  `rank_id` int(11) NOT NULL,
  `nick` varchar(15) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `guild_ranks`
--

CREATE TABLE `guild_ranks` (
  `id` int(11) NOT NULL,
  `guild_id` int(11) NOT NULL COMMENT 'guild',
  `name` varchar(255) NOT NULL COMMENT 'rank name',
  `level` int(11) NOT NULL COMMENT 'rank level - leader, vice, member, maybe something else'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `guild_wars`
--

CREATE TABLE `guild_wars` (
  `id` int(11) NOT NULL,
  `guild1` int(11) NOT NULL DEFAULT 0,
  `guild2` int(11) NOT NULL DEFAULT 0,
  `name1` varchar(255) NOT NULL,
  `name2` varchar(255) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 0,
  `started` bigint(20) NOT NULL DEFAULT 0,
  `ended` bigint(20) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `houses`
--

CREATE TABLE `houses` (
  `id` int(11) NOT NULL,
  `owner` int(11) NOT NULL,
  `paid` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `warnings` int(11) NOT NULL DEFAULT 0,
  `name` varchar(255) NOT NULL,
  `rent` int(11) NOT NULL DEFAULT 0,
  `town_id` int(11) NOT NULL DEFAULT 0,
  `bid` int(11) NOT NULL DEFAULT 0,
  `bid_end` int(11) NOT NULL DEFAULT 0,
  `last_bid` int(11) NOT NULL DEFAULT 0,
  `highest_bidder` int(11) NOT NULL DEFAULT 0,
  `size` int(11) NOT NULL DEFAULT 0,
  `beds` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `house_lists`
--

CREATE TABLE `house_lists` (
  `house_id` int(11) NOT NULL,
  `listid` int(11) NOT NULL,
  `list` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ip_bans`
--

CREATE TABLE `ip_bans` (
  `ip` int(10) UNSIGNED NOT NULL,
  `reason` varchar(255) NOT NULL,
  `banned_at` bigint(20) NOT NULL,
  `expires_at` bigint(20) NOT NULL,
  `banned_by` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `market_history`
--

CREATE TABLE `market_history` (
  `id` int(10) UNSIGNED NOT NULL,
  `player_id` int(11) NOT NULL,
  `sale` tinyint(4) NOT NULL DEFAULT 0,
  `itemtype` smallint(5) UNSIGNED NOT NULL,
  `amount` smallint(5) UNSIGNED NOT NULL,
  `price` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `expires_at` bigint(20) UNSIGNED NOT NULL,
  `inserted` bigint(20) UNSIGNED NOT NULL,
  `state` tinyint(3) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `market_offers`
--

CREATE TABLE `market_offers` (
  `id` int(10) UNSIGNED NOT NULL,
  `player_id` int(11) NOT NULL,
  `sale` tinyint(4) NOT NULL DEFAULT 0,
  `itemtype` smallint(5) UNSIGNED NOT NULL,
  `amount` smallint(5) UNSIGNED NOT NULL,
  `created` bigint(20) UNSIGNED NOT NULL,
  `anonymous` tinyint(4) NOT NULL DEFAULT 0,
  `price` int(10) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `myaac_account_actions`
--

CREATE TABLE `myaac_account_actions` (
  `account_id` int(11) NOT NULL,
  `ip` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `ipv6` binary(16) NOT NULL DEFAULT '0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0',
  `date` int(11) NOT NULL DEFAULT 0,
  `action` varchar(255) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_uca1400_ai_ci;

--
-- Dumping data for table `myaac_account_actions`
--

INSERT INTO `myaac_account_actions` (`account_id`, `ip`, `ipv6`, `date`, `action`) VALUES
(2, 2886860801, 0x00000000000000000000000000000000, 1724827006, 'Account created.'),
(3, 2886860801, 0x00000000000000000000000000000000, 1724829914, 'Account created.'),
(4, 2886860801, 0x00000000000000000000000000000000, 1724829981, 'Account created.'),
(4, 2886860801, 0x00000000000000000000000000000000, 1724829981, 'Created character <b>Testing</b>.'),
(5, 2886860801, 0x00000000000000000000000000000000, 1724832606, 'Account created.');

-- --------------------------------------------------------

--
-- Table structure for table `myaac_admin_menu`
--

CREATE TABLE `myaac_admin_menu` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL DEFAULT '',
  `page` varchar(255) NOT NULL DEFAULT '',
  `ordering` int(11) NOT NULL DEFAULT 0,
  `flags` int(11) NOT NULL DEFAULT 0,
  `enabled` int(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `myaac_bugtracker`
--

CREATE TABLE `myaac_bugtracker` (
  `account` varchar(255) NOT NULL,
  `type` int(11) NOT NULL DEFAULT 0,
  `status` int(11) NOT NULL DEFAULT 0,
  `text` text NOT NULL,
  `id` int(11) NOT NULL DEFAULT 0,
  `subject` varchar(255) NOT NULL DEFAULT '',
  `reply` int(11) NOT NULL DEFAULT 0,
  `who` int(11) NOT NULL DEFAULT 0,
  `uid` int(11) NOT NULL,
  `tag` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `myaac_changelog`
--

CREATE TABLE `myaac_changelog` (
  `id` int(11) NOT NULL,
  `body` varchar(500) NOT NULL DEFAULT '',
  `type` tinyint(1) NOT NULL DEFAULT 0 COMMENT '1 - added, 2 - removed, 3 - changed, 4 - fixed',
  `where` tinyint(1) NOT NULL DEFAULT 0 COMMENT '1 - server, 2 - site',
  `date` int(11) NOT NULL DEFAULT 0,
  `player_id` int(11) NOT NULL DEFAULT 0,
  `hidden` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_uca1400_ai_ci;

--
-- Dumping data for table `myaac_changelog`
--

INSERT INTO `myaac_changelog` (`id`, `body`, `type`, `where`, `date`, `player_id`, `hidden`) VALUES
(1, 'MyAAC installed. (:', 3, 2, 1724826980, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `myaac_config`
--

CREATE TABLE `myaac_config` (
  `id` int(11) NOT NULL,
  `name` varchar(30) NOT NULL,
  `value` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_uca1400_ai_ci;

--
-- Dumping data for table `myaac_config`
--

INSERT INTO `myaac_config` (`id`, `name`, `value`) VALUES
(1, 'database_version', '33'),
(2, 'status_online', ''),
(3, 'status_players', '0'),
(4, 'status_playersMax', '0'),
(5, 'status_lastCheck', '0'),
(6, 'status_uptime', '0h 0m'),
(7, 'status_monsters', '0');

-- --------------------------------------------------------

--
-- Table structure for table `myaac_faq`
--

CREATE TABLE `myaac_faq` (
  `id` int(11) NOT NULL,
  `question` varchar(255) NOT NULL DEFAULT '',
  `answer` varchar(1020) NOT NULL DEFAULT '',
  `ordering` int(11) NOT NULL DEFAULT 0,
  `hidden` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `myaac_forum`
--

CREATE TABLE `myaac_forum` (
  `id` int(11) NOT NULL,
  `first_post` int(11) NOT NULL DEFAULT 0,
  `last_post` int(11) NOT NULL DEFAULT 0,
  `section` int(3) NOT NULL DEFAULT 0,
  `replies` int(20) NOT NULL DEFAULT 0,
  `views` int(20) NOT NULL DEFAULT 0,
  `author_aid` int(20) NOT NULL DEFAULT 0,
  `author_guid` int(20) NOT NULL DEFAULT 0,
  `post_text` text NOT NULL,
  `post_topic` varchar(255) NOT NULL DEFAULT '',
  `post_smile` tinyint(1) NOT NULL DEFAULT 0,
  `post_html` tinyint(1) NOT NULL DEFAULT 0,
  `post_date` int(20) NOT NULL DEFAULT 0,
  `last_edit_aid` int(20) NOT NULL DEFAULT 0,
  `edit_date` int(20) NOT NULL DEFAULT 0,
  `post_ip` varchar(32) NOT NULL DEFAULT '0.0.0.0',
  `sticked` tinyint(1) NOT NULL DEFAULT 0,
  `closed` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `myaac_forum_boards`
--

CREATE TABLE `myaac_forum_boards` (
  `id` int(11) NOT NULL,
  `name` varchar(32) NOT NULL,
  `description` varchar(255) NOT NULL DEFAULT '',
  `ordering` int(11) NOT NULL DEFAULT 0,
  `guild` int(11) NOT NULL DEFAULT 0,
  `access` int(11) NOT NULL DEFAULT 0,
  `closed` tinyint(1) NOT NULL DEFAULT 0,
  `hidden` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_uca1400_ai_ci;

--
-- Dumping data for table `myaac_forum_boards`
--

INSERT INTO `myaac_forum_boards` (`id`, `name`, `description`, `ordering`, `guild`, `access`, `closed`, `hidden`) VALUES
(1, 'News', 'News commenting', 0, 0, 0, 1, 0),
(2, 'Trade', 'Trade offers.', 1, 0, 0, 0, 0),
(3, 'Quests', 'Quest making.', 2, 0, 0, 0, 0),
(4, 'Pictures', 'Your pictures.', 3, 0, 0, 0, 0),
(5, 'Bug Report', 'Report bugs there.', 4, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `myaac_gallery`
--

CREATE TABLE `myaac_gallery` (
  `id` int(11) NOT NULL,
  `comment` varchar(255) NOT NULL DEFAULT '',
  `image` varchar(255) NOT NULL,
  `thumb` varchar(255) NOT NULL,
  `author` varchar(50) NOT NULL DEFAULT '',
  `ordering` int(11) NOT NULL DEFAULT 0,
  `hidden` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_uca1400_ai_ci;

--
-- Dumping data for table `myaac_gallery`
--

INSERT INTO `myaac_gallery` (`id`, `comment`, `image`, `thumb`, `author`, `ordering`, `hidden`) VALUES
(1, 'Demon', 'images/gallery/demon.jpg', 'images/gallery/demon_thumb.gif', 'MyAAC', 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `myaac_menu`
--

CREATE TABLE `myaac_menu` (
  `id` int(11) NOT NULL,
  `template` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `link` varchar(255) NOT NULL,
  `blank` tinyint(1) NOT NULL DEFAULT 0,
  `color` varchar(6) NOT NULL DEFAULT '',
  `category` int(11) NOT NULL DEFAULT 1,
  `ordering` int(11) NOT NULL DEFAULT 0,
  `enabled` int(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_uca1400_ai_ci;

--
-- Dumping data for table `myaac_menu`
--

INSERT INTO `myaac_menu` (`id`, `template`, `name`, `link`, `blank`, `color`, `category`, `ordering`, `enabled`) VALUES
(1, 'kathrine', 'Latest News', 'news', 0, '', 1, 0, 1),
(2, 'kathrine', 'News Archive', 'news/archive', 0, '', 1, 1, 1),
(3, 'kathrine', 'Changelog', 'changelog', 0, '', 1, 2, 1),
(4, 'kathrine', 'Account Management', 'account/manage', 0, '', 2, 0, 1),
(5, 'kathrine', 'Create Account', 'account/create', 0, '', 2, 1, 1),
(6, 'kathrine', 'Lost Account?', 'account/lost', 0, '', 2, 2, 1),
(7, 'kathrine', 'Server Rules', 'rules', 0, '', 2, 3, 1),
(8, 'kathrine', 'Downloads', 'downloads', 0, '', 5, 4, 1),
(9, 'kathrine', 'Report Bug', 'bugtracker', 0, '', 2, 5, 1),
(10, 'kathrine', 'Who is Online?', 'online', 0, '', 3, 0, 1),
(11, 'kathrine', 'Characters', 'characters', 0, '', 3, 1, 1),
(12, 'kathrine', 'Guilds', 'guilds', 0, '', 3, 2, 1),
(13, 'kathrine', 'Highscores', 'highscores', 0, '', 3, 3, 1),
(14, 'kathrine', 'Last Deaths', 'lastkills', 0, '', 3, 4, 1),
(15, 'kathrine', 'Houses', 'houses', 0, '', 3, 5, 1),
(16, 'kathrine', 'Bans', 'bans', 0, '', 3, 6, 1),
(17, 'kathrine', 'Forum', 'forum', 0, '', 3, 7, 1),
(18, 'kathrine', 'Team', 'team', 0, '', 3, 8, 1),
(19, 'kathrine', 'Monsters', 'creatures', 0, '', 5, 0, 1),
(20, 'kathrine', 'Spells', 'spells', 0, '', 5, 1, 1),
(21, 'kathrine', 'Server Info', 'serverInfo', 0, '', 5, 2, 1),
(22, 'kathrine', 'Commands', 'commands', 0, '', 5, 3, 1),
(23, 'kathrine', 'Gallery', 'gallery', 0, '', 5, 4, 1),
(24, 'kathrine', 'Experience Table', 'experienceTable', 0, '', 5, 5, 1),
(25, 'kathrine', 'FAQ', 'faq', 0, '', 5, 6, 1),
(26, 'kathrine', 'Buy Points', 'points', 0, '', 6, 0, 1),
(27, 'kathrine', 'Shop Offer', 'gifts', 0, '', 6, 1, 1),
(28, 'kathrine', 'Shop History', 'gifts/history', 0, '', 6, 2, 1),
(29, 'tibiacom', 'Latest News', 'news', 0, '', 1, 0, 1),
(30, 'tibiacom', 'News Archive', 'news/archive', 0, '', 1, 1, 1),
(31, 'tibiacom', 'Changelog', 'changelog', 0, '', 1, 2, 1),
(32, 'tibiacom', 'Account Management', 'account/manage', 0, '', 2, 0, 1),
(33, 'tibiacom', 'Create Account', 'account/create', 0, '', 2, 1, 1),
(34, 'tibiacom', 'Lost Account?', 'account/lost', 0, '', 2, 2, 1),
(35, 'tibiacom', 'Server Rules', 'rules', 0, '', 2, 3, 1),
(36, 'tibiacom', 'Downloads', 'downloads', 0, '', 2, 4, 1),
(37, 'tibiacom', 'Report Bug', 'bugtracker', 0, '', 2, 5, 1),
(38, 'tibiacom', 'Characters', 'characters', 0, '', 3, 0, 1),
(39, 'tibiacom', 'Who Is Online?', 'online', 0, '', 3, 1, 1),
(40, 'tibiacom', 'Highscores', 'highscores', 0, '', 3, 2, 1),
(41, 'tibiacom', 'Last Kills', 'lastkills', 0, '', 3, 3, 1),
(42, 'tibiacom', 'Houses', 'houses', 0, '', 3, 4, 1),
(43, 'tibiacom', 'Guilds', 'guilds', 0, '', 3, 5, 1),
(44, 'tibiacom', 'Polls', 'polls', 0, '', 3, 6, 1),
(45, 'tibiacom', 'Bans', 'bans', 0, '', 3, 7, 1),
(46, 'tibiacom', 'Support List', 'team', 0, '', 3, 8, 1),
(47, 'tibiacom', 'Forum', 'forum', 0, '', 4, 0, 1),
(48, 'tibiacom', 'Creatures', 'creatures', 0, '', 5, 0, 1),
(49, 'tibiacom', 'Spells', 'spells', 0, '', 5, 1, 1),
(50, 'tibiacom', 'Commands', 'commands', 0, '', 5, 2, 1),
(51, 'tibiacom', 'Exp Stages', 'experienceStages', 0, '', 5, 3, 1),
(52, 'tibiacom', 'Gallery', 'gallery', 0, '', 5, 4, 1),
(53, 'tibiacom', 'Server Info', 'serverInfo', 0, '', 5, 5, 1),
(54, 'tibiacom', 'Experience Table', 'experienceTable', 0, '', 5, 6, 1),
(55, 'tibiacom', 'Buy Points', 'points', 0, '', 6, 0, 1),
(56, 'tibiacom', 'Shop Offer', 'gifts', 0, '', 6, 1, 1),
(57, 'tibiacom', 'Shop History', 'gifts/history', 0, '', 6, 2, 1);

-- --------------------------------------------------------

--
-- Table structure for table `myaac_monsters`
--

CREATE TABLE `myaac_monsters` (
  `id` int(11) NOT NULL,
  `hidden` tinyint(1) NOT NULL DEFAULT 0,
  `name` varchar(255) NOT NULL,
  `mana` int(11) NOT NULL DEFAULT 0,
  `exp` int(11) NOT NULL,
  `health` int(11) NOT NULL,
  `speed_lvl` int(11) NOT NULL DEFAULT 1,
  `use_haste` tinyint(1) NOT NULL,
  `voices` text NOT NULL,
  `immunities` varchar(255) NOT NULL,
  `summonable` tinyint(1) NOT NULL,
  `convinceable` tinyint(1) NOT NULL,
  `race` varchar(255) NOT NULL,
  `loot` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_uca1400_ai_ci;

--
-- Dumping data for table `myaac_monsters`
--

INSERT INTO `myaac_monsters` (`id`, `hidden`, `name`, `mana`, `exp`, `health`, `speed_lvl`, `use_haste`, `voices`, `immunities`, `summonable`, `convinceable`, `race`, `loot`) VALUES
(1461, 0, 'a carved stone tile', 0, 0, 100, 1, 0, '[]', '[\"invisible\"]', 0, 0, 'undead', '[]'),
(1462, 0, 'Abyssador', 0, 50000, 300000, 125, 0, '[\"*** BRAINS *** SMALL ***\",\"*** LIVE *** DRY ***\",\"*** IMPORTANT ***\",\"*** FIRE *** HOME *** VICTORY ***\",\"*** EXISTENCE *** FUTILE ***\",\"*** TIME ***\",\"*** STEALTH ***\",\"*** DEATH ***\"]', '[\"drown\",\"paralyze\",\"invisible\",\"earth\",\"drunk\",\"outfit\"]', 0, 0, 'blood', '[{\"id\":18449,\"count\":1,\"chance\":\"10000\"},{\"id\":18450,\"count\":1,\"chance\":\"5500\"},{\"id\":18451,\"count\":1,\"chance\":\"5500\"},{\"id\":18452,\"count\":1,\"chance\":\"4500\"},{\"id\":18453,\"count\":1,\"chance\":\"4500\"},{\"id\":18454,\"count\":1,\"chance\":\"10000\"},{\"id\":18465,\"count\":1,\"chance\":\"8000\"},{\"id\":18496,\"count\":1,\"chance\":\"100000\"}]'),
(1463, 0, 'Achad', 0, 70, 185, 1, 0, '[\"You won\'t pass me.\",\"I have travelled far to fight here.\"]', '[\"outfit\",\"drunk\",\"invisible\"]', 0, 0, 'blood', '[]'),
(1464, 0, 'Acid Blob', 0, 250, 250, 1, 0, '[\"Kzzchhh!\"]', '[\"death\",\"earth\"]', 0, 0, 'venom', '[{\"id\":9967,\"count\":1,\"chance\":\"14285\"}]'),
(1465, 0, 'Acolyte of the Cult', 0, 300, 390, 1, 0, '[\"Praise the voodoo!\",\"Power to the cult!\",\"Feel the power of the cult!\"]', '[\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"1962\",\"count\":1,\"chance\":\"730\"},{\"id\":2148,\"count\":\"40\",\"chance\":\"66940\"},{\"id\":2149,\"count\":1,\"chance\":\"550\"},{\"id\":2168,\"count\":1,\"chance\":\"560\"},{\"id\":2181,\"count\":1,\"chance\":\"250\"},{\"id\":2201,\"count\":1,\"chance\":\"1050\"},{\"id\":2394,\"count\":1,\"chance\":\"4990\"},{\"id\":5810,\"count\":1,\"chance\":\"1060\"},{\"id\":\"6088\",\"count\":1,\"chance\":\"480\"},{\"id\":10556,\"count\":1,\"chance\":\"8070\"},{\"id\":12411,\"count\":1,\"chance\":\"40\"},{\"id\":12448,\"count\":1,\"chance\":\"10420\"},{\"id\":12608,\"count\":1,\"chance\":\"60\"}]'),
(1466, 0, 'Adept of the Cult', 0, 400, 430, 1, 0, '[\"Feel the power of the cult!\",\"Praise the voodoo!\",\"Power to the cult!\"]', '[\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"1962\",\"count\":1,\"chance\":\"940\"},{\"id\":2147,\"count\":1,\"chance\":\"320\"},{\"id\":2148,\"count\":\"60\",\"chance\":\"65520\"},{\"id\":\"2169\",\"count\":1,\"chance\":\"420\"},{\"id\":2170,\"count\":1,\"chance\":\"1020\"},{\"id\":2183,\"count\":1,\"chance\":\"220\"},{\"id\":2423,\"count\":1,\"chance\":\"1260\"},{\"id\":2655,\"count\":1,\"chance\":\"80\"},{\"id\":5810,\"count\":1,\"chance\":\"1730\"},{\"id\":\"6089\",\"count\":1,\"chance\":\"700\"},{\"id\":7424,\"count\":1,\"chance\":\"120\"},{\"id\":7426,\"count\":1,\"chance\":\"680\"},{\"id\":10556,\"count\":1,\"chance\":\"10080\"},{\"id\":12411,\"count\":1,\"chance\":\"90\"},{\"id\":12448,\"count\":1,\"chance\":\"10000\"},{\"id\":12608,\"count\":1,\"chance\":\"120\"}]'),
(1467, 0, 'Adventurer', 0, 0, 65, 1, 0, '[]', '[]', 0, 0, 'blood', '[]'),
(1468, 0, 'Amarie', 0, 42, 100, 1, 0, '[\"Aaaaah! Let me out of here!!\",\"Help! Where am I?\",\"Noooo! What are you doing?\",\"Ulathil beia Thratha!\",\"What is this devilish scheme??\"]', '[\"invisible\"]', 0, 0, 'blood', '[]'),
(1469, 0, 'Amazon', 390, 60, 110, 1, 0, '[\"Yeeee ha!\",\"Your head shall be mine!\",\"Your head will be mine!\"]', '[]', 1, 1, 'blood', '[{\"id\":2379,\"count\":1,\"chance\":\"80000\"},{\"id\":\"2229\",\"count\":\"2\",\"chance\":\"80000\"},{\"id\":2148,\"count\":\"20\",\"chance\":\"40000\"},{\"id\":2691,\"count\":1,\"chance\":\"30333\"},{\"id\":2385,\"count\":1,\"chance\":\"23000\"},{\"id\":12399,\"count\":1,\"chance\":\"10000\"},{\"id\":12400,\"count\":1,\"chance\":\"5000\"},{\"id\":\"2050\",\"count\":1,\"chance\":\"1005\"},{\"id\":2125,\"count\":1,\"chance\":\"250\"},{\"id\":2147,\"count\":1,\"chance\":\"120\"}]'),
(1470, 0, 'Ancient Scarab', 0, 720, 1000, 1, 1, '[]', '[\"earth\",\"paralyze\",\"invisible\"]', 0, 0, 'venom', '[{\"id\":2148,\"count\":\"100\",\"chance\":\"50000\"},{\"id\":2148,\"count\":\"87\",\"chance\":\"50000\"},{\"id\":\"2162\",\"count\":1,\"chance\":\"10300\"},{\"id\":2159,\"count\":\"2\",\"chance\":\"8100\"},{\"id\":10548,\"count\":1,\"chance\":\"7140\"},{\"id\":2149,\"count\":\"3\",\"chance\":\"6000\"},{\"id\":2150,\"count\":\"4\",\"chance\":\"6000\"},{\"id\":2463,\"count\":1,\"chance\":\"5000\"},{\"id\":2135,\"count\":1,\"chance\":\"3510\"},{\"id\":\"2142\",\"count\":1,\"chance\":\"2670\"},{\"id\":7588,\"count\":1,\"chance\":\"1660\"},{\"id\":8912,\"count\":1,\"chance\":\"1000\"},{\"id\":2540,\"count\":1,\"chance\":\"500\"},{\"id\":7903,\"count\":1,\"chance\":\"400\"},{\"id\":2440,\"count\":1,\"chance\":\"300\"}]'),
(1471, 0, 'Angry Adventurer', 0, 50, 65, 1, 0, '[]', '[]', 0, 0, 'blood', '[]'),
(1472, 0, 'Annihilon', 0, 15000, 46500, 80, 1, '[\"Flee as long as you can!\",\"Annihilon\'s might will crush you all!\",\"I am coming for you!\"]', '[\"lifedrain\",\"invisible\"]', 0, 0, 'fire', '[{\"id\":\"2148\",\"count\":\"100\",\"chance\":\"100000\"},{\"id\":\"9810\",\"count\":1,\"chance\":\"62097\"},{\"id\":\"7632\",\"count\":\"2\",\"chance\":\"37903\"},{\"id\":\"2452\",\"count\":1,\"chance\":\"28226\"},{\"id\":\"7368\",\"count\":\"50\",\"chance\":\"23790\"},{\"id\":\"2158\",\"count\":1,\"chance\":\"22581\"},{\"id\":\"2427\",\"count\":1,\"chance\":\"22581\"},{\"id\":\"2154\",\"count\":1,\"chance\":\"22581\"},{\"id\":\"2127\",\"count\":1,\"chance\":\"22177\"},{\"id\":\"9971\",\"count\":1,\"chance\":\"20968\"},{\"id\":\"2156\",\"count\":1,\"chance\":\"20968\"},{\"id\":\"6529\",\"count\":\"46\",\"chance\":\"20565\"},{\"id\":\"7439\",\"count\":1,\"chance\":\"19758\"},{\"id\":\"2152\",\"count\":\"30\",\"chance\":\"19758\"},{\"id\":\"2547\",\"count\":\"99\",\"chance\":\"19758\"},{\"id\":\"2381\",\"count\":1,\"chance\":\"19355\"},{\"id\":\"7840\",\"count\":\"96\",\"chance\":\"18952\"},{\"id\":\"5944\",\"count\":\"5\",\"chance\":\"18952\"},{\"id\":\"2153\",\"count\":1,\"chance\":\"17742\"},{\"id\":\"7366\",\"count\":\"70\",\"chance\":\"16935\"},{\"id\":\"2155\",\"count\":1,\"chance\":\"16129\"},{\"id\":\"7440\",\"count\":1,\"chance\":\"15323\"},{\"id\":\"7591\",\"count\":1,\"chance\":\"14516\"},{\"id\":\"7421\",\"count\":1,\"chance\":\"14113\"},{\"id\":\"8473\",\"count\":1,\"chance\":\"13306\"},{\"id\":\"7590\",\"count\":1,\"chance\":\"12903\"},{\"id\":\"2519\",\"count\":1,\"chance\":\"12500\"},{\"id\":\"8472\",\"count\":1,\"chance\":\"12500\"},{\"id\":\"5954\",\"count\":\"2\",\"chance\":\"11694\"},{\"id\":\"8891\",\"count\":1,\"chance\":\"10484\"},{\"id\":\"2528\",\"count\":1,\"chance\":\"10081\"},{\"id\":\"2515\",\"count\":1,\"chance\":\"8468\"},{\"id\":\"7387\",\"count\":1,\"chance\":\"7258\"},{\"id\":\"2520\",\"count\":1,\"chance\":\"4032\"},{\"id\":\"2514\",\"count\":1,\"chance\":\"3629\"},{\"id\":\"7431\",\"count\":1,\"chance\":\"1613\"},{\"id\":\"8877\",\"count\":1,\"chance\":\"1210\"},{\"id\":\"8928\",\"count\":1,\"chance\":\"1210\"},{\"id\":\"8929\",\"count\":1,\"chance\":\"403\"}]'),
(1473, 0, 'Apocalypse', 0, 30000, 125000, 80, 1, '[\"BOW TO THE POWER OF THE RUTHLESS SEVEN!\",\"DESTRUCTION!\",\"CHAOS!\",\"DEATH TO ALL!\"]', '[\"energy\",\"fire\",\"earth\",\"lifedrain\",\"paralyze\",\"outfit\",\"drunk\",\"invisible\"]', 0, 0, 'fire', '[{\"id\":1982,\"count\":1,\"chance\":\"2600\"},{\"id\":2033,\"count\":1,\"chance\":\"7500\"},{\"id\":2112,\"count\":1,\"chance\":\"14500\"},{\"id\":2123,\"count\":1,\"chance\":\"3500\"},{\"id\":\"2124\",\"count\":1,\"chance\":\"5500\"},{\"id\":2125,\"count\":1,\"chance\":\"1500\"},{\"id\":\"2142\",\"count\":1,\"chance\":\"3500\"},{\"id\":2143,\"count\":\"15\",\"chance\":\"12500\"},{\"id\":2144,\"count\":\"15\",\"chance\":\"15000\"},{\"id\":2145,\"count\":\"5\",\"chance\":\"9500\"},{\"id\":2146,\"count\":\"10\",\"chance\":\"13500\"},{\"id\":2148,\"count\":\"400\",\"chance\":\"99900\"},{\"id\":2149,\"count\":\"10\",\"chance\":\"15500\"},{\"id\":2150,\"count\":\"20\",\"chance\":\"13500\"},{\"id\":2151,\"count\":\"7\",\"chance\":\"14000\"},{\"id\":2155,\"count\":1,\"chance\":\"1500\"},{\"id\":2158,\"count\":1,\"chance\":\"1500\"},{\"id\":\"2162\",\"count\":1,\"chance\":\"11500\"},{\"id\":2164,\"count\":1,\"chance\":\"5000\"},{\"id\":2165,\"count\":1,\"chance\":\"9500\"},{\"id\":2167,\"count\":1,\"chance\":\"13500\"},{\"id\":2170,\"count\":1,\"chance\":\"13000\"},{\"id\":2171,\"count\":1,\"chance\":\"4500\"},{\"id\":2174,\"count\":1,\"chance\":\"2500\"},{\"id\":2176,\"count\":1,\"chance\":\"12000\"},{\"id\":2177,\"count\":1,\"chance\":\"1000\"},{\"id\":\"2178\",\"count\":1,\"chance\":\"4000\"},{\"id\":2179,\"count\":1,\"chance\":\"8000\"},{\"id\":2182,\"count\":1,\"chance\":\"3500\"},{\"id\":2185,\"count\":1,\"chance\":\"3500\"},{\"id\":2186,\"count\":1,\"chance\":\"3500\"},{\"id\":2188,\"count\":1,\"chance\":\"2500\"},{\"id\":\"2192\",\"count\":1,\"chance\":\"2500\"},{\"id\":2195,\"count\":1,\"chance\":\"4000\"},{\"id\":2197,\"count\":1,\"chance\":\"4000\"},{\"id\":2200,\"count\":1,\"chance\":\"4500\"},{\"id\":2214,\"count\":1,\"chance\":\"13000\"},{\"id\":\"2231\",\"count\":1,\"chance\":\"9000\"},{\"id\":2377,\"count\":1,\"chance\":\"20000\"},{\"id\":2387,\"count\":1,\"chance\":\"20000\"},{\"id\":2393,\"count\":1,\"chance\":\"12500\"},{\"id\":2396,\"count\":1,\"chance\":\"7500\"},{\"id\":2402,\"count\":1,\"chance\":\"15500\"},{\"id\":2418,\"count\":1,\"chance\":\"4500\"},{\"id\":2421,\"count\":1,\"chance\":\"13500\"},{\"id\":2432,\"count\":1,\"chance\":\"17000\"},{\"id\":2434,\"count\":1,\"chance\":\"4500\"},{\"id\":2436,\"count\":1,\"chance\":\"5000\"},{\"id\":2462,\"count\":1,\"chance\":\"11000\"},{\"id\":2470,\"count\":1,\"chance\":\"5000\"},{\"id\":2472,\"count\":1,\"chance\":\"3000\"},{\"id\":\"2514\",\"count\":1,\"chance\":\"7500\"},{\"id\":2520,\"count\":1,\"chance\":\"15500\"},{\"id\":\"3955\",\"count\":1,\"chance\":\"100\"}]'),
(1474, 0, 'Apprentice Sheng', 0, 150, 95, 1, 0, '[\"I will protect the secrets of my master!\",\"Kaplar!\",\"This isle will become ours alone\",\"You already know too much.\"]', '[\"energy\"]', 0, 0, 'blood', '[{\"id\":\"5878\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2162\",\"count\":1,\"chance\":\"82222\"},{\"id\":\"2148\",\"count\":\"10\",\"chance\":\"71111\"},{\"id\":\"2050\",\"count\":\"2\",\"chance\":\"24444\"},{\"id\":\"2649\",\"count\":1,\"chance\":\"13333\"},{\"id\":\"2403\",\"count\":1,\"chance\":\"11111\"},{\"id\":\"2684\",\"count\":\"7\",\"chance\":\"6667\"},{\"id\":\"2461\",\"count\":1,\"chance\":\"6667\"}]'),
(1475, 0, 'Arachir The Ancient One', 0, 1800, 1600, 40, 0, '[\"I was the shadow that haunted the cradle of humanity!\",\"I exist since eons and you want to defy me?\",\"Can you feel the passage of time, mortal?\"]', '[\"lifedrain\",\"death\",\"invisible\"]', 0, 0, 'undead', '[{\"id\":2144,\"count\":1,\"chance\":\"8980\"},{\"id\":2148,\"count\":\"98\",\"chance\":\"100000\"},{\"id\":2152,\"count\":\"5\",\"chance\":\"50000\"},{\"id\":2214,\"count\":1,\"chance\":\"11111\"},{\"id\":\"2229\",\"count\":1,\"chance\":\"10000\"},{\"id\":2534,\"count\":1,\"chance\":\"6300\"},{\"id\":7416,\"count\":1,\"chance\":\"1200\"},{\"id\":7588,\"count\":1,\"chance\":\"10000\"},{\"id\":9020,\"count\":1,\"chance\":\"100000\"}]'),
(1476, 0, 'Armadile', 0, 2900, 3800, 110, 0, '[\"Creak!\"]', '[\"earth\",\"paralyze\",\"invisible\"]', 0, 0, 'undead', '[{\"id\":\"2148\",\"count\":\"198\",\"chance\":\"100000\"},{\"id\":\"2152\",\"count\":\"7\",\"chance\":\"95297\"},{\"id\":\"7591\",\"count\":\"2\",\"chance\":\"15477\"},{\"id\":\"7590\",\"count\":\"2\",\"chance\":\"15434\"},{\"id\":\"7589\",\"count\":\"2\",\"chance\":\"15092\"},{\"id\":\"7620\",\"count\":\"3\",\"chance\":\"14964\"},{\"id\":\"18432\",\"count\":1,\"chance\":\"14579\"},{\"id\":\"7588\",\"count\":\"2\",\"chance\":\"14579\"},{\"id\":\"12403\",\"count\":1,\"chance\":\"12527\"},{\"id\":\"18437\",\"count\":\"10\",\"chance\":\"11030\"},{\"id\":\"18436\",\"count\":\"5\",\"chance\":\"7781\"},{\"id\":\"13757\",\"count\":1,\"chance\":\"6456\"},{\"id\":\"18421\",\"count\":\"2\",\"chance\":\"5985\"},{\"id\":\"18416\",\"count\":\"2\",\"chance\":\"4147\"},{\"id\":\"7886\",\"count\":1,\"chance\":\"2565\"},{\"id\":\"7413\",\"count\":1,\"chance\":\"1496\"},{\"id\":\"2169\",\"count\":1,\"chance\":\"1240\"},{\"id\":\"7428\",\"count\":1,\"chance\":\"1069\"},{\"id\":\"2528\",\"count\":1,\"chance\":\"599\"},{\"id\":\"8878\",\"count\":1,\"chance\":\"214\"}]'),
(1477, 0, 'Armenius', 0, 500, 550, 55, 1, '[]', '[\"earth\",\"paralyze\",\"invisible\"]', 0, 0, 'venom', '[{\"id\":2135,\"count\":1,\"chance\":\"2063\"},{\"id\":\"2142\",\"count\":1,\"chance\":\"2564\"},{\"id\":2148,\"count\":\"90\",\"chance\":\"100000\"},{\"id\":2148,\"count\":\"90\",\"chance\":\"100000\"},{\"id\":2149,\"count\":\"3\",\"chance\":\"4347\"},{\"id\":2150,\"count\":\"4\",\"chance\":\"4166\"},{\"id\":2159,\"count\":\"2\",\"chance\":\"7692\"},{\"id\":\"2162\",\"count\":1,\"chance\":\"11111\"},{\"id\":2440,\"count\":1,\"chance\":\"781\"},{\"id\":2463,\"count\":1,\"chance\":\"10000\"},{\"id\":2540,\"count\":1,\"chance\":\"518\"},{\"id\":7588,\"count\":1,\"chance\":\"1041\"},{\"id\":7903,\"count\":1,\"chance\":\"1298\"},{\"id\":10548,\"count\":1,\"chance\":\"3571\"}]'),
(1478, 0, 'Ashmunrah', 0, 3100, 5000, 105, 0, '[\"No mortal or undead will steal my secrets!\",\"Ahhhh all those long years.\",\"My traitorous son has thee.\",\"Come to me, my allys and underlings.\",\"I might be trapped but not without power.\",\"Ages come, ages go. Ashmunrah remains.\",\"You will be history soon.\"]', '[\"death\",\"lifedrain\",\"paralyze\",\"invisible\"]', 0, 0, 'undead', '[{\"id\":2148,\"count\":\"100\",\"chance\":\"33000\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"33000\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"33000\"},{\"id\":2148,\"count\":\"4\",\"chance\":\"50000\"},{\"id\":\"7590\",\"count\":1,\"chance\":\"12005\"},{\"id\":\"2164\",\"count\":1,\"chance\":\"4662\"},{\"id\":\"2134\",\"count\":1,\"chance\":\"4196\"},{\"id\":\"2487\",\"count\":1,\"chance\":\"466\"},{\"id\":\"11207\",\"count\":1,\"chance\":\"175\"},{\"id\":\"2444\",\"count\":1,\"chance\":\"117\"},{\"id\":\"2140\",\"count\":1,\"chance\":\"117\"}]'),
(1479, 0, 'Askarak Demon', 0, 900, 1500, 1, 0, '[\"POWER TO THE ASKARAK!\",\"GREEN WILL RULE!\",\"GREEN IS MEAN!\",\"ONLY WE ARE TRUE DEMONS!\",\"RED IS MAD\"]', '[\"earth\",\"paralyze\",\"invisible\"]', 0, 0, 'venom', '[{\"id\":2114,\"count\":1,\"chance\":\"1052\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"50000\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"50000\"},{\"id\":2148,\"count\":\"35\",\"chance\":\"40000\"},{\"id\":2149,\"count\":\"4\",\"chance\":\"6250\"},{\"id\":2167,\"count\":1,\"chance\":\"961\"},{\"id\":2789,\"count\":\"5\",\"chance\":\"3846\"},{\"id\":5904,\"count\":1,\"chance\":\"102\"},{\"id\":7368,\"count\":\"5\",\"chance\":\"4761\"},{\"id\":7440,\"count\":1,\"chance\":\"431\"},{\"id\":7588,\"count\":1,\"chance\":\"5263\"},{\"id\":7589,\"count\":1,\"chance\":\"5263\"},{\"id\":7885,\"count\":1,\"chance\":\"123\"},{\"id\":8912,\"count\":1,\"chance\":\"512\"}]'),
(1480, 0, 'Askarak Lord', 0, 1200, 2100, 5, 0, '[\"WE RULE!\",\"RED IS MAD\"]', '[\"earth\",\"paralyze\",\"invisible\"]', 0, 0, 'venom', '[{\"id\":2148,\"count\":\"100\",\"chance\":\"50000\"},{\"id\":2148,\"count\":\"90\",\"chance\":\"50000\"},{\"id\":2149,\"count\":\"5\",\"chance\":\"5882\"},{\"id\":2152,\"count\":\"2\",\"chance\":\"35333\"},{\"id\":2167,\"count\":1,\"chance\":\"606\"},{\"id\":2789,\"count\":\"5\",\"chance\":\"5263\"},{\"id\":5904,\"count\":1,\"chance\":\"620\"},{\"id\":7368,\"count\":\"5\",\"chance\":\"70\"},{\"id\":7419,\"count\":1,\"chance\":\"30\"},{\"id\":7440,\"count\":1,\"chance\":\"750\"},{\"id\":7588,\"count\":1,\"chance\":\"6250\"},{\"id\":7589,\"count\":1,\"chance\":\"7692\"},{\"id\":7884,\"count\":1,\"chance\":\"70\"},{\"id\":8912,\"count\":1,\"chance\":\"1010\"}]'),
(1481, 0, 'Askarak Prince', 0, 1700, 2600, 10, 0, '[\"DEATH TO THE SHABRUAK!\"]', '[\"earth\",\"paralyze\",\"invisible\"]', 0, 0, 'venom', '[{\"id\":2148,\"count\":\"100\",\"chance\":\"50000\"},{\"id\":2148,\"count\":\"86\",\"chance\":\"50000\"},{\"id\":2149,\"count\":\"5\",\"chance\":\"12500\"},{\"id\":2152,\"count\":\"4\",\"chance\":\"35333\"},{\"id\":2165,\"count\":1,\"chance\":\"4545\"},{\"id\":2393,\"count\":1,\"chance\":\"320\"},{\"id\":2789,\"count\":\"5\",\"chance\":\"6666\"},{\"id\":5904,\"count\":1,\"chance\":\"740\"},{\"id\":7440,\"count\":1,\"chance\":\"1315\"},{\"id\":7588,\"count\":1,\"chance\":\"14285\"},{\"id\":7589,\"count\":1,\"chance\":\"14285\"},{\"id\":7884,\"count\":1,\"chance\":\"840\"},{\"id\":8912,\"count\":1,\"chance\":\"950\"},{\"id\":13530,\"count\":1,\"chance\":\"420\"}]'),
(1482, 0, 'Assassin', 450, 105, 175, 2, 0, '[\"Die!\",\"Feel the hand of death!\",\"You are on my deathlist!\"]', '[\"invisible\"]', 0, 1, 'blood', '[{\"id\":2148,\"count\":\"50\",\"chance\":\"83000\"},{\"id\":\"2050\",\"count\":\"2\",\"chance\":\"30000\"},{\"id\":2403,\"count\":1,\"chance\":\"9800\"},{\"id\":\"Throwing Star\",\"count\":\"14\",\"chance\":\"7000\"},{\"id\":7366,\"count\":\"7\",\"chance\":\"4200\"},{\"id\":2404,\"count\":1,\"chance\":\"4000\"},{\"id\":2457,\"count\":1,\"chance\":\"3230\"},{\"id\":2510,\"count\":1,\"chance\":\"1900\"},{\"id\":2513,\"count\":1,\"chance\":\"1600\"},{\"id\":2509,\"count\":1,\"chance\":\"970\"},{\"id\":3968,\"count\":1,\"chance\":\"480\"},{\"id\":3969,\"count\":1,\"chance\":\"240\"},{\"id\":2145,\"count\":1,\"chance\":\"220\"}]'),
(1483, 0, 'Avalanche', 0, 305, 550, 1, 0, '[\"You will pay for imprisoning me here.\",\"Puny warmblood.\"]', '[\"ice\",\"earth\",\"outfit\",\"drunk\",\"invisible\"]', 0, 0, 'undead', '[]'),
(1484, 0, 'Axeitus Headbanger', 0, 140, 365, 1, 0, '[\"Hicks!\",\"Stand still! Both of you! hicks\",\"This victory will earn me a casket of beer.\"]', '[\"outfit\",\"drunk\",\"invisible\"]', 0, 0, 'blood', '[]'),
(1485, 0, 'Azerus', 0, 6000, 26000, 50, 0, '[\"The ultimate will finally consume this unworthy existence!\",\"My masters and I will tear down barriers and join the ultimate in its realm!\",\"The power of the Yalahari will all be mine!\",\"He who has returned from beyond has taught me secrets you can\'t even grasp!\",\"You can\'t hope to penetrate my shields!\",\"Do you really think you could beat me?\"]', '[]', 0, 0, 'blood', '[]'),
(1486, 0, 'Azure Frog', 305, 20, 60, 1, 0, '[\"Ribbit! Ribbit!\",\"Ribbit!\"]', '[]', 0, 1, 'blood', '[{\"id\":2148,\"count\":\"10\",\"chance\":\"71230\"},{\"id\":3976,\"count\":1,\"chance\":\"8880\"}]'),
(1487, 0, 'Bad Dream', 0, 0, 7200, 1, 0, '[\"Ruu... mosha tak..\",\"Kororr roshakk!\",\"Grrrr!...\",\"Brrzfchh\"]', '[\"physical\",\"energy\",\"fire\",\"earth\",\"drown\",\"ice\",\"holy\",\"death\",\"lifedrain\",\"manadrain\",\"paralyze\",\"drunk\",\"outfit\",\"invisible\"]', 0, 0, 'blood', '[]'),
(1488, 0, 'Badger', 200, 5, 23, 1, 0, '[]', '[]', 1, 1, 'blood', '[{\"id\":8845,\"count\":1,\"chance\":\"40710\"},{\"id\":\"11216\",\"count\":1,\"chance\":\"10230\"},{\"id\":11213,\"count\":1,\"chance\":\"5130\"}]'),
(1489, 0, 'Bandit', 450, 65, 245, 1, 0, '[\"Your money or your life!\",\"Hand me your purse!\"]', '[]', 1, 1, 'blood', '[{\"id\":\"2148\",\"count\":\"30\",\"chance\":\"48956\"},{\"id\":\"2386\",\"count\":1,\"chance\":\"29905\"},{\"id\":\"2511\",\"count\":1,\"chance\":\"16794\"},{\"id\":\"2649\",\"count\":1,\"chance\":\"14967\"},{\"id\":\"2398\",\"count\":1,\"chance\":\"10342\"},{\"id\":\"2685\",\"count\":\"2\",\"chance\":\"7692\"},{\"id\":\"2458\",\"count\":1,\"chance\":\"4956\"},{\"id\":\"2465\",\"count\":1,\"chance\":\"2376\"},{\"id\":\"2459\",\"count\":1,\"chance\":\"544\"}]'),
(1490, 0, 'Bane Bringer', 0, 400, 2500, 20, 0, '[\"You shall not succeed!\",\"This time we will prevail!\"]', '[\"invisible\"]', 0, 0, 'undead', '[{\"id\":\"2250\",\"count\":\"96\",\"chance\":\"14285\"},{\"id\":12969,\"count\":1,\"chance\":\"100000\"}]'),
(1491, 0, 'Banshee', 0, 900, 1000, 1, 0, '[\"Dance for me your dance of death!\",\"Let the music play!\",\"I will mourn your death!\",\"Are you ready to rock?\",\"Feel my gentle kiss of death.\",\"That\'s what I call easy listening!\",\"IIIIEEEeeeeeehhhHHHH!\"]', '[\"death\",\"fire\",\"earth\",\"drown\",\"lifedrain\",\"paralyze\",\"invisible\"]', 0, 0, 'undead', '[{\"id\":2047,\"count\":1,\"chance\":\"70000\"},{\"id\":2148,\"count\":\"80\",\"chance\":\"30000\"},{\"id\":2170,\"count\":1,\"chance\":\"9400\"},{\"id\":2657,\"count\":1,\"chance\":\"6300\"},{\"id\":12402,\"count\":1,\"chance\":\"5000\"},{\"id\":11337,\"count\":1,\"chance\":\"4250\"},{\"id\":2144,\"count\":1,\"chance\":\"2130\"},{\"id\":2134,\"count\":1,\"chance\":\"1550\"},{\"id\":2411,\"count\":1,\"chance\":\"1550\"},{\"id\":2143,\"count\":1,\"chance\":\"1110\"},{\"id\":\"2372\",\"count\":1,\"chance\":\"970\"},{\"id\":2197,\"count\":1,\"chance\":\"820\"},{\"id\":7589,\"count\":1,\"chance\":\"770\"},{\"id\":2214,\"count\":1,\"chance\":\"750\"},{\"id\":2656,\"count\":1,\"chance\":\"700\"},{\"id\":2121,\"count\":1,\"chance\":\"560\"},{\"id\":\"2175\",\"count\":1,\"chance\":\"520\"},{\"id\":7884,\"count\":1,\"chance\":\"340\"},{\"id\":\"2124\",\"count\":1,\"chance\":\"180\"},{\"id\":2655,\"count\":1,\"chance\":\"150\"},{\"id\":2177,\"count\":1,\"chance\":\"100\"},{\"id\":13307,\"count\":1,\"chance\":\"40\"}]'),
(1492, 0, 'Barbaria', 0, 355, 345, 30, 0, '[\"To me, creatures of the wild!\",\"My instincts tell me about your cowardice.\"]', '[\"lifedrain\",\"paralyze\",\"drunk\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"1958\",\"count\":1,\"chance\":\"15000\"},{\"id\":\"2050\",\"count\":1,\"chance\":\"25000\"},{\"id\":2148,\"count\":\"35\",\"chance\":\"48000\"},{\"id\":2464,\"count\":1,\"chance\":\"11000\"},{\"id\":3965,\"count\":1,\"chance\":\"12500\"},{\"id\":7343,\"count\":1,\"chance\":\"1000\"}]'),
(1493, 0, 'Barbarian Bloodwalker', 590, 195, 305, 8, 1, '[\"YAAAHEEE!\",\"SLAUGHTER!\",\"CARNAGE!\",\"You can run but you can\'t hide\"]', '[]', 0, 1, 'blood', '[{\"id\":\"2148\",\"count\":\"12\",\"chance\":\"55130\"},{\"id\":\"2458\",\"count\":1,\"chance\":\"10639\"},{\"id\":\"2464\",\"count\":1,\"chance\":\"10270\"},{\"id\":\"2044\",\"count\":1,\"chance\":\"8135\"},{\"id\":\"2381\",\"count\":1,\"chance\":\"7013\"},{\"id\":\"2378\",\"count\":1,\"chance\":\"5934\"},{\"id\":\"2671\",\"count\":1,\"chance\":\"4955\"},{\"id\":\"7618\",\"count\":1,\"chance\":\"950\"},{\"id\":\"5911\",\"count\":1,\"chance\":\"504\"},{\"id\":\"3962\",\"count\":1,\"chance\":\"350\"},{\"id\":\"7290\",\"count\":1,\"chance\":\"317\"},{\"id\":\"7457\",\"count\":1,\"chance\":\"86\"}]'),
(1494, 0, 'Barbarian Brutetamer', 0, 90, 145, 1, 0, '[\"To me, creatures of the wild!\",\"My instincts tell me about your cowardice.\"]', '[\"lifedrain\",\"paralyze\",\"outfit\",\"invisible\",\"drunk\"]', 0, 0, 'blood', '[{\"id\":\"1958\",\"count\":1,\"chance\":\"5000\"},{\"id\":2148,\"count\":\"15\",\"chance\":\"58000\"},{\"id\":\"2401\",\"count\":1,\"chance\":\"6500\"},{\"id\":2464,\"count\":1,\"chance\":\"8900\"},{\"id\":2686,\"count\":\"2\",\"chance\":\"11000\"},{\"id\":3965,\"count\":1,\"chance\":\"5250\"},{\"id\":7343,\"count\":1,\"chance\":\"7540\"},{\"id\":7379,\"count\":1,\"chance\":\"380\"},{\"id\":7457,\"count\":1,\"chance\":\"160\"},{\"id\":7463,\"count\":1,\"chance\":\"160\"},{\"id\":7464,\"count\":1,\"chance\":\"90\"},{\"id\":7620,\"count\":1,\"chance\":\"630\"}]'),
(1495, 0, 'Barbarian Headsplitter', 450, 85, 100, 1, 0, '[\"I will regain my honor with your blood!\",\"Surrender is not option!\",\"Its you or me!\",\"Die! Die! Die!\"]', '[\"paralyze\",\"drunk\"]', 0, 1, 'blood', '[{\"id\":\"2148\",\"count\":\"30\",\"chance\":\"75228\"},{\"id\":\"2050\",\"count\":1,\"chance\":\"59812\"},{\"id\":\"2460\",\"count\":1,\"chance\":\"20170\"},{\"id\":\"2403\",\"count\":1,\"chance\":\"14928\"},{\"id\":\"2473\",\"count\":1,\"chance\":\"4960\"},{\"id\":\"2483\",\"count\":1,\"chance\":\"4046\"},{\"id\":\"2229\",\"count\":1,\"chance\":\"3194\"},{\"id\":\"5913\",\"count\":1,\"chance\":\"968\"},{\"id\":\"7618\",\"count\":1,\"chance\":\"531\"},{\"id\":\"2168\",\"count\":1,\"chance\":\"228\"},{\"id\":\"7461\",\"count\":1,\"chance\":\"112\"},{\"id\":\"7457\",\"count\":1,\"chance\":\"87\"}]'),
(1496, 0, 'Barbarian Skullhunter', 450, 85, 135, 1, 0, '[\"You will become my trophy.\",\"Fight harder, coward.\",\"Show that you are a worthy opponent.\"]', '[\"paralyze\"]', 0, 1, 'blood', '[{\"id\":\"2148\",\"count\":\"30\",\"chance\":\"74364\"},{\"id\":\"2050\",\"count\":1,\"chance\":\"60308\"},{\"id\":\"2460\",\"count\":1,\"chance\":\"19950\"},{\"id\":\"2403\",\"count\":1,\"chance\":\"15045\"},{\"id\":\"2473\",\"count\":1,\"chance\":\"7886\"},{\"id\":\"2483\",\"count\":1,\"chance\":\"4024\"},{\"id\":\"2229\",\"count\":1,\"chance\":\"3002\"},{\"id\":\"7618\",\"count\":1,\"chance\":\"914\"},{\"id\":\"5913\",\"count\":1,\"chance\":\"521\"},{\"id\":\"2168\",\"count\":1,\"chance\":\"240\"},{\"id\":\"7457\",\"count\":1,\"chance\":\"99\"},{\"id\":\"7462\",\"count\":1,\"chance\":\"95\"},{\"id\":\"7449\",\"count\":1,\"chance\":\"87\"}]'),
(1497, 0, 'Baron Brute', 0, 3000, 5025, 35, 0, '[\"Mash\'n!\"]', '[\"invisible\"]', 0, 0, 'blood', '[]'),
(1498, 0, 'Bat', 250, 10, 30, 1, 0, '[\"Flap! Flap!\"]', '[]', 1, 1, 'blood', '[{\"id\":5894,\"count\":1,\"chance\":\"1000\"}]'),
(1499, 0, 'Battlemaster Zunzu', 0, 2500, 4000, 100, 0, '[]', '[\"earth\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":2152,\"count\":\"3\",\"chance\":\"26800\"},{\"id\":5876,\"count\":1,\"chance\":\"1825\"},{\"id\":5881,\"count\":1,\"chance\":\"800\"},{\"id\":7588,\"count\":\"2\",\"chance\":\"2875\"},{\"id\":7591,\"count\":\"2\",\"chance\":\"2775\"},{\"id\":11206,\"count\":1,\"chance\":\"100000\"},{\"id\":11301,\"count\":1,\"chance\":\"1050\"},{\"id\":11303,\"count\":1,\"chance\":\"3150\"},{\"id\":11304,\"count\":1,\"chance\":\"2625\"},{\"id\":11330,\"count\":1,\"chance\":\"11250\"},{\"id\":11331,\"count\":1,\"chance\":\"100000\"}]'),
(1500, 0, 'Bazir', 0, 30000, 110000, 155, 1, '[\"COME HERE! FREE ITEMS FOR EVERYONE!\",\"BOW TO THE POWER OF THE RUTHLESS SEVEN!\",\"Slay your friends and I will spare you!\",\"DON\'T BE AFRAID! I AM COMING IN PEACE!\"]', '[\"energy\",\"fire\",\"earth\",\"lifedrain\",\"paralyze\",\"outfit\",\"drunk\",\"invisible\"]', 0, 0, 'fire', '[{\"id\":1982,\"count\":1,\"chance\":\"2600\"},{\"id\":2033,\"count\":1,\"chance\":\"7500\"},{\"id\":2112,\"count\":1,\"chance\":\"14500\"},{\"id\":2123,\"count\":1,\"chance\":\"3500\"},{\"id\":\"2124\",\"count\":1,\"chance\":\"5500\"},{\"id\":2125,\"count\":1,\"chance\":\"1500\"},{\"id\":\"2142\",\"count\":1,\"chance\":\"3500\"},{\"id\":2143,\"count\":\"15\",\"chance\":\"12500\"},{\"id\":2144,\"count\":\"15\",\"chance\":\"15000\"},{\"id\":2145,\"count\":\"5\",\"chance\":\"9500\"},{\"id\":2146,\"count\":\"10\",\"chance\":\"13500\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"99900\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"88800\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"77700\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"66600\"},{\"id\":2149,\"count\":\"10\",\"chance\":\"15500\"},{\"id\":2150,\"count\":\"20\",\"chance\":\"13500\"},{\"id\":2151,\"count\":\"7\",\"chance\":\"14000\"},{\"id\":2155,\"count\":1,\"chance\":\"1500\"},{\"id\":2158,\"count\":1,\"chance\":\"1500\"},{\"id\":\"2162\",\"count\":1,\"chance\":\"11500\"},{\"id\":2164,\"count\":1,\"chance\":\"5000\"},{\"id\":2165,\"count\":1,\"chance\":\"9500\"},{\"id\":2167,\"count\":1,\"chance\":\"13500\"},{\"id\":2170,\"count\":1,\"chance\":\"13000\"},{\"id\":2171,\"count\":1,\"chance\":\"4500\"},{\"id\":2174,\"count\":1,\"chance\":\"2500\"},{\"id\":2176,\"count\":1,\"chance\":\"12000\"},{\"id\":2177,\"count\":1,\"chance\":\"1000\"},{\"id\":\"2178\",\"count\":1,\"chance\":\"4000\"},{\"id\":2179,\"count\":1,\"chance\":\"8000\"},{\"id\":2182,\"count\":1,\"chance\":\"3500\"},{\"id\":2185,\"count\":1,\"chance\":\"3500\"},{\"id\":2186,\"count\":1,\"chance\":\"3500\"},{\"id\":2188,\"count\":1,\"chance\":\"2500\"},{\"id\":\"2192\",\"count\":1,\"chance\":\"2500\"},{\"id\":2195,\"count\":1,\"chance\":\"4000\"},{\"id\":2197,\"count\":1,\"chance\":\"4000\"},{\"id\":2200,\"count\":1,\"chance\":\"4500\"},{\"id\":2214,\"count\":1,\"chance\":\"13000\"},{\"id\":\"2231\",\"count\":1,\"chance\":\"9000\"},{\"id\":2377,\"count\":1,\"chance\":\"20000\"},{\"id\":2387,\"count\":1,\"chance\":\"20000\"},{\"id\":2393,\"count\":1,\"chance\":\"12500\"},{\"id\":2396,\"count\":1,\"chance\":\"7500\"},{\"id\":2402,\"count\":1,\"chance\":\"15500\"},{\"id\":2418,\"count\":1,\"chance\":\"4500\"},{\"id\":2421,\"count\":1,\"chance\":\"13500\"},{\"id\":2432,\"count\":1,\"chance\":\"17000\"},{\"id\":2434,\"count\":1,\"chance\":\"4500\"},{\"id\":2436,\"count\":1,\"chance\":\"5000\"},{\"id\":2462,\"count\":1,\"chance\":\"11000\"},{\"id\":2470,\"count\":1,\"chance\":\"5000\"},{\"id\":2472,\"count\":1,\"chance\":\"3000\"},{\"id\":\"2514\",\"count\":1,\"chance\":\"7500\"},{\"id\":2520,\"count\":1,\"chance\":\"15500\"},{\"id\":\"3955\",\"count\":1,\"chance\":\"100\"}]'),
(1501, 0, 'Bear', 300, 23, 80, 1, 0, '[\"Grrrr\",\"Groar\"]', '[]', 1, 1, 'blood', '[{\"id\":\"2666\",\"count\":1,\"chance\":\"39964\"},{\"id\":\"2671\",\"count\":1,\"chance\":\"19987\"},{\"id\":\"5896\",\"count\":1,\"chance\":\"1973\"},{\"id\":\"5902\",\"count\":1,\"chance\":\"480\"}]'),
(1502, 0, 'Behemoth', 0, 2500, 4000, 60, 1, '[\"You\'re so little!\",\"Human flesh - delicious!\",\"Crush the intruders!\"]', '[\"paralyze\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2148\",\"count\":\"200\",\"chance\":\"100000\"},{\"id\":\"2152\",\"count\":\"5\",\"chance\":\"60256\"},{\"id\":\"2666\",\"count\":1,\"chance\":\"29641\"},{\"id\":\"12403\",\"count\":1,\"chance\":\"14968\"},{\"id\":\"2387\",\"count\":1,\"chance\":\"10039\"},{\"id\":\"7368\",\"count\":\"5\",\"chance\":\"9988\"},{\"id\":\"2150\",\"count\":\"5\",\"chance\":\"6054\"},{\"id\":\"2377\",\"count\":1,\"chance\":\"6019\"},{\"id\":\"7591\",\"count\":1,\"chance\":\"5072\"},{\"id\":\"2489\",\"count\":1,\"chance\":\"4174\"},{\"id\":\"2463\",\"count\":1,\"chance\":\"4110\"},{\"id\":\"2125\",\"count\":1,\"chance\":\"2549\"},{\"id\":\"5893\",\"count\":1,\"chance\":\"999\"},{\"id\":\"2393\",\"count\":1,\"chance\":\"966\"},{\"id\":\"2174\",\"count\":1,\"chance\":\"830\"},{\"id\":\"2231\",\"count\":1,\"chance\":\"691\"},{\"id\":\"3456\",\"count\":1,\"chance\":\"619\"},{\"id\":\"5930\",\"count\":1,\"chance\":\"469\"},{\"id\":\"2645\",\"count\":1,\"chance\":\"434\"},{\"id\":\"2416\",\"count\":1,\"chance\":\"128\"},{\"id\":\"7396\",\"count\":1,\"chance\":\"114\"},{\"id\":\"2023\",\"count\":1,\"chance\":\"97\"},{\"id\":\"7413\",\"count\":1,\"chance\":\"75\"},{\"id\":\"2454\",\"count\":1,\"chance\":\"70\"}]'),
(1503, 0, 'Berserker Chicken', 220, 220, 465, 40, 1, '[\"Gokgoooook\",\"Cluck Cluck\",\"I will fill MY cushion with YOUR hair! CLUCK!\"]', '[\"lifedrain\",\"drown\"]', 0, 0, 'blood', '[{\"id\":2148,\"count\":\"100\",\"chance\":\"50000\"}]'),
(1504, 0, 'Betrayed Wraith', 0, 3500, 4200, 63, 1, '[\"Rrrah!\",\"Gnarr!\",\"Tcharrr!\"]', '[\"death\",\"fire\",\"energy\",\"earth\",\"lifedrain\",\"paralyze\",\"invisible\"]', 0, 0, 'undead', '[{\"id\":\"2148\",\"count\":\"200\",\"chance\":\"100000\"},{\"id\":\"2152\",\"count\":\"8\",\"chance\":\"100000\"},{\"id\":\"6558\",\"count\":1,\"chance\":\"65436\"},{\"id\":\"2547\",\"count\":\"15\",\"chance\":\"49940\"},{\"id\":\"6500\",\"count\":1,\"chance\":\"20426\"},{\"id\":\"11233\",\"count\":1,\"chance\":\"19612\"},{\"id\":\"8473\",\"count\":1,\"chance\":\"15177\"},{\"id\":\"7590\",\"count\":\"3\",\"chance\":\"14707\"},{\"id\":\"2145\",\"count\":\"4\",\"chance\":\"11835\"},{\"id\":\"7368\",\"count\":\"5\",\"chance\":\"9631\"},{\"id\":\"5944\",\"count\":1,\"chance\":\"9412\"},{\"id\":\"5022\",\"count\":\"2\",\"chance\":\"6374\"},{\"id\":\"7386\",\"count\":1,\"chance\":\"1503\"},{\"id\":\"6300\",\"count\":1,\"chance\":\"404\"},{\"id\":\"5741\",\"count\":1,\"chance\":\"377\"},{\"id\":\"5799\",\"count\":1,\"chance\":\"126\"},{\"id\":\"7416\",\"count\":1,\"chance\":\"99\"}]'),
(1505, 0, 'Big Boss Trolliver', 0, 105, 150, 1, 0, '[]', '[]', 0, 0, 'blood', '[{\"id\":2148,\"count\":\"57\",\"chance\":\"6000\"},{\"id\":2389,\"count\":\"2\",\"chance\":\"2000\"},{\"id\":2448,\"count\":1,\"chance\":\"5000\"},{\"id\":2666,\"count\":\"3\",\"chance\":\"1500\"}]'),
(1506, 0, 'Black Knight', 0, 1600, 1800, 15, 0, '[\"MINE!\",\"NO PRISONERS!\",\"NO MERCY!\",\"By Bolg\'s blood!\",\"You\'re no match for me!\"]', '[\"paralyze\",\"invisible\",\"earth\",\"ice\"]', 0, 0, 'blood', '[{\"id\":\"2148\",\"count\":\"143\",\"chance\":\"48586\"},{\"id\":\"2389\",\"count\":\"3\",\"chance\":\"29429\"},{\"id\":\"2691\",\"count\":\"2\",\"chance\":\"20600\"},{\"id\":\"2120\",\"count\":1,\"chance\":\"14426\"},{\"id\":\"2478\",\"count\":1,\"chance\":\"13070\"},{\"id\":\"2381\",\"count\":1,\"chance\":\"12522\"},{\"id\":\"2463\",\"count\":1,\"chance\":\"10935\"},{\"id\":\"3351\",\"count\":1,\"chance\":\"10531\"},{\"id\":\"2377\",\"count\":1,\"chance\":\"9608\"},{\"id\":\"2417\",\"count\":1,\"chance\":\"6896\"},{\"id\":\"2475\",\"count\":1,\"chance\":\"4703\"},{\"id\":\"2430\",\"count\":1,\"chance\":\"2654\"},{\"id\":\"2490\",\"count\":1,\"chance\":\"2424\"},{\"id\":\"2489\",\"count\":1,\"chance\":\"2020\"},{\"id\":\"2477\",\"count\":1,\"chance\":\"1039\"},{\"id\":\"2476\",\"count\":1,\"chance\":\"750\"},{\"id\":\"2133\",\"count\":1,\"chance\":\"750\"},{\"id\":\"7895\",\"count\":1,\"chance\":\"577\"},{\"id\":\"2195\",\"count\":1,\"chance\":\"404\"},{\"id\":\"2414\",\"count\":1,\"chance\":\"289\"},{\"id\":\"2114\",\"count\":1,\"chance\":\"115\"}]'),
(1507, 0, 'Black Sheep', 250, 0, 20, 1, 0, '[\"Maeh\"]', '[]', 1, 1, 'blood', '[{\"id\":2666,\"count\":\"5\",\"chance\":\"55380\"},{\"id\":12404,\"count\":1,\"chance\":\"620\"}]'),
(1508, 0, 'Blazing Fire Elemental', 0, 450, 650, 1, 0, '[]', '[\"fire\",\"invisible\"]', 0, 0, 'fire', '[{\"id\":2148,\"count\":\"100\",\"chance\":\"35000\"},{\"id\":2148,\"count\":\"25\",\"chance\":\"35000\"},{\"id\":10553,\"count\":1,\"chance\":\"6300\"},{\"id\":8299,\"count\":1,\"chance\":\"4000\"},{\"id\":7840,\"count\":\"3\",\"chance\":\"3600\"},{\"id\":\"13757\",\"count\":1,\"chance\":\"740\"}]'),
(1509, 0, 'Blightwalker', 0, 5850, 8900, 15, 0, '[\"I can see you decaying!\",\"Let me taste your mortality!\",\"Your lifeforce is waning!\"]', '[\"paralyze\",\"death\",\"earth\",\"invisible\"]', 0, 0, 'undead', '[{\"id\":2148,\"count\":\"100\",\"chance\":\"50000\"},{\"id\":2148,\"count\":\"97\",\"chance\":\"50000\"},{\"id\":2152,\"count\":\"5\",\"chance\":\"100000\"},{\"id\":2173,\"count\":1,\"chance\":\"120\"},{\"id\":2179,\"count\":1,\"chance\":\"1870\"},{\"id\":2183,\"count\":1,\"chance\":\"10000\"},{\"id\":2199,\"count\":1,\"chance\":\"2050\"},{\"id\":2260,\"count\":\"2\",\"chance\":\"26250\"},{\"id\":2418,\"count\":1,\"chance\":\"350\"},{\"id\":2436,\"count\":1,\"chance\":\"1520\"},{\"id\":2550,\"count\":1,\"chance\":\"3000\"},{\"id\":2694,\"count\":1,\"chance\":\"50000\"},{\"id\":5944,\"count\":1,\"chance\":\"23720\"},{\"id\":\"6300\",\"count\":1,\"chance\":\"1410\"},{\"id\":6500,\"count\":1,\"chance\":\"28000\"},{\"id\":7368,\"count\":\"10\",\"chance\":\"5900\"},{\"id\":7590,\"count\":\"3\",\"chance\":\"31360\"},{\"id\":\"7632\",\"count\":1,\"chance\":\"4450\"},{\"id\":\"7633\",\"count\":1,\"chance\":\"4450\"},{\"id\":7732,\"count\":1,\"chance\":\"4300\"},{\"id\":7884,\"count\":1,\"chance\":\"1050\"},{\"id\":7885,\"count\":1,\"chance\":\"2500\"},{\"id\":8473,\"count\":\"2\",\"chance\":\"14720\"},{\"id\":9971,\"count\":1,\"chance\":\"5270\"},{\"id\":10605,\"count\":1,\"chance\":\"15000\"}]'),
(1510, 0, 'Blistering Fire Elemental', 0, 1300, 1500, 5, 0, '[\"FCHHHRRR\"]', '[\"holy\",\"fire\",\"invisible\"]', 0, 0, 'fire', '[{\"id\":2148,\"count\":\"100\",\"chance\":\"44000\"},{\"id\":2148,\"count\":\"70\",\"chance\":\"44000\"},{\"id\":10553,\"count\":1,\"chance\":\"10000\"},{\"id\":8299,\"count\":1,\"chance\":\"9500\"},{\"id\":2147,\"count\":\"3\",\"chance\":\"5000\"},{\"id\":8921,\"count\":1,\"chance\":\"500\"},{\"id\":\"13757\",\"count\":1,\"chance\":\"500\"}]'),
(1511, 0, 'Blood Beast', 0, 1000, 1600, 1, 1, '[\"Rawrrr!\",\"*grlb*\",\"Roarr!\"]', '[\"paralyze\",\"lifedrain\",\"earth\",\"invisible\"]', 0, 0, 'venom', '[{\"id\":\"23549\",\"count\":1,\"chance\":\"16010\"},{\"id\":\"10557\",\"count\":1,\"chance\":\"5080\"},{\"id\":\"23517\",\"count\":1,\"chance\":\"3720\"},{\"id\":\"2148\",\"count\":\"100\",\"chance\":\"100000\"},{\"id\":\"2148\",\"count\":\"50\",\"chance\":\"60000\"},{\"id\":\"23565\",\"count\":1,\"chance\":\"20040\"},{\"id\":\"7588\",\"count\":1,\"chance\":\"7710\"},{\"id\":\"7366\",\"count\":\"5\",\"chance\":\"8290\"},{\"id\":\"23554\",\"count\":1,\"chance\":\"850\"},{\"id\":\"23550\",\"count\":1,\"chance\":\"810\"},{\"id\":\"23549\",\"count\":1,\"chance\":\"810\"},{\"id\":\"23551\",\"count\":1,\"chance\":\"1050\"},{\"id\":\"23529\",\"count\":1,\"chance\":\"780\"}]'),
(1512, 0, 'Blood Crab', 505, 160, 290, 1, 0, '[]', '[\"ice\",\"earth\",\"drown\"]', 1, 1, 'blood', '[{\"id\":\"2148\",\"count\":\"20\",\"chance\":\"85818\"},{\"id\":\"2667\",\"count\":1,\"chance\":\"14803\"},{\"id\":\"10550\",\"count\":1,\"chance\":\"6053\"},{\"id\":\"2464\",\"count\":1,\"chance\":\"5122\"},{\"id\":\"2478\",\"count\":1,\"chance\":\"2143\"},{\"id\":\"2143\",\"count\":1,\"chance\":\"517\"}]'),
(1513, 0, 'Blood Hand', 0, 750, 700, 1, 0, '[\"Blood for the dark god!\",\"Die, filth!\"]', '[\"invisible\",\"earth\",\"drown\"]', 0, 0, 'blood', '[{\"id\":2148,\"count\":\"100\",\"chance\":\"50000\"},{\"id\":2148,\"count\":\"30\",\"chance\":\"50000\"},{\"id\":2185,\"count\":1,\"chance\":\"3000\"},{\"id\":2195,\"count\":1,\"chance\":\"210\"},{\"id\":2436,\"count\":1,\"chance\":\"130\"},{\"id\":2663,\"count\":1,\"chance\":\"790\"},{\"id\":5909,\"count\":1,\"chance\":\"840\"},{\"id\":5911,\"count\":1,\"chance\":\"500\"},{\"id\":7456,\"count\":1,\"chance\":\"10\"},{\"id\":7589,\"count\":1,\"chance\":\"5590\"},{\"id\":8900,\"count\":1,\"chance\":\"790\"},{\"id\":11237,\"count\":1,\"chance\":\"9340\"},{\"id\":15565,\"count\":1,\"chance\":\"710\"},{\"id\":21242,\"count\":1,\"chance\":\"10680\"},{\"id\":21243,\"count\":1,\"chance\":\"7950\"},{\"id\":21245,\"count\":1,\"chance\":\"15460\"},{\"id\":21246,\"count\":1,\"chance\":\"8820\"},{\"id\":21247,\"count\":1,\"chance\":\"6120\"}]'),
(1514, 0, 'Blood Priest', 0, 900, 820, 1, 0, '[\"Blood for the dark god!\"]', '[\"invisible\",\"earth\",\"drown\"]', 0, 0, 'blood', '[{\"id\":2147,\"count\":\"2\",\"chance\":\"3510\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"50000\"},{\"id\":2148,\"count\":\"71\",\"chance\":\"50000\"},{\"id\":2195,\"count\":1,\"chance\":\"120\"},{\"id\":2436,\"count\":1,\"chance\":\"180\"},{\"id\":2663,\"count\":1,\"chance\":\"2170\"},{\"id\":5909,\"count\":1,\"chance\":\"3040\"},{\"id\":5911,\"count\":1,\"chance\":\"640\"},{\"id\":7589,\"count\":1,\"chance\":\"6000\"},{\"id\":8901,\"count\":1,\"chance\":\"290\"},{\"id\":8902,\"count\":1,\"chance\":\"180\"},{\"id\":8910,\"count\":1,\"chance\":\"470\"},{\"id\":11237,\"count\":1,\"chance\":\"13550\"},{\"id\":15565,\"count\":1,\"chance\":\"880\"},{\"id\":21242,\"count\":1,\"chance\":\"14410\"},{\"id\":21243,\"count\":1,\"chance\":\"9270\"},{\"id\":21245,\"count\":1,\"chance\":\"14460\"},{\"id\":21246,\"count\":1,\"chance\":\"14660\"},{\"id\":21247,\"count\":1,\"chance\":\"7770\"}]'),
(1515, 0, 'Bloodpaw', 0, 50, 100, 1, 0, '[]', '[\"outfit\",\"drunk\",\"invisible\"]', 0, 0, 'blood', '[]'),
(1516, 0, 'Butterfly', 0, 0, 2, 50, 0, '[]', '[]', 0, 0, 'venom', '[]'),
(1517, 0, 'Blue Djinn', 0, 215, 330, 1, 0, '[\"Simsalabim\",\"Feel the power of my magic, tiny mortal!\",\"Be careful what you wish for.\",\"Wishes can come true.\"]', '[\"paralyze\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":2148,\"count\":\"100\",\"chance\":\"43000\"},{\"id\":2148,\"count\":\"15\",\"chance\":\"43000\"},{\"id\":\"2684\",\"count\":1,\"chance\":\"23480\"},{\"id\":7378,\"count\":\"2\",\"chance\":\"4500\"},{\"id\":2146,\"count\":\"4\",\"chance\":\"2560\"},{\"id\":\"1963\",\"count\":1,\"chance\":\"2450\"},{\"id\":5912,\"count\":1,\"chance\":\"1920\"},{\"id\":12412,\"count\":1,\"chance\":\"1890\"},{\"id\":7620,\"count\":1,\"chance\":\"860\"},{\"id\":2063,\"count\":1,\"chance\":\"730\"},{\"id\":2745,\"count\":1,\"chance\":\"440\"},{\"id\":2663,\"count\":1,\"chance\":\"70\"}]'),
(1518, 0, 'Boar', 465, 60, 198, 95, 0, '[\"Grunt! Grunt!\",\"Grunt\"]', '[]', 1, 1, 'blood', '[{\"id\":\"2148\",\"count\":\"20\",\"chance\":\"25313\"},{\"id\":\"13297\",\"count\":\"2\",\"chance\":\"19949\"}]'),
(1519, 0, 'Bog Frog', 305, 0, 25, 1, 0, '[]', '[]', 0, 0, 'blood', '[]'),
(1520, 0, 'Bog Raider', 0, 800, 1300, 15, 0, '[\"Tchhh!\",\"Slurp!\"]', '[\"paralyze\",\"invisible\"]', 0, 0, 'venom', '[{\"id\":2148,\"count\":\"100\",\"chance\":\"50750\"},{\"id\":2148,\"count\":\"5\",\"chance\":\"50750\"},{\"id\":10584,\"count\":1,\"chance\":\"9870\"},{\"id\":7591,\"count\":1,\"chance\":\"2030\"},{\"id\":2647,\"count\":1,\"chance\":\"2020\"},{\"id\":8472,\"count\":1,\"chance\":\"2000\"},{\"id\":8912,\"count\":1,\"chance\":\"1030\"},{\"id\":8473,\"count\":1,\"chance\":\"770\"},{\"id\":8872,\"count\":1,\"chance\":\"590\"},{\"id\":8891,\"count\":1,\"chance\":\"140\"}]'),
(1521, 0, 'Bonebeast', 0, 580, 515, 1, 0, '[\"Cccchhhhhhhhh!\",\"Knooorrrrr!\"]', '[\"death\",\"earth\",\"drown\",\"lifedrain\",\"paralyze\",\"invisible\",\"drunk\"]', 0, 0, 'undead', '[{\"id\":\"2230\",\"count\":1,\"chance\":\"49750\"},{\"id\":2148,\"count\":\"90\",\"chance\":\"30000\"},{\"id\":\"2229\",\"count\":1,\"chance\":\"20000\"},{\"id\":11194,\"count\":1,\"chance\":\"9980\"},{\"id\":2463,\"count\":1,\"chance\":\"8000\"},{\"id\":2449,\"count\":1,\"chance\":\"4950\"},{\"id\":2541,\"count\":1,\"chance\":\"2000\"},{\"id\":2796,\"count\":1,\"chance\":\"1450\"},{\"id\":5925,\"count\":1,\"chance\":\"1000\"},{\"id\":7618,\"count\":1,\"chance\":\"540\"},{\"id\":11161,\"count\":1,\"chance\":\"120\"}]'),
(1522, 0, 'Bonelord', 0, 170, 260, 1, 0, '[\"Eye for eye!\",\"Here\'s looking at you!\",\"Let me take a look at you!\",\"You\'ve got the look!\",\"I\'ve got to look!\"]', '[\"invisible\",\"earth\",\"lifedrain\"]', 0, 0, 'venom', '[{\"id\":2148,\"count\":\"48\",\"chance\":\"99000\"},{\"id\":2397,\"count\":1,\"chance\":\"9000\"},{\"id\":2394,\"count\":1,\"chance\":\"7000\"},{\"id\":12468,\"count\":1,\"chance\":\"5000\"},{\"id\":\"2175\",\"count\":1,\"chance\":\"5000\"},{\"id\":2509,\"count\":1,\"chance\":\"4000\"},{\"id\":2377,\"count\":1,\"chance\":\"3950\"},{\"id\":5898,\"count\":1,\"chance\":\"1000\"},{\"id\":2181,\"count\":1,\"chance\":\"510\"},{\"id\":7620,\"count\":1,\"chance\":\"300\"},{\"id\":2518,\"count\":1,\"chance\":\"110\"}]'),
(1523, 0, 'Bones', 0, 3750, 9500, 40, 0, '[\"Your new name is breakfast.\",\"Keep that dog away!\",\"Out Fluffy! Out! Bad dog!\"]', '[\"drunk\",\"invisible\"]', 0, 0, 'undead', '[{\"id\":2148,\"count\":\"100\",\"chance\":\"100000\"},{\"id\":2148,\"count\":\"90\",\"chance\":\"50000\"},{\"id\":2207,\"count\":1,\"chance\":\"10000\"},{\"id\":2413,\"count\":1,\"chance\":\"4000\"},{\"id\":2472,\"count\":1,\"chance\":\"2000\"},{\"id\":4851,\"count\":1,\"chance\":\"800\"},{\"id\":5741,\"count\":1,\"chance\":\"50000\"},{\"id\":5944,\"count\":1,\"chance\":\"10000\"},{\"id\":\"6300\",\"count\":1,\"chance\":\"4000\"},{\"id\":6500,\"count\":1,\"chance\":\"1538\"},{\"id\":\"6570\",\"count\":\"3\",\"chance\":\"5538\"},{\"id\":\"6571\",\"count\":1,\"chance\":\"1538\"},{\"id\":7430,\"count\":1,\"chance\":\"50000\"}]'),
(1524, 0, 'Boogey', 0, 475, 930, 90, 0, '[\"Since you didn\'t eat your spinach Bogey comes to get you!\",\"Too bad you did not eat your lunch, now I have to punish you!\",\"Even if you beat me, I\'ll hide in your closet until you one day drop your guard!\",\"You better had believe in me!\",\"I\'ll take you into the darkness ... forever!\"]', '[\"death\",\"drown\",\"lifedrain\",\"invisible\"]', 0, 0, 'undead', '[]'),
(1525, 0, 'Bovinus', 0, 60, 150, 1, 0, '[]', '[\"outfit\",\"drunk\",\"invisible\"]', 0, 0, 'blood', '[]'),
(1526, 0, 'Braindeath', 0, 985, 1225, 1, 1, '[\"You have disturbed my thoughts!\",\"Let me turn you into something more useful!\",\"Let me taste your brain!\",\"You will be punished!\"]', '[\"earth\",\"death\",\"invisible\"]', 0, 0, 'venom', '[{\"id\":\"2148\",\"count\":\"90\",\"chance\":\"99448\"},{\"id\":\"2450\",\"count\":1,\"chance\":\"14985\"},{\"id\":\"7364\",\"count\":\"4\",\"chance\":\"9593\"},{\"id\":\"2509\",\"count\":1,\"chance\":\"5899\"},{\"id\":\"10580\",\"count\":1,\"chance\":\"5041\"},{\"id\":\"5898\",\"count\":1,\"chance\":\"2967\"},{\"id\":\"2423\",\"count\":1,\"chance\":\"1965\"},{\"id\":\"7407\",\"count\":1,\"chance\":\"1446\"},{\"id\":\"2175\",\"count\":1,\"chance\":\"958\"},{\"id\":\"7452\",\"count\":1,\"chance\":\"178\"},{\"id\":\"2518\",\"count\":1,\"chance\":\"102\"},{\"id\":\"3972\",\"count\":1,\"chance\":\"99\"}]'),
(1527, 0, 'Brimstone Bug', 0, 900, 1300, 1, 0, '[\"Chrrr!\"]', '[\"lifedrain\",\"death\",\"earth\",\"invisible\"]', 0, 0, 'venom', '[{\"id\":2148,\"count\":\"100\",\"chance\":\"50000\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"50000\"},{\"id\":2149,\"count\":\"4\",\"chance\":\"2702\"},{\"id\":2165,\"count\":1,\"chance\":\"892\"},{\"id\":2171,\"count\":1,\"chance\":\"110\"},{\"id\":5904,\"count\":1,\"chance\":\"1639\"},{\"id\":7588,\"count\":1,\"chance\":\"9003\"},{\"id\":7589,\"count\":1,\"chance\":\"9025\"},{\"id\":10557,\"count\":1,\"chance\":\"50000\"},{\"id\":11222,\"count\":1,\"chance\":\"20000\"},{\"id\":11232,\"count\":1,\"chance\":\"14970\"},{\"id\":12658,\"count\":1,\"chance\":\"5710\"},{\"id\":12659,\"count\":1,\"chance\":\"10000\"}]'),
(1528, 0, 'Horse', 0, 0, 75, 1, 0, '[\"Weeeeheeeeeee\",\"*snort*\",\"*Weeeeheeeeaaa*\"]', '[]', 0, 0, 'blood', '[]'),
(1529, 0, 'Brutus Bloodbeard', 0, 795, 1555, 10, 0, '[]', '[\"invisible\"]', 0, 0, 'blood', '[{\"id\":2148,\"count\":\"40\",\"chance\":\"100000\"},{\"id\":2320,\"count\":1,\"chance\":\"100000\"},{\"id\":2463,\"count\":1,\"chance\":\"4000\"},{\"id\":2476,\"count\":1,\"chance\":\"1200\"},{\"id\":6099,\"count\":1,\"chance\":\"100000\"}]'),
(1530, 0, 'Bug', 250, 18, 29, 1, 0, '[]', '[]', 1, 1, 'venom', '[{\"id\":2148,\"count\":\"6\",\"chance\":\"50000\"},{\"id\":\"2679\",\"count\":\"3\",\"chance\":\"3000\"}]'),
(1531, 0, 'Calamary', 0, 0, 75, 1, 0, '[\"Bubble!\",\"Bobble!\"]', '[\"ice\",\"paralyze\",\"drown\",\"fire\"]', 0, 0, 'undead', '[{\"id\":2670,\"count\":\"2\",\"chance\":\"12270\"}]'),
(1532, 0, 'Captain Jones', 0, 620, 555, 1, 0, '[]', '[\"physical\",\"paralyze\",\"lifedrain\"]', 0, 0, 'undead', '[{\"id\":2148,\"count\":\"100\",\"chance\":\"50000\"},{\"id\":2148,\"count\":\"50\",\"chance\":\"50000\"},{\"id\":2165,\"count\":1,\"chance\":\"20000\"},{\"id\":\"2488\",\"count\":1,\"chance\":\"5000\"},{\"id\":8871,\"count\":1,\"chance\":\"5000\"},{\"id\":2655,\"count\":1,\"chance\":\"5000\"},{\"id\":2383,\"count\":1,\"chance\":\"5000\"}]'),
(1533, 0, 'Carniphila', 0, 150, 255, 1, 0, '[]', '[\"earth\",\"invisible\"]', 0, 0, 'venom', '[{\"id\":2148,\"count\":\"40\",\"chance\":\"87000\"},{\"id\":2792,\"count\":1,\"chance\":\"8000\"},{\"id\":11217,\"count\":1,\"chance\":\"4000\"},{\"id\":2804,\"count\":1,\"chance\":\"1000\"},{\"id\":2686,\"count\":1,\"chance\":\"1000\"},{\"id\":2802,\"count\":\"2\",\"chance\":\"500\"},{\"id\":7732,\"count\":1,\"chance\":\"500\"},{\"id\":13298,\"count\":1,\"chance\":\"150\"}]'),
(1534, 0, 'Carrion Worm', 380, 70, 145, 1, 0, '[]', '[]', 0, 1, 'blood', '[{\"id\":2148,\"count\":\"45\",\"chance\":\"50000\"},{\"id\":2666,\"count\":\"2\",\"chance\":\"9460\"},{\"id\":3976,\"count\":\"2\",\"chance\":\"2100\"},{\"id\":11192,\"count\":1,\"chance\":\"10000\"},{\"id\":\"13757\",\"count\":1,\"chance\":\"210\"}]'),
(1535, 0, 'Cat', 220, 0, 20, 1, 0, '[\"Mew!\",\"Meow!\",\"Meow meow!\"]', '[]', 1, 1, 'blood', '[]'),
(1536, 0, 'Cave Rat', 250, 10, 30, 1, 0, '[\"Meeeeep!\",\"Meep!\"]', '[]', 1, 1, 'blood', '[{\"id\":2148,\"count\":\"2\",\"chance\":\"85000\"},{\"id\":\"2696\",\"count\":1,\"chance\":\"30000\"},{\"id\":3976,\"count\":\"2\",\"chance\":\"10000\"},{\"id\":2687,\"count\":1,\"chance\":\"940\"}]'),
(1537, 0, 'Centipede', 335, 34, 70, 1, 0, '[]', '[\"earth\"]', 1, 0, 'venom', '[{\"id\":2148,\"count\":\"15\",\"chance\":\"80000\"},{\"id\":11218,\"count\":1,\"chance\":\"10300\"}]'),
(1538, 0, 'Chakoya Toolshaper', 0, 40, 80, 1, 0, '[\"Chikuva!!\",\"Jinuma jamjam!\",\"Suvituka siq chuqua!\",\"Kiyosa sipaju!\"]', '[\"ice\"]', 0, 0, 'blood', '[{\"id\":\"2148\",\"count\":\"20\",\"chance\":\"78354\"},{\"id\":\"2667\",\"count\":\"2\",\"chance\":\"25021\"},{\"id\":\"2398\",\"count\":1,\"chance\":\"5209\"},{\"id\":\"3456\",\"count\":1,\"chance\":\"1016\"},{\"id\":\"2541\",\"count\":1,\"chance\":\"874\"},{\"id\":\"22727\",\"count\":1,\"chance\":\"461\"},{\"id\":\"7441\",\"count\":1,\"chance\":\"404\"},{\"id\":\"7381\",\"count\":1,\"chance\":\"179\"},{\"id\":\"7158\",\"count\":1,\"chance\":\"122\"},{\"id\":\"7159\",\"count\":1,\"chance\":\"75\"},{\"id\":\"2669\",\"count\":1,\"chance\":\"66\"}]'),
(1539, 0, 'Chakoya Tribewarden', 305, 40, 68, 1, 0, '[\"Quisavu tukavi!\",\"Si siyoqua jamjam!\",\"Achuq! jinuma!\",\"Si ji jusipa!\"]', '[\"ice\"]', 0, 1, 'blood', '[{\"id\":2148,\"count\":\"30\",\"chance\":\"60000\"},{\"id\":2406,\"count\":1,\"chance\":\"4680\"},{\"id\":2541,\"count\":1,\"chance\":\"1000\"},{\"id\":\"2667\",\"count\":1,\"chance\":\"20000\"},{\"id\":2669,\"count\":1,\"chance\":\"90\"},{\"id\":7158,\"count\":1,\"chance\":\"130\"},{\"id\":7159,\"count\":1,\"chance\":\"190\"},{\"id\":7381,\"count\":1,\"chance\":\"300\"}]'),
(1540, 0, 'Chakoya Windcaller', 305, 48, 84, 1, 0, '[\"Mupi! Si siyoqua jinuma!\",\"Siqsiq ji jusipa!\",\"Jagura taluka taqua!\",\"Quatu nguraka!\"]', '[\"ice\"]', 0, 1, 'blood', '[{\"id\":2148,\"count\":\"26\",\"chance\":\"50000\"},{\"id\":2460,\"count\":1,\"chance\":\"3250\"},{\"id\":2541,\"count\":1,\"chance\":\"950\"},{\"id\":\"2667\",\"count\":\"3\",\"chance\":\"29000\"},{\"id\":2669,\"count\":1,\"chance\":\"60\"},{\"id\":7158,\"count\":1,\"chance\":\"60\"},{\"id\":7159,\"count\":1,\"chance\":\"60\"}]');
INSERT INTO `myaac_monsters` (`id`, `hidden`, `name`, `mana`, `exp`, `health`, `speed_lvl`, `use_haste`, `voices`, `immunities`, `summonable`, `convinceable`, `race`, `loot`) VALUES
(1541, 0, 'Charged Energy Elemental', 0, 450, 500, 25, 0, '[]', '[\"energy\",\"fire\",\"ice\"]', 0, 0, 'energy', '[{\"id\":2148,\"count\":\"100\",\"chance\":\"50000\"},{\"id\":2148,\"count\":\"22\",\"chance\":\"50000\"},{\"id\":7838,\"count\":\"3\",\"chance\":\"6250\"},{\"id\":8303,\"count\":1,\"chance\":\"2063\"}]'),
(1542, 0, 'Chicken', 220, 0, 15, 1, 0, '[\"Gokgoooook\",\"Cluck Cluck\"]', '[]', 1, 1, 'blood', '[{\"id\":5890,\"count\":1,\"chance\":\"20000\"},{\"id\":3976,\"count\":1,\"chance\":\"10000\"},{\"id\":2666,\"count\":\"2\",\"chance\":\"2120\"},{\"id\":\"2695\",\"count\":1,\"chance\":\"1000\"}]'),
(1543, 0, 'Chizzoron The Distorter', 0, 4000, 16000, 20, 0, '[\"Humanzzz! Leave Zzaion at onzzzze!\",\"I pray to my mazzterzz, the mighty dragonzzz!\",\"You are not worzzy to touch zzizz zzacred ground!\"]', '[\"earth\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":2148,\"count\":\"100\",\"chance\":\"69825\"},{\"id\":2148,\"count\":\"10\",\"chance\":\"69825\"},{\"id\":2149,\"count\":1,\"chance\":\"5750\"},{\"id\":2155,\"count\":1,\"chance\":\"16300\"},{\"id\":\"2169\",\"count\":1,\"chance\":\"11025\"},{\"id\":2492,\"count\":1,\"chance\":\"5750\"},{\"id\":5881,\"count\":1,\"chance\":\"100000\"},{\"id\":7591,\"count\":1,\"chance\":\"5750\"},{\"id\":9971,\"count\":\"2\",\"chance\":\"71550\"}]'),
(1544, 0, 'Choking Fear', 0, 4700, 5800, 20, 0, '[\"Ah, sweet air... don\'t you miss it?\",\"Murr tat muuza!\",\"kchh\"]', '[\"earth\",\"fire\",\"invisible\"]', 0, 0, 'undead', '[{\"id\":2148,\"count\":\"100\",\"chance\":\"100000\"},{\"id\":2152,\"count\":\"8\",\"chance\":\"100000\"},{\"id\":2167,\"count\":1,\"chance\":\"3000\"},{\"id\":2168,\"count\":1,\"chance\":\"4200\"},{\"id\":2214,\"count\":1,\"chance\":\"3000\"},{\"id\":2515,\"count\":1,\"chance\":\"1540\"},{\"id\":3962,\"count\":1,\"chance\":\"3290\"},{\"id\":5913,\"count\":1,\"chance\":\"6000\"},{\"id\":5914,\"count\":1,\"chance\":\"3500\"},{\"id\":7590,\"count\":\"3\",\"chance\":\"20000\"},{\"id\":7886,\"count\":1,\"chance\":\"720\"},{\"id\":8472,\"count\":\"3\",\"chance\":\"20000\"},{\"id\":8473,\"count\":\"3\",\"chance\":\"19000\"},{\"id\":8902,\"count\":1,\"chance\":\"720\"},{\"id\":8910,\"count\":1,\"chance\":\"720\"},{\"id\":8912,\"count\":1,\"chance\":\"510\"},{\"id\":18415,\"count\":1,\"chance\":\"1540\"},{\"id\":18417,\"count\":\"2\",\"chance\":\"52500\"},{\"id\":18418,\"count\":\"3\",\"chance\":\"10000\"},{\"id\":22396,\"count\":1,\"chance\":\"620\"},{\"id\":22536,\"count\":1,\"chance\":\"14180\"},{\"id\":22540,\"count\":1,\"chance\":\"14180\"}]'),
(1545, 0, 'Clay Guardian', 0, 400, 625, 1, 0, '[]', '[\"earth\",\"invisible\"]', 0, 0, 'undead', '[{\"id\":1294,\"count\":\"10\",\"chance\":\"10000\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"50000\"},{\"id\":2148,\"count\":\"63\",\"chance\":\"50000\"},{\"id\":2260,\"count\":1,\"chance\":\"25000\"},{\"id\":7850,\"count\":\"8\",\"chance\":\"5555\"},{\"id\":9970,\"count\":1,\"chance\":\"320\"},{\"id\":11222,\"count\":1,\"chance\":\"25000\"},{\"id\":11339,\"count\":1,\"chance\":\"1100\"}]'),
(1546, 0, 'Cliff Strider', 0, 5700, 9400, 13, 0, '[\"Knorrrr\"]', '[\"paralyze\",\"earth\",\"energy\",\"invisible\"]', 0, 0, 'undead', '[{\"id\":\"2148\",\"count\":\"196\",\"chance\":\"100000\"},{\"id\":\"2152\",\"count\":\"10\",\"chance\":\"100000\"},{\"id\":\"7590\",\"count\":\"4\",\"chance\":\"33641\"},{\"id\":\"8473\",\"count\":\"2\",\"chance\":\"24406\"},{\"id\":\"18429\",\"count\":\"2\",\"chance\":\"17942\"},{\"id\":\"5944\",\"count\":1,\"chance\":\"16887\"},{\"id\":\"18427\",\"count\":1,\"chance\":\"15765\"},{\"id\":\"18428\",\"count\":1,\"chance\":\"15369\"},{\"id\":\"5880\",\"count\":1,\"chance\":\"13918\"},{\"id\":\"11227\",\"count\":1,\"chance\":\"12071\"},{\"id\":\"2144\",\"count\":1,\"chance\":\"9301\"},{\"id\":\"18419\",\"count\":1,\"chance\":\"9301\"},{\"id\":\"18435\",\"count\":\"8\",\"chance\":\"9169\"},{\"id\":\"2143\",\"count\":\"3\",\"chance\":\"8971\"},{\"id\":\"18418\",\"count\":\"2\",\"chance\":\"8905\"},{\"id\":\"18413\",\"count\":1,\"chance\":\"6728\"},{\"id\":\"2156\",\"count\":1,\"chance\":\"5739\"},{\"id\":\"9942\",\"count\":1,\"chance\":\"2704\"},{\"id\":\"18390\",\"count\":1,\"chance\":\"1913\"},{\"id\":\"7437\",\"count\":1,\"chance\":\"1517\"},{\"id\":\"5904\",\"count\":1,\"chance\":\"1451\"},{\"id\":\"18412\",\"count\":1,\"chance\":\"1187\"},{\"id\":\"7452\",\"count\":1,\"chance\":\"1055\"},{\"id\":\"18453\",\"count\":1,\"chance\":\"923\"},{\"id\":\"2477\",\"count\":1,\"chance\":\"858\"},{\"id\":\"9980\",\"count\":1,\"chance\":\"792\"},{\"id\":\"2158\",\"count\":1,\"chance\":\"726\"},{\"id\":\"2393\",\"count\":1,\"chance\":\"660\"},{\"id\":\"18450\",\"count\":1,\"chance\":\"594\"},{\"id\":\"2497\",\"count\":1,\"chance\":\"528\"},{\"id\":\"2487\",\"count\":1,\"chance\":\"462\"},{\"id\":\"2645\",\"count\":1,\"chance\":\"66\"}]'),
(1547, 0, 'Cobra', 275, 30, 65, 1, 0, '[\"Zzzzzz\",\"Fsssss\"]', '[\"drunk\",\"earth\"]', 1, 0, 'blood', '[{\"id\":10551,\"count\":1,\"chance\":\"5000\"}]'),
(1548, 0, 'Cockroach', 0, 0, 1, 1, 0, '[]', '[]', 0, 0, 'venom', '[{\"id\":8710,\"count\":1,\"chance\":\"100000\"}]'),
(1549, 0, 'Coldheart', 0, 3500, 7000, 1, 0, '[]', '[\"paralyze\",\"invisible\",\"ice\",\"fire\"]', 0, 0, 'undead', '[]'),
(1550, 0, 'Colerian the Barbarian', 0, 90, 265, 1, 0, '[\"Flee, coward!\",\"You will lose!\",\"Yeehaawh\"]', '[\"outfit\",\"drunk\",\"invisible\"]', 0, 0, 'blood', '[]'),
(1551, 0, 'Coral Frog', 305, 20, 60, 1, 0, '[\"Ribbit!\",\"Ribbit! Ribbit!\"]', '[]', 1, 0, 'blood', '[{\"id\":2148,\"count\":\"10\",\"chance\":\"76780\"},{\"id\":3976,\"count\":1,\"chance\":\"13510\"}]'),
(1552, 0, 'Corym Charlatan', 490, 150, 250, 1, 0, '[\"Mehehe!\",\"Beware! Me hexing you!\"]', '[]', 1, 1, 'blood', '[{\"id\":2148,\"count\":\"35\",\"chance\":\"50000\"},{\"id\":\"2696\",\"count\":1,\"chance\":\"10000\"},{\"id\":20089,\"count\":1,\"chance\":\"7692\"},{\"id\":20090,\"count\":1,\"chance\":\"492\"},{\"id\":20092,\"count\":1,\"chance\":\"909\"},{\"id\":20093,\"count\":1,\"chance\":\"854\"},{\"id\":20097,\"count\":1,\"chance\":\"5882\"},{\"id\":20098,\"count\":1,\"chance\":\"518\"},{\"id\":20099,\"count\":1,\"chance\":\"7142\"},{\"id\":20100,\"count\":1,\"chance\":\"12500\"},{\"id\":20101,\"count\":1,\"chance\":\"14285\"},{\"id\":20126,\"count\":1,\"chance\":\"537\"}]'),
(1553, 0, 'Corym Skirmisher', 695, 260, 450, 1, 0, '[\"Squeak! Squeak!\",\"<sniff><sniff><sniff>\"]', '[\"paralyze\",\"invisible\"]', 0, 1, 'blood', '[{\"id\":2148,\"count\":\"45\",\"chance\":\"50000\"},{\"id\":\"2696\",\"count\":1,\"chance\":\"20000\"},{\"id\":20089,\"count\":1,\"chance\":\"7692\"},{\"id\":20090,\"count\":1,\"chance\":\"645\"},{\"id\":20092,\"count\":1,\"chance\":\"2702\"},{\"id\":20093,\"count\":1,\"chance\":\"2941\"},{\"id\":20097,\"count\":1,\"chance\":\"8333\"},{\"id\":20098,\"count\":1,\"chance\":\"854\"},{\"id\":20099,\"count\":1,\"chance\":\"9090\"},{\"id\":20100,\"count\":1,\"chance\":\"14285\"},{\"id\":20101,\"count\":1,\"chance\":\"16666\"},{\"id\":20105,\"count\":1,\"chance\":\"12\"},{\"id\":20126,\"count\":1,\"chance\":\"561\"}]'),
(1554, 0, 'Corym Vanguard', 0, 490, 700, 1, 0, '[\"Gimme! Gimme!\"]', '[\"paralyze\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":2148,\"count\":\"100\",\"chance\":\"50000\"},{\"id\":2148,\"count\":\"20\",\"chance\":\"50000\"},{\"id\":\"2696\",\"count\":1,\"chance\":\"20000\"},{\"id\":20089,\"count\":1,\"chance\":\"10000\"},{\"id\":20090,\"count\":1,\"chance\":\"4761\"},{\"id\":20092,\"count\":1,\"chance\":\"5000\"},{\"id\":20093,\"count\":1,\"chance\":\"5000\"},{\"id\":20097,\"count\":1,\"chance\":\"16666\"},{\"id\":20098,\"count\":1,\"chance\":\"3846\"},{\"id\":20099,\"count\":1,\"chance\":\"11111\"},{\"id\":20100,\"count\":1,\"chance\":\"14285\"},{\"id\":20101,\"count\":1,\"chance\":\"14285\"},{\"id\":20105,\"count\":1,\"chance\":\"14\"},{\"id\":20126,\"count\":1,\"chance\":\"1612\"},{\"id\":20139,\"count\":1,\"chance\":\"3225\"}]'),
(1555, 0, 'Countess Sorrow', 0, 13000, 6500, 15, 0, '[]', '[\"physical\",\"earth\",\"death\",\"lifedrain\",\"paralyze\",\"outfit\",\"drunk\",\"invisible\"]', 0, 0, 'undead', '[{\"id\":6536,\"count\":1,\"chance\":\"100000\"}]'),
(1556, 0, 'Crab', 305, 30, 55, 1, 0, '[]', '[\"earth\",\"drown\"]', 1, 1, 'blood', '[{\"id\":2148,\"count\":\"10\",\"chance\":\"80000\"},{\"id\":11189,\"count\":1,\"chance\":\"20000\"},{\"id\":\"2667\",\"count\":1,\"chance\":\"20000\"}]'),
(1557, 0, 'Crawler', 0, 1000, 1450, 1, 1, '[\"Sssschrchrsss!\"]', '[\"earth\",\"invisible\"]', 0, 0, 'venom', '[{\"id\":2148,\"count\":\"100\",\"chance\":\"50000\"},{\"id\":2148,\"count\":\"90\",\"chance\":\"50000\"},{\"id\":2154,\"count\":1,\"chance\":\"530\"},{\"id\":2168,\"count\":1,\"chance\":\"50000\"},{\"id\":2391,\"count\":1,\"chance\":\"2070\"},{\"id\":7590,\"count\":1,\"chance\":\"9300\"},{\"id\":7591,\"count\":1,\"chance\":\"6200\"},{\"id\":8912,\"count\":1,\"chance\":\"710\"},{\"id\":9970,\"count\":\"2\",\"chance\":\"10040\"},{\"id\":15482,\"count\":1,\"chance\":\"18430\"},{\"id\":15486,\"count\":1,\"chance\":\"14640\"},{\"id\":15490,\"count\":1,\"chance\":\"100\"}]'),
(1558, 0, 'Crazed Beggar', 300, 35, 100, 1, 0, '[\"Hehehe!\",\"Raahhh!\",\"You are one of THEM! Die!\",\"Wanna buy roses??\",\"Make it stop!\",\"They\'re coming! They\'re coming!\",\"Gimme money!\"]', '[]', 1, 1, 'blood', '[{\"id\":\"2148\",\"count\":\"9\",\"chance\":\"99393\"},{\"id\":\"2237\",\"count\":1,\"chance\":\"60572\"},{\"id\":\"2690\",\"count\":1,\"chance\":\"19237\"},{\"id\":\"2666\",\"count\":1,\"chance\":\"9850\"},{\"id\":\"2567\",\"count\":1,\"chance\":\"9474\"},{\"id\":\"2556\",\"count\":1,\"chance\":\"6672\"},{\"id\":\"2744\",\"count\":1,\"chance\":\"5055\"},{\"id\":\"2570\",\"count\":1,\"chance\":\"4708\"},{\"id\":\"2802\",\"count\":1,\"chance\":\"607\"},{\"id\":\"1681\",\"count\":1,\"chance\":\"607\"},{\"id\":\"5553\",\"count\":1,\"chance\":\"520\"},{\"id\":\"6092\",\"count\":1,\"chance\":\"380\"},{\"id\":\"2072\",\"count\":1,\"chance\":\"376\"},{\"id\":\"9808\",\"count\":1,\"chance\":\"289\"},{\"id\":\"2213\",\"count\":1,\"chance\":\"144\"}]'),
(1559, 0, 'Crimson Frog', 305, 20, 60, 1, 0, '[\"Ribbit!\",\"Ribbit! Ribbit!\"]', '[]', 1, 0, 'blood', '[{\"id\":2148,\"count\":\"11\",\"chance\":\"74000\"},{\"id\":3976,\"count\":1,\"chance\":\"9000\"}]'),
(1560, 0, 'Crocodile', 350, 40, 105, 1, 0, '[]', '[]', 1, 1, 'blood', '[{\"id\":\"2148\",\"count\":\"10\",\"chance\":\"49805\"},{\"id\":\"2671\",\"count\":1,\"chance\":\"39795\"},{\"id\":\"11196\",\"count\":1,\"chance\":\"20032\"},{\"id\":\"3982\",\"count\":1,\"chance\":\"86\"}]'),
(1561, 0, 'Crustacea Gigantica', 0, 1800, 1600, 35, 0, '[\"Chrchrchr\",\"Klonklonk\",\"Chrrrrr\"]', '[\"ice\",\"paralyze\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":2148,\"count\":\"100\",\"chance\":\"100000\"},{\"id\":2148,\"count\":\"43\",\"chance\":\"100000\"},{\"id\":7589,\"count\":1,\"chance\":\"14285\"},{\"id\":13304,\"count\":1,\"chance\":\"5000\"}]'),
(1562, 0, 'Crypt Defiler', 0, 70, 180, 1, 0, '[\"I smell gold!\",\"You\'ll make a fine fake-mummy to be sold!\",\"Untold riches are awaiting me!\",\"I don\'t like competition\"]', '[\"earth\",\"paralyze\"]', 0, 0, 'blood', '[{\"id\":2148,\"count\":\"39\",\"chance\":\"50900\"},{\"id\":2386,\"count\":1,\"chance\":\"2730\"},{\"id\":2398,\"count\":1,\"chance\":\"1800\"},{\"id\":2459,\"count\":1,\"chance\":\"450\"},{\"id\":2465,\"count\":1,\"chance\":\"2240\"},{\"id\":2509,\"count\":1,\"chance\":\"450\"},{\"id\":8267,\"count\":1,\"chance\":\"220\"},{\"id\":8838,\"count\":\"3\",\"chance\":\"4840\"},{\"id\":12412,\"count\":1,\"chance\":\"1570\"},{\"id\":12448,\"count\":1,\"chance\":\"4040\"}]'),
(1563, 0, 'Crypt Shambler', 580, 195, 330, 1, 0, '[\"Aaaaahhhh!\",\"Hoooohhh!\",\"Uhhhhhhh!\",\"Chhhhhhh!\"]', '[\"lifedrain\",\"paralyze\",\"earth\",\"death\",\"drown\"]', 0, 1, 'undead', '[{\"id\":2148,\"count\":\"55\",\"chance\":\"58000\"},{\"id\":3976,\"count\":\"10\",\"chance\":\"9000\"},{\"id\":11200,\"count\":1,\"chance\":\"5000\"},{\"id\":\"2230\",\"count\":1,\"chance\":\"5000\"},{\"id\":2459,\"count\":1,\"chance\":\"2000\"},{\"id\":2227,\"count\":1,\"chance\":\"1950\"},{\"id\":2377,\"count\":1,\"chance\":\"1950\"},{\"id\":2541,\"count\":1,\"chance\":\"1000\"},{\"id\":2399,\"count\":\"3\",\"chance\":\"1000\"},{\"id\":2450,\"count\":1,\"chance\":\"1000\"},{\"id\":2145,\"count\":1,\"chance\":\"500\"}]'),
(1564, 0, 'Crystal Spider', 0, 900, 1250, 5, 1, '[\"Screeech!\"]', '[\"fire\",\"ice\",\"paralyze\",\"outfit\",\"drunk\",\"invisible\"]', 0, 0, 'undead', '[{\"id\":\"2148\",\"count\":\"197\",\"chance\":\"100000\"},{\"id\":\"7589\",\"count\":1,\"chance\":\"14973\"},{\"id\":\"2463\",\"count\":1,\"chance\":\"9929\"},{\"id\":\"7364\",\"count\":\"6\",\"chance\":\"5874\"},{\"id\":\"3351\",\"count\":1,\"chance\":\"5164\"},{\"id\":\"7441\",\"count\":1,\"chance\":\"4906\"},{\"id\":\"7449\",\"count\":1,\"chance\":\"2517\"},{\"id\":\"5879\",\"count\":1,\"chance\":\"1983\"},{\"id\":\"2125\",\"count\":1,\"chance\":\"1640\"},{\"id\":\"2124\",\"count\":1,\"chance\":\"1587\"},{\"id\":\"2169\",\"count\":1,\"chance\":\"1485\"},{\"id\":\"2477\",\"count\":1,\"chance\":\"747\"},{\"id\":\"7290\",\"count\":1,\"chance\":\"717\"},{\"id\":\"7902\",\"count\":1,\"chance\":\"664\"},{\"id\":\"2476\",\"count\":1,\"chance\":\"559\"},{\"id\":\"7437\",\"count\":1,\"chance\":\"142\"},{\"id\":\"2171\",\"count\":1,\"chance\":\"123\"},{\"id\":\"5801\",\"count\":1,\"chance\":\"83\"}]'),
(1565, 0, 'Crystal Wolf', 0, 275, 750, 1, 0, '[\"Raaarrr!\",\"Aaaauuuuuooooooo!\"]', '[\"ice\",\"paralyze\",\"invisible\"]', 0, 0, 'undead', '[{\"id\":2148,\"count\":\"52\",\"chance\":\"56000\"},{\"id\":2183,\"count\":1,\"chance\":\"7400\"},{\"id\":2666,\"count\":\"4\",\"chance\":\"52000\"},{\"id\":5897,\"count\":1,\"chance\":\"3700\"},{\"id\":7839,\"count\":\"10\",\"chance\":\"11000\"},{\"id\":8878,\"count\":1,\"chance\":\"3700\"}]'),
(1566, 0, 'Crystalcrusher', 0, 500, 570, 5, 0, '[\"Creak!\",\"Crunch!\"]', '[\"earth\",\"invisible\"]', 0, 0, 'venom', '[{\"id\":2148,\"count\":\"90\",\"chance\":\"85000\"},{\"id\":18304,\"count\":\"3\",\"chance\":\"5000\"},{\"id\":18416,\"count\":1,\"chance\":\"4920\"},{\"id\":18417,\"count\":1,\"chance\":\"5250\"},{\"id\":18418,\"count\":1,\"chance\":\"5000\"},{\"id\":18432,\"count\":1,\"chance\":\"3690\"}]'),
(1567, 0, 'Cursed Gladiator', 0, 215, 435, 1, 0, '[\"Death where are you?\",\"Slay me, end my curse.\"]', '[\"outfit\",\"drunk\",\"invisible\"]', 0, 0, 'undead', '[]'),
(1568, 0, 'Cyclops Drone', 525, 200, 325, 1, 0, '[\"Fee! Fie! Foe! Fum!\",\"Luttl pest!\",\"Me makking you pulp!\",\"Humy tasy! Hum hum!\"]', '[]', 0, 1, 'blood', '[{\"id\":\"2148\",\"count\":\"30\",\"chance\":\"82050\"},{\"id\":\"2666\",\"count\":1,\"chance\":\"50295\"},{\"id\":\"2406\",\"count\":1,\"chance\":\"7867\"},{\"id\":\"10574\",\"count\":1,\"chance\":\"6895\"},{\"id\":\"2510\",\"count\":1,\"chance\":\"2026\"},{\"id\":\"2513\",\"count\":1,\"chance\":\"1580\"},{\"id\":\"2381\",\"count\":1,\"chance\":\"679\"},{\"id\":\"7588\",\"count\":1,\"chance\":\"517\"},{\"id\":\"2490\",\"count\":1,\"chance\":\"198\"},{\"id\":\"7398\",\"count\":1,\"chance\":\"124\"},{\"id\":\"2209\",\"count\":1,\"chance\":\"73\"}]'),
(1569, 0, 'Cyclops Smith', 695, 255, 435, 1, 0, '[\"Outis emoi g\' onoma.\",\"Whack da humy!\",\"Ai humy phary ty kaynon\"]', '[]', 0, 1, 'blood', '[{\"id\":\"2148\",\"count\":\"70\",\"chance\":\"82761\"},{\"id\":\"2666\",\"count\":1,\"chance\":\"50252\"},{\"id\":\"10574\",\"count\":1,\"chance\":\"10011\"},{\"id\":\"2513\",\"count\":1,\"chance\":\"6211\"},{\"id\":\"2378\",\"count\":1,\"chance\":\"5139\"},{\"id\":\"2417\",\"count\":1,\"chance\":\"5117\"},{\"id\":\"2510\",\"count\":1,\"chance\":\"2099\"},{\"id\":\"2442\",\"count\":1,\"chance\":\"2064\"},{\"id\":\"2387\",\"count\":1,\"chance\":\"977\"},{\"id\":\"7588\",\"count\":1,\"chance\":\"520\"},{\"id\":\"2490\",\"count\":1,\"chance\":\"199\"},{\"id\":\"7452\",\"count\":1,\"chance\":\"142\"},{\"id\":\"7398\",\"count\":1,\"chance\":\"126\"},{\"id\":\"2209\",\"count\":1,\"chance\":\"88\"}]'),
(1570, 0, 'Cyclops', 490, 150, 260, 1, 0, '[\"Il lorstok human!\",\"Toks utat.\",\"Human, uh whil dyh!\",\"Youh ah trak!\",\"Let da mashing begin!\"]', '[]', 1, 1, 'blood', '[{\"id\":\"2148\",\"count\":\"47\",\"chance\":\"82276\"},{\"id\":\"2666\",\"count\":1,\"chance\":\"29087\"},{\"id\":\"2406\",\"count\":1,\"chance\":\"7795\"},{\"id\":\"10574\",\"count\":1,\"chance\":\"5265\"},{\"id\":\"2510\",\"count\":1,\"chance\":\"2442\"},{\"id\":\"2513\",\"count\":1,\"chance\":\"1462\"},{\"id\":\"2381\",\"count\":1,\"chance\":\"892\"},{\"id\":\"2129\",\"count\":1,\"chance\":\"322\"},{\"id\":\"2490\",\"count\":1,\"chance\":\"234\"},{\"id\":\"7618\",\"count\":1,\"chance\":\"146\"},{\"id\":\"7398\",\"count\":1,\"chance\":\"117\"},{\"id\":\"2209\",\"count\":1,\"chance\":\"44\"}]'),
(1571, 0, 'Damaged Crystal Golem', 0, 0, 500, 1, 0, '[]', '[]', 0, 0, 'energy', '[]'),
(1572, 0, 'Damaged Worker Golem', 0, 95, 260, 1, 0, '[\"Klonk klonk klonk\",\"Failure! Failure!\",\"Good morning citizen. How may I serve you?\",\"Target identified: Rat! Termination initiated!\",\"Rrrtttarrrttarrrtta\",\"Danger will...chrrr! Danger!\",\"Self-diagnosis failed.\",\"Aw... chhhrrr orders.\"]', '[\"invisible\",\"paralyze\"]', 0, 0, 'energy', '[{\"id\":2148,\"count\":\"88\",\"chance\":\"68810\"},{\"id\":2207,\"count\":1,\"chance\":\"570\"},{\"id\":5880,\"count\":1,\"chance\":\"400\"},{\"id\":8309,\"count\":1,\"chance\":\"1460\"},{\"id\":\"9808\",\"count\":1,\"chance\":\"790\"},{\"id\":10572,\"count\":1,\"chance\":\"200\"}]'),
(1573, 0, 'Darakan the Executioner', 0, 1600, 3480, 1, 0, '[\"FIGHT LIKE A BARBARIAN!\",\"VICTORY IS MINE!\",\"I AM your father!\",\"To be the man you have to beat the man!\"]', '[\"outfit\",\"drunk\",\"invisible\"]', 0, 0, 'blood', '[]'),
(1574, 0, 'Dark Apprentice', 0, 100, 225, 1, 0, '[\"Outch!\",\"Oops, I did it again.\",\"From the spirits that I called Sir, deliver me!\",\"I must dispose of my masters enemies!\"]', '[\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2148\",\"count\":\"45\",\"chance\":\"75041\"},{\"id\":\"2260\",\"count\":\"3\",\"chance\":\"8034\"},{\"id\":\"7620\",\"count\":1,\"chance\":\"2995\"},{\"id\":\"7618\",\"count\":1,\"chance\":\"2884\"},{\"id\":\"2191\",\"count\":1,\"chance\":\"2004\"},{\"id\":\"2188\",\"count\":1,\"chance\":\"108\"},{\"id\":\"13295\",\"count\":1,\"chance\":\"7\"}]'),
(1575, 0, 'Dark Magician', 0, 185, 325, 1, 0, '[\"Feel the power of my runes!\",\"Killing you is getting expensive!\",\"My secrets are mine alone!\",\"Stand Still!\"]', '[\"invisible\"]', 0, 0, 'blood', '[{\"id\":2148,\"count\":\"55\",\"chance\":\"75100\"},{\"id\":2188,\"count\":1,\"chance\":\"280\"},{\"id\":2260,\"count\":1,\"chance\":\"10000\"},{\"id\":7588,\"count\":1,\"chance\":\"3000\"},{\"id\":7589,\"count\":1,\"chance\":\"2860\"},{\"id\":7618,\"count\":1,\"chance\":\"12000\"},{\"id\":7620,\"count\":1,\"chance\":\"11900\"},{\"id\":7761,\"count\":1,\"chance\":\"510\"},{\"id\":13295,\"count\":1,\"chance\":\"20\"}]'),
(1576, 0, 'Dark Monk', 480, 145, 190, 5, 1, '[\"You are no match to us!\",\"This is where your path will end!\",\"Your end has come!\"]', '[\"invisible\"]', 0, 1, 'blood', '[{\"id\":2689,\"count\":1,\"chance\":\"20550\"},{\"id\":2148,\"count\":\"18\",\"chance\":\"14600\"},{\"id\":11220,\"count\":1,\"chance\":\"10500\"},{\"id\":12448,\"count\":1,\"chance\":\"6666\"},{\"id\":10563,\"count\":1,\"chance\":\"1900\"},{\"id\":\"1949\",\"count\":1,\"chance\":\"1790\"},{\"id\":2177,\"count\":1,\"chance\":\"990\"},{\"id\":12449,\"count\":1,\"chance\":\"990\"},{\"id\":2193,\"count\":1,\"chance\":\"900\"},{\"id\":7620,\"count\":1,\"chance\":\"850\"},{\"id\":2642,\"count\":1,\"chance\":\"850\"},{\"id\":\"2044\",\"count\":1,\"chance\":\"550\"},{\"id\":2015,\"count\":1,\"chance\":\"390\"},{\"id\":2166,\"count\":1,\"chance\":\"120\"}]'),
(1577, 0, 'Dark Torturer', 0, 4650, 7350, 75, 0, '[\"You like it, don\'t you?\",\"IahaEhheAie!\",\"It\'s party time!\",\"Harrr, Harrr!\",\"The torturer is in!\"]', '[\"fire\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2148\",\"count\":\"199\",\"chance\":\"100000\"},{\"id\":\"2671\",\"count\":1,\"chance\":\"65733\"},{\"id\":\"2152\",\"count\":\"8\",\"chance\":\"57202\"},{\"id\":\"6558\",\"count\":1,\"chance\":\"35009\"},{\"id\":\"5944\",\"count\":1,\"chance\":\"24088\"},{\"id\":\"7590\",\"count\":\"2\",\"chance\":\"15083\"},{\"id\":\"7591\",\"count\":\"2\",\"chance\":\"9602\"},{\"id\":\"6500\",\"count\":1,\"chance\":\"8860\"},{\"id\":\"2558\",\"count\":1,\"chance\":\"5316\"},{\"id\":\"2645\",\"count\":1,\"chance\":\"5007\"},{\"id\":\"9971\",\"count\":1,\"chance\":\"3132\"},{\"id\":\"5022\",\"count\":\"2\",\"chance\":\"2823\"},{\"id\":\"5480\",\"count\":1,\"chance\":\"2061\"},{\"id\":\"6300\",\"count\":1,\"chance\":\"1958\"},{\"id\":\"7368\",\"count\":\"5\",\"chance\":\"1772\"},{\"id\":\"5801\",\"count\":1,\"chance\":\"845\"},{\"id\":\"7412\",\"count\":1,\"chance\":\"762\"},{\"id\":\"7388\",\"count\":1,\"chance\":\"536\"},{\"id\":\"2470\",\"count\":1,\"chance\":\"82\"}]'),
(1578, 0, 'Dawnfire Asura', 0, 4100, 2900, 1, 1, '[\"Encounter the flames of destiny!\",\"Fire and destruction!\",\"I will end your torment. Do not run, little mortal.\",\"Join me, brothers, for a BLOODY FRENZY!\"]', '[\"death\",\"paralyze\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2148\",\"count\":\"100\",\"chance\":\"100000\"},{\"id\":\"2148\",\"count\":\"100\",\"chance\":\"80000\"},{\"id\":\"2148\",\"count\":\"42\",\"chance\":\"60000\"},{\"id\":\"2152\",\"count\":\"6\",\"chance\":\"18200\"},{\"id\":\"6558\",\"count\":1,\"chance\":\"2000\"},{\"id\":\"7590\",\"count\":1,\"chance\":\"2000\"},{\"id\":\"2150\",\"count\":\"3\",\"chance\":\"210\"},{\"id\":\"2145\",\"count\":\"3\",\"chance\":\"300\"},{\"id\":\"2149\",\"count\":\"3\",\"chance\":\"300\"},{\"id\":\"2147\",\"count\":\"3\",\"chance\":\"350\"},{\"id\":\"9970\",\"count\":\"3\",\"chance\":\"280\"},{\"id\":\"2158\",\"count\":1,\"chance\":\"300\"},{\"id\":\"6300\",\"count\":1,\"chance\":\"260\"},{\"id\":\"6500\",\"count\":1,\"chance\":\"330\"},{\"id\":\"8871\",\"count\":1,\"chance\":\"220\"},{\"id\":\"24630\",\"count\":1,\"chance\":\"500\"},{\"id\":\"7899\",\"count\":1,\"chance\":\"100\"},{\"id\":\"2194\",\"count\":1,\"chance\":\"400\"},{\"id\":\"2663\",\"count\":1,\"chance\":\"300\"},{\"id\":\"24637\",\"count\":1,\"chance\":\"300\"},{\"id\":\"24631\",\"count\":1,\"chance\":\"500\"},{\"id\":\"5911\",\"count\":1,\"chance\":\"300\"},{\"id\":\"2133\",\"count\":1,\"chance\":\"400\"},{\"id\":\"2134\",\"count\":1,\"chance\":\"900\"},{\"id\":\"5944\",\"count\":1,\"chance\":\"300\"},{\"id\":\"8902\",\"count\":1,\"chance\":\"100\"},{\"id\":\"2187\",\"count\":1,\"chance\":\"200\"}]'),
(1579, 0, 'Deadeye Devious', 0, 750, 1450, 40, 0, '[\"Let\'s kill \'em\",\"Arrrgh!\",\"You\'ll never take me alive!\"]', '[\"invisible\"]', 0, 0, 'blood', '[{\"id\":2148,\"count\":\"65\",\"chance\":\"100000\"},{\"id\":2320,\"count\":\"2\",\"chance\":\"100000\"},{\"id\":2463,\"count\":1,\"chance\":\"4000\"},{\"id\":2476,\"count\":1,\"chance\":\"1200\"},{\"id\":2666,\"count\":1,\"chance\":\"100000\"},{\"id\":5926,\"count\":1,\"chance\":\"4000\"},{\"id\":6102,\"count\":1,\"chance\":\"100000\"}]'),
(1580, 0, 'Death Blob', 0, 300, 320, 1, 0, '[]', '[\"death\",\"earth\"]', 0, 0, 'undead', '[{\"id\":9968,\"count\":1,\"chance\":\"14285\"}]'),
(1581, 0, 'Death Priest', 0, 750, 800, 1, 0, '[]', '[\"death\",\"paralyze\",\"invisible\"]', 0, 0, 'undead', '[{\"id\":2143,\"count\":1,\"chance\":\"3000\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"35000\"},{\"id\":2148,\"count\":\"44\",\"chance\":\"35000\"},{\"id\":2159,\"count\":\"3\",\"chance\":\"10000\"},{\"id\":\"2175\",\"count\":1,\"chance\":\"6800\"},{\"id\":2214,\"count\":1,\"chance\":\"1000\"},{\"id\":5022,\"count\":\"4\",\"chance\":\"6000\"},{\"id\":7618,\"count\":1,\"chance\":\"15000\"},{\"id\":7620,\"count\":1,\"chance\":\"15000\"},{\"id\":\"13739\",\"count\":1,\"chance\":\"27000\"}]'),
(1582, 0, 'Deathbine', 0, 340, 525, 10, 0, '[]', '[\"earth\",\"invisible\"]', 0, 0, 'venom', '[{\"id\":2149,\"count\":\"4\",\"chance\":\"100000\"},{\"id\":2152,\"count\":\"5\",\"chance\":\"100000\"},{\"id\":2792,\"count\":1,\"chance\":\"50000\"},{\"id\":2804,\"count\":1,\"chance\":\"100000\"},{\"id\":5015,\"count\":1,\"chance\":\"5555\"},{\"id\":7732,\"count\":1,\"chance\":\"50000\"},{\"id\":7886,\"count\":1,\"chance\":\"50000\"},{\"id\":7887,\"count\":1,\"chance\":\"50000\"},{\"id\":8912,\"count\":1,\"chance\":\"50000\"},{\"id\":11217,\"count\":1,\"chance\":\"100000\"},{\"id\":13307,\"count\":1,\"chance\":\"2854\"}]'),
(1583, 0, 'Deathbringer', 0, 5100, 8440, 40, 0, '[\"YOU FOOLS WILL PAY!\",\"YOU ALL WILL DIE!!\",\"DEATH, DESTRUCTION!\",\"I will eat your soul!\"]', '[\"death\",\"fire\",\"ice\",\"earth\",\"outfit\",\"drunk\",\"invisible\"]', 0, 0, 'undead', '[]'),
(1584, 0, 'Deathslicer', 0, 0, 1, 1, 0, '[]', '[\"physical\",\"energy\",\"fire\",\"earth\",\"drown\",\"ice\",\"holy\",\"death\",\"lifedrain\",\"manadrain\",\"paralyze\",\"drunk\",\"outfit\",\"invisible\"]', 0, 0, 'undead', '[]'),
(1585, 0, 'Deathspawn', 305, 20, 225, 5, 0, '[\"Ribbit!\",\"Ribbit! Ribbit!\"]', '[\"death\",\"earth\"]', 0, 0, 'blood', '[]'),
(1586, 0, 'Deathstrike', 0, 40000, 200000, 125, 0, '[\"Deeestructiooon!\",\"Maaahhhrrr!\",\"You are nothing!\",\"Taaake ... this!\"]', '[\"outfit\",\"fire\",\"earth\",\"drown\",\"paralyze\",\"invisible\"]', 0, 0, 'undead', '[{\"id\":18430,\"count\":1,\"chance\":\"100000\"},{\"id\":18450,\"count\":1,\"chance\":\"10480\"},{\"id\":18451,\"count\":1,\"chance\":\"11430\"},{\"id\":18452,\"count\":1,\"chance\":\"8570\"},{\"id\":18453,\"count\":1,\"chance\":\"12380\"},{\"id\":18454,\"count\":1,\"chance\":\"11430\"},{\"id\":18465,\"count\":1,\"chance\":\"11430\"}]'),
(1587, 0, 'Deepling Brawler', 0, 260, 380, 1, 0, '[]', '[\"invisible\",\"paralyze\",\"drown\",\"fire\"]', 0, 0, 'blood', '[{\"id\":2148,\"count\":\"44\",\"chance\":\"61000\"},{\"id\":\"2667\",\"count\":\"3\",\"chance\":\"19120\"},{\"id\":5895,\"count\":1,\"chance\":\"740\"},{\"id\":13838,\"count\":1,\"chance\":\"2940\"},{\"id\":13870,\"count\":1,\"chance\":\"6600\"},{\"id\":15430,\"count\":1,\"chance\":\"14500\"}]'),
(1588, 0, 'Deepling Elite', 0, 3000, 3200, 1, 0, '[]', '[\"fire\",\"invisible\",\"paralyze\"]', 0, 0, 'blood', '[{\"id\":2148,\"count\":\"100\",\"chance\":\"100000\"},{\"id\":2148,\"count\":\"86\",\"chance\":\"100000\"},{\"id\":2149,\"count\":\"2\",\"chance\":\"6290\"},{\"id\":2168,\"count\":1,\"chance\":\"5360\"},{\"id\":5895,\"count\":1,\"chance\":\"2000\"},{\"id\":7590,\"count\":1,\"chance\":\"24000\"},{\"id\":7591,\"count\":1,\"chance\":\"25000\"},{\"id\":13838,\"count\":1,\"chance\":\"3380\"},{\"id\":13870,\"count\":1,\"chance\":\"25000\"},{\"id\":15425,\"count\":1,\"chance\":\"25000\"},{\"id\":15426,\"count\":1,\"chance\":\"21700\"},{\"id\":15451,\"count\":1,\"chance\":\"640\"},{\"id\":15452,\"count\":1,\"chance\":\"19000\"},{\"id\":15453,\"count\":1,\"chance\":\"1234\"},{\"id\":15488,\"count\":1,\"chance\":\"25000\"},{\"id\":15649,\"count\":\"5\",\"chance\":\"24000\"}]'),
(1589, 0, 'Deepling Guard', 0, 2100, 1900, 1, 0, '[\"QJELL NETA NA!!\"]', '[\"ice\",\"drown\",\"fire\",\"invisible\",\"paralyze\"]', 0, 0, 'blood', '[{\"id\":2146,\"count\":\"3\",\"chance\":\"2890\"},{\"id\":2148,\"count\":\"90\",\"chance\":\"100000\"},{\"id\":2148,\"count\":\"90\",\"chance\":\"100000\"},{\"id\":2152,\"count\":\"2\",\"chance\":\"70000\"},{\"id\":7590,\"count\":\"3\",\"chance\":\"14285\"},{\"id\":7591,\"count\":\"3\",\"chance\":\"14285\"},{\"id\":13838,\"count\":1,\"chance\":\"1694\"},{\"id\":13870,\"count\":1,\"chance\":\"10000\"},{\"id\":15423,\"count\":1,\"chance\":\"12500\"},{\"id\":15424,\"count\":1,\"chance\":\"16666\"},{\"id\":15454,\"count\":1,\"chance\":\"925\"},{\"id\":15455,\"count\":1,\"chance\":\"9090\"},{\"id\":15545,\"count\":1,\"chance\":\"10\"},{\"id\":15644,\"count\":1,\"chance\":\"362\"},{\"id\":15645,\"count\":1,\"chance\":\"333\"},{\"id\":15647,\"count\":1,\"chance\":\"751\"}]'),
(1590, 0, 'Deepling Master Librarian', 0, 1900, 1700, 1, 0, '[\"Mmmmmoooaaaaaahaaa!!!\"]', '[\"invisible\",\"ice\",\"fire\"]', 0, 0, 'blood', '[{\"id\":2146,\"count\":\"3\",\"chance\":\"8440\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"100000\"},{\"id\":2152,\"count\":\"3\",\"chance\":\"90000\"},{\"id\":2168,\"count\":1,\"chance\":\"3200\"},{\"id\":\"2667\",\"count\":\"2\",\"chance\":\"9090\"},{\"id\":5895,\"count\":1,\"chance\":\"1950\"},{\"id\":13870,\"count\":1,\"chance\":\"9380\"},{\"id\":15400,\"count\":1,\"chance\":\"3130\"},{\"id\":15403,\"count\":1,\"chance\":\"1330\"},{\"id\":15421,\"count\":1,\"chance\":\"25000\"},{\"id\":15422,\"count\":1,\"chance\":\"20000\"},{\"id\":15488,\"count\":1,\"chance\":\"20000\"},{\"id\":15644,\"count\":1,\"chance\":\"39\"}]'),
(1591, 0, 'Deepling Scout', 0, 160, 240, 1, 0, '[\"Njaaarh!!\",\"Begjone, intrjuder!!\",\"Djon\'t djare stjare injo the eyes of the djeep!\",\"Ljeave this sjacred pljace while you cjan\"]', '[\"invisible\",\"ice\",\"drown\",\"fire\"]', 0, 0, 'blood', '[{\"id\":2148,\"count\":\"50\",\"chance\":\"60000\"},{\"id\":2149,\"count\":1,\"chance\":\"121\"},{\"id\":2168,\"count\":1,\"chance\":\"2127\"},{\"id\":3965,\"count\":\"3\",\"chance\":\"14285\"},{\"id\":5895,\"count\":1,\"chance\":\"310\"},{\"id\":\"9809\",\"count\":1,\"chance\":\"925\"},{\"id\":9930,\"count\":1,\"chance\":\"111\"},{\"id\":13838,\"count\":1,\"chance\":\"505\"},{\"id\":13870,\"count\":1,\"chance\":\"310\"}]'),
(1592, 0, 'Deepling Spellsinger', 0, 1000, 850, 1, 0, '[\"Jey Obu giotja!!\",\"Mmmmmoooaaaaaahaaa!!\"]', '[\"invisible\",\"ice\",\"drown\",\"fire\"]', 0, 0, 'blood', '[{\"id\":2146,\"count\":1,\"chance\":\"2854\"},{\"id\":2148,\"count\":\"60\",\"chance\":\"70000\"},{\"id\":2152,\"count\":1,\"chance\":\"80000\"},{\"id\":2168,\"count\":1,\"chance\":\"2439\"},{\"id\":\"2667\",\"count\":1,\"chance\":\"3448\"},{\"id\":5895,\"count\":1,\"chance\":\"498\"},{\"id\":13870,\"count\":1,\"chance\":\"2500\"},{\"id\":15400,\"count\":1,\"chance\":\"2000\"},{\"id\":15403,\"count\":1,\"chance\":\"813\"},{\"id\":15421,\"count\":1,\"chance\":\"14285\"},{\"id\":15422,\"count\":1,\"chance\":\"10000\"},{\"id\":15488,\"count\":1,\"chance\":\"14285\"},{\"id\":15644,\"count\":1,\"chance\":\"220\"}]'),
(1593, 0, 'Deepling Tyrant', 0, 4200, 4900, 20, 0, '[\"QJELL NETA NA!!\"]', '[\"invisible\",\"ice\",\"paralyze\",\"drown\",\"fire\"]', 0, 0, 'blood', '[{\"id\":2148,\"count\":\"97\",\"chance\":\"100000\"},{\"id\":2148,\"count\":\"97\",\"chance\":\"100000\"},{\"id\":2152,\"count\":\"4\",\"chance\":\"70000\"},{\"id\":7590,\"count\":\"3\",\"chance\":\"32640\"},{\"id\":7591,\"count\":\"3\",\"chance\":\"33430\"},{\"id\":13870,\"count\":1,\"chance\":\"28850\"},{\"id\":15423,\"count\":1,\"chance\":\"23100\"},{\"id\":15424,\"count\":1,\"chance\":\"34770\"},{\"id\":15454,\"count\":1,\"chance\":\"1420\"},{\"id\":15455,\"count\":1,\"chance\":\"29960\"},{\"id\":15545,\"count\":1,\"chance\":\"80\"},{\"id\":15645,\"count\":1,\"chance\":\"510\"},{\"id\":15647,\"count\":1,\"chance\":\"1540\"}]'),
(1594, 0, 'Deepling Warrior', 0, 1500, 1600, 1, 0, '[\"Jou wjil all djie!\"]', '[\"invisible\",\"fire\",\"ice\",\"drown\"]', 0, 0, 'blood', '[{\"id\":2148,\"count\":\"100\",\"chance\":\"60000\"},{\"id\":2148,\"count\":\"80\",\"chance\":\"60000\"},{\"id\":2149,\"count\":1,\"chance\":\"2854\"},{\"id\":2168,\"count\":1,\"chance\":\"2941\"},{\"id\":5895,\"count\":1,\"chance\":\"961\"},{\"id\":7590,\"count\":1,\"chance\":\"9090\"},{\"id\":7591,\"count\":1,\"chance\":\"11111\"},{\"id\":13838,\"count\":1,\"chance\":\"1030\"},{\"id\":13870,\"count\":1,\"chance\":\"574\"},{\"id\":15425,\"count\":1,\"chance\":\"10000\"},{\"id\":15426,\"count\":1,\"chance\":\"14285\"},{\"id\":15451,\"count\":1,\"chance\":\"534\"},{\"id\":15452,\"count\":1,\"chance\":\"11111\"},{\"id\":15453,\"count\":1,\"chance\":\"684\"},{\"id\":15488,\"count\":1,\"chance\":\"14285\"},{\"id\":15649,\"count\":\"5\",\"chance\":\"3571\"}]'),
(1595, 0, 'Deepling Worker', 0, 130, 190, 1, 0, '[\"Qjell afar gou jey!\"]', '[\"invisible\",\"paralyze\",\"drown\",\"fire\",\"ice\"]', 0, 0, 'blood', '[{\"id\":2148,\"count\":\"25\",\"chance\":\"70000\"},{\"id\":2149,\"count\":\"3\",\"chance\":\"110\"},{\"id\":\"2667\",\"count\":\"3\",\"chance\":\"12020\"},{\"id\":5895,\"count\":1,\"chance\":\"350\"},{\"id\":13838,\"count\":1,\"chance\":\"510\"},{\"id\":13870,\"count\":1,\"chance\":\"283\"},{\"id\":15430,\"count\":1,\"chance\":\"6950\"}]'),
(1596, 0, 'Deepsea Blood Crab', 0, 180, 320, 80, 0, '[]', '[\"ice\",\"earth\",\"drown\"]', 0, 0, 'blood', '[{\"id\":\"2148\",\"count\":\"20\",\"chance\":\"86909\"},{\"id\":\"2667\",\"count\":1,\"chance\":\"10851\"},{\"id\":\"10550\",\"count\":1,\"chance\":\"6816\"},{\"id\":\"2464\",\"count\":1,\"chance\":\"5241\"},{\"id\":\"2478\",\"count\":1,\"chance\":\"2707\"},{\"id\":\"2143\",\"count\":1,\"chance\":\"541\"}]'),
(1597, 0, 'Deer', 260, 0, 25, 1, 0, '[]', '[]', 1, 1, 'blood', '[{\"id\":\"2666\",\"count\":1,\"chance\":\"80405\"},{\"id\":\"2671\",\"count\":1,\"chance\":\"51110\"},{\"id\":\"11214\",\"count\":1,\"chance\":\"1063\"}]'),
(1598, 0, 'Defiler', 0, 3700, 3650, 1, 0, '[\"Blubb\",\"Blubb Blubb\"]', '[\"earth\",\"paralyze\",\"invisible\"]', 0, 0, 'venom', '[{\"id\":\"2148\",\"count\":\"272\",\"chance\":\"100000\"},{\"id\":\"2152\",\"count\":\"6\",\"chance\":\"96687\"},{\"id\":\"5944\",\"count\":1,\"chance\":\"19478\"},{\"id\":\"6500\",\"count\":1,\"chance\":\"19157\"},{\"id\":\"9967\",\"count\":1,\"chance\":\"11586\"},{\"id\":\"9968\",\"count\":1,\"chance\":\"11245\"},{\"id\":\"2149\",\"count\":\"3\",\"chance\":\"5723\"},{\"id\":\"2151\",\"count\":1,\"chance\":\"4357\"},{\"id\":\"2147\",\"count\":\"2\",\"chance\":\"3695\"},{\"id\":\"6300\",\"count\":1,\"chance\":\"2831\"},{\"id\":\"2145\",\"count\":\"2\",\"chance\":\"2490\"},{\"id\":\"2154\",\"count\":1,\"chance\":\"1787\"},{\"id\":\"2156\",\"count\":1,\"chance\":\"1165\"},{\"id\":\"2158\",\"count\":1,\"chance\":\"843\"},{\"id\":\"2155\",\"count\":1,\"chance\":\"723\"}]'),
(1599, 0, 'Demodras', 0, 6000, 4500, 5, 0, '[\"I WILL SET THE WORLD ON FIRE!\",\"I WILL PROTECT MY BROOD!\"]', '[\"fire\",\"earth\",\"paralyze\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"5919\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2152\",\"count\":\"10\",\"chance\":\"99145\"},{\"id\":\"2672\",\"count\":1,\"chance\":\"75214\"},{\"id\":\"2796\",\"count\":\"7\",\"chance\":\"25641\"},{\"id\":\"2547\",\"count\":\"10\",\"chance\":\"19658\"},{\"id\":\"5948\",\"count\":1,\"chance\":\"13675\"},{\"id\":\"2146\",\"count\":1,\"chance\":\"11966\"},{\"id\":\"1976\",\"count\":1,\"chance\":\"10256\"},{\"id\":\"2167\",\"count\":1,\"chance\":\"10256\"},{\"id\":\"7591\",\"count\":1,\"chance\":\"9402\"},{\"id\":\"7590\",\"count\":1,\"chance\":\"9402\"},{\"id\":\"2033\",\"count\":1,\"chance\":\"5983\"},{\"id\":\"7365\",\"count\":\"5\",\"chance\":\"4274\"},{\"id\":\"2492\",\"count\":1,\"chance\":\"1709\"},{\"id\":\"2392\",\"count\":1,\"chance\":\"1709\"},{\"id\":\"2177\",\"count\":1,\"chance\":\"855\"}]'),
(1600, 0, 'Demon', 0, 25, 50, 1, 0, '[]', '[]', 0, 0, 'blood', '[{\"id\":2148,\"count\":\"9\",\"chance\":\"50320\"},{\"id\":1294,\"count\":1,\"chance\":\"15290\"},{\"id\":\"2667\",\"count\":1,\"chance\":\"12750\"},{\"id\":2559,\"count\":1,\"chance\":\"9700\"},{\"id\":2406,\"count\":1,\"chance\":\"8870\"},{\"id\":2449,\"count\":1,\"chance\":\"4900\"},{\"id\":2467,\"count\":1,\"chance\":\"2510\"},{\"id\":2461,\"count\":1,\"chance\":\"1940\"},{\"id\":2379,\"count\":1,\"chance\":\"1800\"},{\"id\":\"2230\",\"count\":1,\"chance\":\"1130\"},{\"id\":2235,\"count\":1,\"chance\":\"1000\"},{\"id\":12495,\"count\":1,\"chance\":\"940\"}]'),
(1601, 0, 'Demon Outcast', 0, 6200, 6900, 38, 0, '[\"Back in the evil business!\",\"This prison break will have casualties!\",\"At last someone to hurt\",\"No one will imprison me again!\"]', '[\"fire\",\"paralyze\",\"invisible\"]', 0, 0, 'fire', '[{\"id\":\"2148\",\"count\":\"100\",\"chance\":\"100000\"},{\"id\":\"2152\",\"count\":\"6\",\"chance\":\"100000\"},{\"id\":\"2795\",\"count\":\"6\",\"chance\":\"20245\"},{\"id\":\"8473\",\"count\":\"3\",\"chance\":\"20029\"},{\"id\":\"7590\",\"count\":\"2\",\"chance\":\"19829\"},{\"id\":\"2145\",\"count\":\"5\",\"chance\":\"10310\"},{\"id\":\"2147\",\"count\":\"5\",\"chance\":\"10055\"},{\"id\":\"2146\",\"count\":\"5\",\"chance\":\"10003\"},{\"id\":\"2149\",\"count\":\"5\",\"chance\":\"9939\"},{\"id\":\"9970\",\"count\":\"5\",\"chance\":\"9784\"},{\"id\":\"7368\",\"count\":\"10\",\"chance\":\"8655\"},{\"id\":\"2214\",\"count\":1,\"chance\":\"2448\"},{\"id\":\"2393\",\"count\":1,\"chance\":\"2010\"},{\"id\":\"2165\",\"count\":1,\"chance\":\"1397\"},{\"id\":\"2519\",\"count\":1,\"chance\":\"903\"},{\"id\":\"2396\",\"count\":1,\"chance\":\"877\"},{\"id\":\"2164\",\"count\":1,\"chance\":\"661\"},{\"id\":\"2171\",\"count\":1,\"chance\":\"661\"},{\"id\":\"2497\",\"count\":1,\"chance\":\"571\"},{\"id\":\"2462\",\"count\":1,\"chance\":\"555\"},{\"id\":\"5906\",\"count\":1,\"chance\":\"532\"},{\"id\":\"22396\",\"count\":1,\"chance\":\"468\"},{\"id\":\"2520\",\"count\":1,\"chance\":\"458\"},{\"id\":\"2487\",\"count\":1,\"chance\":\"274\"},{\"id\":\"7382\",\"count\":1,\"chance\":\"87\"}]'),
(1602, 0, 'Demon Parrot', 250, 225, 360, 40, 0, '[\"ISHH THAT THE BESHHT YOU HAVE TO OFFERRR?\",\"YOU ARRRRRE DOOMED!\",\"I SHHMELL FEEAARRR!\",\"MY SHHEED IS FEARRR AND MY HARRRVEST ISHH YOURRR SHHOUL!\",\"Your shhoooul will be mineee!\"]', '[\"lifedrain\",\"invisible\",\"drown\",\"drunk\"]', 0, 0, 'blood', '[{\"id\":2148,\"count\":\"99\",\"chance\":\"50000\"}]'),
(1603, 0, 'Demon Skeleton', 620, 240, 400, 1, 0, '[]', '[\"paralyze\",\"death\",\"fire\",\"earth\",\"drown\",\"lifedrain\",\"drunk\"]', 1, 1, 'undead', '[{\"id\":\"2148\",\"count\":\"75\",\"chance\":\"97515\"},{\"id\":\"10564\",\"count\":1,\"chance\":\"11978\"},{\"id\":\"2399\",\"count\":\"3\",\"chance\":\"9982\"},{\"id\":\"7618\",\"count\":\"2\",\"chance\":\"9693\"},{\"id\":\"7620\",\"count\":1,\"chance\":\"5050\"},{\"id\":\"2513\",\"count\":1,\"chance\":\"4960\"},{\"id\":\"2050\",\"count\":1,\"chance\":\"4861\"},{\"id\":\"2417\",\"count\":1,\"chance\":\"4061\"},{\"id\":\"2459\",\"count\":1,\"chance\":\"3377\"},{\"id\":\"2144\",\"count\":1,\"chance\":\"2976\"},{\"id\":\"2147\",\"count\":1,\"chance\":\"1531\"},{\"id\":\"2194\",\"count\":1,\"chance\":\"535\"},{\"id\":\"2178\",\"count\":1,\"chance\":\"469\"},{\"id\":\"2515\",\"count\":1,\"chance\":\"113\"}]'),
(1604, 0, 'Desperate White Deer', 0, 35, 255, 3, 1, '[\"*bell*\",\"ROOOAAARR!!\",\"*sniff*\",\"*wheeze*\"]', '[]', 0, 0, 'blood', '[{\"id\":\"13533\",\"count\":1,\"chance\":\"21286\"},{\"id\":\"13534\",\"count\":1,\"chance\":\"20418\"},{\"id\":\"2671\",\"count\":1,\"chance\":\"19595\"}]'),
(1605, 0, 'Destroyer', 0, 2500, 3700, 40, 1, '[\"COME HERE AND DIE!\",\"Destructiooooon!\",\"It\'s a good day to destroy!\"]', '[\"energy\",\"paralyze\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2148\",\"count\":\"282\",\"chance\":\"92584\"},{\"id\":\"2666\",\"count\":1,\"chance\":\"39280\"},{\"id\":\"6500\",\"count\":1,\"chance\":\"13803\"},{\"id\":\"2416\",\"count\":1,\"chance\":\"10573\"},{\"id\":\"2546\",\"count\":\"12\",\"chance\":\"8590\"},{\"id\":\"2489\",\"count\":1,\"chance\":\"5947\"},{\"id\":\"2150\",\"count\":\"2\",\"chance\":\"5947\"},{\"id\":\"5944\",\"count\":1,\"chance\":\"5433\"},{\"id\":\"3456\",\"count\":1,\"chance\":\"4699\"},{\"id\":\"11215\",\"count\":1,\"chance\":\"4552\"},{\"id\":\"2463\",\"count\":1,\"chance\":\"3304\"},{\"id\":\"2152\",\"count\":\"3\",\"chance\":\"2203\"},{\"id\":\"2393\",\"count\":1,\"chance\":\"1248\"},{\"id\":\"7591\",\"count\":1,\"chance\":\"1101\"},{\"id\":\"7427\",\"count\":1,\"chance\":\"808\"},{\"id\":\"2125\",\"count\":1,\"chance\":\"514\"},{\"id\":\"7419\",\"count\":1,\"chance\":\"294\"},{\"id\":\"2645\",\"count\":1,\"chance\":\"294\"},{\"id\":\"6300\",\"count\":1,\"chance\":\"220\"},{\"id\":\"2178\",\"count\":1,\"chance\":\"73\"}]'),
(1606, 0, 'Dharalion', 0, 570, 380, 10, 1, '[\"Feel my wrath!\",\"Noone will stop my ascension!\",\"My powers are divine!\",\"You desecrated this temple!\",\"Muahahaha!\"]', '[\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2148\",\"count\":\"100\",\"chance\":\"100000\"},{\"id\":\"5922\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"10552\",\"count\":1,\"chance\":\"87671\"},{\"id\":\"12421\",\"count\":1,\"chance\":\"83562\"},{\"id\":\"2154\",\"count\":1,\"chance\":\"41096\"},{\"id\":\"2682\",\"count\":1,\"chance\":\"24658\"},{\"id\":\"2260\",\"count\":1,\"chance\":\"23288\"},{\"id\":\"2198\",\"count\":1,\"chance\":\"16438\"},{\"id\":\"2689\",\"count\":1,\"chance\":\"15068\"},{\"id\":\"7590\",\"count\":1,\"chance\":\"13699\"},{\"id\":\"2177\",\"count\":1,\"chance\":\"12329\"},{\"id\":\"2802\",\"count\":1,\"chance\":\"10959\"},{\"id\":\"3957\",\"count\":1,\"chance\":\"9589\"},{\"id\":\"2652\",\"count\":1,\"chance\":\"5479\"},{\"id\":\"7378\",\"count\":\"2\",\"chance\":\"1370\"}]'),
(1607, 0, 'Diabolic Imp', 0, 2900, 1950, 1, 1, '[\"Muahaha!\",\"He he he.\"]', '[\"fire\",\"lifedrain\",\"paralyze\",\"invisible\"]', 0, 0, 'fire', '[{\"id\":\"2148\",\"count\":\"200\",\"chance\":\"99347\"},{\"id\":\"2548\",\"count\":1,\"chance\":\"50468\"},{\"id\":\"6558\",\"count\":1,\"chance\":\"24610\"},{\"id\":\"2260\",\"count\":\"2\",\"chance\":\"14973\"},{\"id\":\"2568\",\"count\":1,\"chance\":\"8828\"},{\"id\":\"2515\",\"count\":1,\"chance\":\"8274\"},{\"id\":\"6500\",\"count\":1,\"chance\":\"7777\"},{\"id\":\"5944\",\"count\":1,\"chance\":\"6912\"},{\"id\":\"2419\",\"count\":1,\"chance\":\"5351\"},{\"id\":\"2152\",\"count\":\"7\",\"chance\":\"3364\"},{\"id\":\"2165\",\"count\":1,\"chance\":\"2739\"},{\"id\":\"2150\",\"count\":\"3\",\"chance\":\"2583\"},{\"id\":\"2387\",\"count\":1,\"chance\":\"1746\"},{\"id\":\"2185\",\"count\":1,\"chance\":\"781\"},{\"id\":\"7900\",\"count\":1,\"chance\":\"525\"},{\"id\":\"7899\",\"count\":1,\"chance\":\"355\"},{\"id\":\"6300\",\"count\":1,\"chance\":\"99\"}]'),
(1608, 0, 'Diamond Servant', 0, 700, 1000, 1, 0, '[\"Error. LOAD \'PROGRAM\',8,1\",\"Remain. Obedient.\"]', '[\"energy\",\"invisible\",\"paralyze\"]', 0, 0, 'energy', '[{\"id\":\"2148\",\"count\":\"179\",\"chance\":\"94036\"},{\"id\":\"5944\",\"count\":1,\"chance\":\"44999\"},{\"id\":\"2177\",\"count\":1,\"chance\":\"9389\"},{\"id\":\"7589\",\"count\":1,\"chance\":\"6047\"},{\"id\":\"7588\",\"count\":1,\"chance\":\"5834\"},{\"id\":\"9976\",\"count\":1,\"chance\":\"5237\"},{\"id\":\"9690\",\"count\":1,\"chance\":\"5019\"},{\"id\":\"10572\",\"count\":1,\"chance\":\"4967\"},{\"id\":\"2164\",\"count\":1,\"chance\":\"903\"},{\"id\":\"7889\",\"count\":1,\"chance\":\"695\"},{\"id\":\"2154\",\"count\":1,\"chance\":\"561\"},{\"id\":\"13758\",\"count\":1,\"chance\":\"550\"},{\"id\":\"2189\",\"count\":1,\"chance\":\"550\"},{\"id\":\"7440\",\"count\":1,\"chance\":\"415\"},{\"id\":\"10221\",\"count\":1,\"chance\":\"114\"},{\"id\":\"8878\",\"count\":1,\"chance\":\"16\"},{\"id\":\"7428\",\"count\":1,\"chance\":\"10\"}]'),
(1609, 0, 'Diblis The Fair', 0, 1800, 1500, 30, 0, '[\"I envy you to be slain by someone as beautiful as me.\",\"I will drain your ugly corpses of the last drop of blood.\"]', '[\"lifedrain\",\"death\",\"invisible\"]', 0, 0, 'undead', '[{\"id\":2144,\"count\":\"2\",\"chance\":\"8900\"},{\"id\":2148,\"count\":\"99\",\"chance\":\"100000\"},{\"id\":2152,\"count\":\"5\",\"chance\":\"50000\"},{\"id\":2214,\"count\":1,\"chance\":\"14111\"},{\"id\":\"2229\",\"count\":1,\"chance\":\"15000\"},{\"id\":2534,\"count\":1,\"chance\":\"2100\"},{\"id\":7588,\"count\":1,\"chance\":\"1500\"},{\"id\":8903,\"count\":1,\"chance\":\"300\"},{\"id\":9020,\"count\":1,\"chance\":\"100000\"},{\"id\":13224,\"count\":1,\"chance\":\"500\"}]'),
(1610, 0, 'Dipthrah', 0, 2900, 4200, 50, 0, '[\"Come closer to learn the final lesson.\",\"You can\'t escape death forever.\",\"Undeath will shatter my shackles.\",\"You don\'t need this magic anymore.\"]', '[\"physical\",\"death\",\"invisible\"]', 0, 0, 'undead', '[{\"id\":\"3241\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2148\",\"count\":\"226\",\"chance\":\"90981\"},{\"id\":\"2146\",\"count\":\"3\",\"chance\":\"9806\"},{\"id\":\"7590\",\"count\":1,\"chance\":\"8927\"},{\"id\":\"2167\",\"count\":1,\"chance\":\"4857\"},{\"id\":\"2178\",\"count\":1,\"chance\":\"925\"},{\"id\":\"2158\",\"count\":1,\"chance\":\"833\"},{\"id\":\"2193\",\"count\":1,\"chance\":\"601\"},{\"id\":\"2436\",\"count\":1,\"chance\":\"555\"},{\"id\":\"11207\",\"count\":1,\"chance\":\"93\"},{\"id\":\"2446\",\"count\":1,\"chance\":\"93\"}]'),
(1611, 0, 'Dire Penguin', 0, 119, 173, 1, 1, '[]', '[\"lifedrain\",\"paralyze\",\"outfit\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":2148,\"count\":\"10\",\"chance\":\"18000\"},{\"id\":2434,\"count\":1,\"chance\":\"200\"},{\"id\":\"2667\",\"count\":\"4\",\"chance\":\"8000\"},{\"id\":7158,\"count\":1,\"chance\":\"8000\"},{\"id\":7159,\"count\":1,\"chance\":\"7000\"}]'),
(1612, 0, 'Dirtbeard', 775, 375, 630, 40, 0, '[\"You are no match for the scourge of the seas!\",\"You move like a seasick whale!\",\"Yarr, death to all landlubbers!\"]', '[\"invisible\"]', 0, 0, 'blood', '[]'),
(1613, 0, 'Diseased Bill', 0, 300, 1000, 15, 0, '[\"People like you are the plague and I\'ll be the cure!\",\"You all will pay for not helping me!\",\"Cough! Cough!\",\"Desolate! Everything is so desolate!\"]', '[\"earth\",\"paralyze\",\"invisible\"]', 0, 0, 'venom', '[{\"id\":2148,\"count\":\"25\",\"chance\":\"40000\"}]'),
(1614, 0, 'Diseased Dan', 0, 300, 800, 15, 0, '[\"Where... Where am I?\",\"Is that you, Tom?\",\"Phew, what an awful smell ... oh, that\'s me.\"]', '[\"paralyze\",\"invisible\"]', 0, 0, 'venom', '[{\"id\":2148,\"count\":\"25\",\"chance\":\"42000\"}]'),
(1615, 0, 'Diseased Fred', 0, 300, 1100, 15, 0, '[\"You will suffer the same fate as I do!\",\"The pain! The pain!\",\"Stay away! I am contagious!\",\"The plague will get you!\"]', '[\"earth\",\"paralyze\",\"invisible\"]', 0, 0, 'venom', '[{\"id\":2148,\"count\":\"25\",\"chance\":\"43000\"}]'),
(1616, 0, 'Dog', 220, 0, 20, 1, 0, '[\"Wuff wuff\"]', '[]', 1, 1, 'blood', '[]'),
(1617, 0, 'Donkey', 0, 0, 45, 1, 0, '[\"Grunt!\"]', '[]', 0, 0, 'blood', '[{\"id\":2666,\"count\":\"2\",\"chance\":\"20000\"}]'),
(1618, 0, 'Doom Deer', 0, 200, 405, 40, 1, '[\"I bet it was you who killed my mom!\"]', '[\"energy\",\"drown\",\"lifedrain\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":2148,\"count\":\"100\",\"chance\":\"50000\"}]'),
(1619, 0, 'Doomhowl', 0, 3750, 8500, 50, 1, '[]', '[\"paralyze\",\"invisible\"]', 0, 0, 'blood', '[]'),
(1620, 0, 'Dracola', 0, 11000, 16200, 95, 0, '[\"DEATH CAN\'T STOP MY HUNGER!\"]', '[\"earth\",\"paralyze\",\"invisible\"]', 0, 0, 'undead', '[{\"id\":2152,\"count\":\"8\",\"chance\":\"20000\"},{\"id\":6500,\"count\":\"4\",\"chance\":\"1000\"},{\"id\":6546,\"count\":1,\"chance\":\"100000\"}]'),
(1621, 0, 'Dragon Hatchling', 0, 185, 380, 1, 0, '[\"Fchu?\",\"Rooawwrr\"]', '[\"paralyze\",\"invisible\",\"fire\"]', 0, 0, 'blood', '[{\"id\":2148,\"count\":\"55\",\"chance\":\"67500\"},{\"id\":2672,\"count\":1,\"chance\":\"61000\"},{\"id\":7618,\"count\":1,\"chance\":\"400\"},{\"id\":12413,\"count\":1,\"chance\":\"4300\"}]'),
(1622, 0, 'Dragon Lord Hatchling', 0, 645, 750, 1, 0, '[\"Fchu?\",\"Rooawwrr\"]', '[\"paralyze\",\"invisible\",\"fire\"]', 0, 0, 'blood', '[{\"id\":2148,\"count\":\"90\",\"chance\":\"33750\"},{\"id\":2148,\"count\":\"75\",\"chance\":\"33750\"},{\"id\":2672,\"count\":1,\"chance\":\"80000\"},{\"id\":2796,\"count\":1,\"chance\":\"560\"},{\"id\":7620,\"count\":1,\"chance\":\"300\"},{\"id\":7891,\"count\":1,\"chance\":\"100\"}]'),
(1623, 0, 'Dragon Lord', 0, 2100, 1900, 1, 0, '[\"ZCHHHHH\",\"YOU WILL BURN!\"]', '[\"paralyze\",\"invisible\",\"fire\"]', 0, 0, 'blood', '[{\"id\":\"2148\",\"count\":\"246\",\"chance\":\"95258\"},{\"id\":\"2672\",\"count\":1,\"chance\":\"79757\"},{\"id\":\"2796\",\"count\":1,\"chance\":\"12120\"},{\"id\":\"7378\",\"count\":\"3\",\"chance\":\"9139\"},{\"id\":\"1976\",\"count\":1,\"chance\":\"9090\"},{\"id\":\"2547\",\"count\":\"7\",\"chance\":\"6565\"},{\"id\":\"2167\",\"count\":1,\"chance\":\"5072\"},{\"id\":\"2146\",\"count\":1,\"chance\":\"4968\"},{\"id\":\"2033\",\"count\":1,\"chance\":\"3072\"},{\"id\":\"5882\",\"count\":1,\"chance\":\"1963\"},{\"id\":\"5948\",\"count\":1,\"chance\":\"1022\"},{\"id\":\"7588\",\"count\":1,\"chance\":\"971\"},{\"id\":\"2177\",\"count\":1,\"chance\":\"629\"},{\"id\":\"2479\",\"count\":1,\"chance\":\"382\"},{\"id\":\"2392\",\"count\":1,\"chance\":\"286\"},{\"id\":\"2528\",\"count\":1,\"chance\":\"268\"},{\"id\":\"2498\",\"count\":1,\"chance\":\"233\"},{\"id\":\"2492\",\"count\":1,\"chance\":\"142\"},{\"id\":\"7402\",\"count\":1,\"chance\":\"109\"},{\"id\":\"7399\",\"count\":1,\"chance\":\"93\"}]'),
(1624, 0, 'Dragon', 0, 700, 1000, 1, 0, '[\"GROOAAARRR\",\"FCHHHHH\"]', '[\"paralyze\",\"invisible\",\"fire\"]', 0, 0, 'blood', '[{\"id\":\"2148\",\"count\":\"105\",\"chance\":\"90082\"},{\"id\":\"2672\",\"count\":1,\"chance\":\"65143\"},{\"id\":\"2509\",\"count\":1,\"chance\":\"14893\"},{\"id\":\"2455\",\"count\":1,\"chance\":\"10085\"},{\"id\":\"12413\",\"count\":1,\"chance\":\"9883\"},{\"id\":\"2546\",\"count\":\"10\",\"chance\":\"7976\"},{\"id\":\"2397\",\"count\":1,\"chance\":\"4027\"},{\"id\":\"3351\",\"count\":1,\"chance\":\"3005\"},{\"id\":\"2413\",\"count\":1,\"chance\":\"1995\"},{\"id\":\"2647\",\"count\":1,\"chance\":\"1909\"},{\"id\":\"7588\",\"count\":1,\"chance\":\"1055\"},{\"id\":\"2187\",\"count\":1,\"chance\":\"1053\"},{\"id\":\"5920\",\"count\":1,\"chance\":\"1038\"},{\"id\":\"5877\",\"count\":1,\"chance\":\"1018\"},{\"id\":\"2387\",\"count\":1,\"chance\":\"1008\"},{\"id\":\"2434\",\"count\":1,\"chance\":\"517\"},{\"id\":\"2409\",\"count\":1,\"chance\":\"504\"},{\"id\":\"2145\",\"count\":1,\"chance\":\"384\"},{\"id\":\"2516\",\"count\":1,\"chance\":\"301\"},{\"id\":\"2177\",\"count\":1,\"chance\":\"113\"},{\"id\":\"7430\",\"count\":1,\"chance\":\"102\"}]');
INSERT INTO `myaac_monsters` (`id`, `hidden`, `name`, `mana`, `exp`, `health`, `speed_lvl`, `use_haste`, `voices`, `immunities`, `summonable`, `convinceable`, `race`, `loot`) VALUES
(1625, 0, 'Dragonling', 0, 2200, 2600, 55, 0, '[\"FCHHHHHHHHHHHHHHHH\",\"FI?\"]', '[\"fire\",\"paralyze\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":2148,\"count\":\"100\",\"chance\":\"37500\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"37500\"},{\"id\":2148,\"count\":\"27\",\"chance\":\"37500\"},{\"id\":7588,\"count\":\"2\",\"chance\":\"24480\"},{\"id\":7589,\"count\":\"2\",\"chance\":\"16900\"},{\"id\":18425,\"count\":1,\"chance\":\"12410\"}]'),
(1626, 0, 'Draken Abomination', 0, 3800, 6250, 5, 0, '[\"Ugggh!\",\"Gll\"]', '[\"fire\",\"earth\",\"death\",\"invisible\"]', 0, 0, 'venom', '[{\"id\":2148,\"count\":\"100\",\"chance\":\"50000\"},{\"id\":2148,\"count\":\"98\",\"chance\":\"47000\"},{\"id\":2152,\"count\":\"8\",\"chance\":\"50590\"},{\"id\":2666,\"count\":\"4\",\"chance\":\"50450\"},{\"id\":7590,\"count\":\"3\",\"chance\":\"9950\"},{\"id\":7903,\"count\":1,\"chance\":\"8730\"},{\"id\":8472,\"count\":\"3\",\"chance\":\"4905\"},{\"id\":8473,\"count\":\"3\",\"chance\":\"9400\"},{\"id\":8922,\"count\":1,\"chance\":\"1020\"},{\"id\":9970,\"count\":\"4\",\"chance\":\"2900\"},{\"id\":11301,\"count\":1,\"chance\":\"470\"},{\"id\":11302,\"count\":1,\"chance\":\"560\"},{\"id\":11304,\"count\":1,\"chance\":\"780\"},{\"id\":12627,\"count\":1,\"chance\":\"12110\"},{\"id\":12628,\"count\":1,\"chance\":\"6240\"},{\"id\":12629,\"count\":1,\"chance\":\"10940\"},{\"id\":12644,\"count\":1,\"chance\":\"10\"},{\"id\":12646,\"count\":1,\"chance\":\"540\"},{\"id\":12647,\"count\":1,\"chance\":\"10\"},{\"id\":13538,\"count\":1,\"chance\":\"360\"}]'),
(1627, 0, 'Draken Elite', 0, 4200, 5550, 15, 0, '[\"For ze emperor!\",\"You will die zhouzandz deazhz!\"]', '[\"fire\",\"earth\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":2145,\"count\":\"4\",\"chance\":\"2440\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"50000\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"47000\"},{\"id\":2152,\"count\":\"8\",\"chance\":\"50360\"},{\"id\":2666,\"count\":1,\"chance\":\"30175\"},{\"id\":5904,\"count\":1,\"chance\":\"2100\"},{\"id\":7404,\"count\":1,\"chance\":\"980\"},{\"id\":7590,\"count\":\"3\",\"chance\":\"9340\"},{\"id\":8473,\"count\":\"3\",\"chance\":\"9250\"},{\"id\":11301,\"count\":1,\"chance\":\"490\"},{\"id\":11302,\"count\":1,\"chance\":\"150\"},{\"id\":11304,\"count\":1,\"chance\":\"770\"},{\"id\":11307,\"count\":1,\"chance\":\"490\"},{\"id\":12607,\"count\":1,\"chance\":\"110\"},{\"id\":12613,\"count\":1,\"chance\":\"910\"},{\"id\":12614,\"count\":1,\"chance\":\"7600\"},{\"id\":12615,\"count\":1,\"chance\":\"14030\"},{\"id\":12616,\"count\":1,\"chance\":\"16930\"},{\"id\":12617,\"count\":1,\"chance\":\"24670\"},{\"id\":12630,\"count\":1,\"chance\":\"10\"},{\"id\":12646,\"count\":1,\"chance\":\"600\"},{\"id\":12647,\"count\":1,\"chance\":\"80\"},{\"id\":12649,\"count\":1,\"chance\":\"20\"}]'),
(1628, 0, 'Draken Spellweaver', 0, 3100, 5000, 1, 0, '[\"Kazzzzuuuum!!\",\"Fissziss!\",\"Zzzzzooom!!\"]', '[\"fire\",\"earth\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":2123,\"count\":1,\"chance\":\"370\"},{\"id\":2147,\"count\":\"5\",\"chance\":\"6910\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"41000\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"58000\"},{\"id\":2152,\"count\":\"5\",\"chance\":\"25510\"},{\"id\":2155,\"count\":1,\"chance\":\"970\"},{\"id\":2187,\"count\":1,\"chance\":\"1660\"},{\"id\":2666,\"count\":1,\"chance\":\"30400\"},{\"id\":7590,\"count\":1,\"chance\":\"4970\"},{\"id\":8871,\"count\":1,\"chance\":\"1450\"},{\"id\":11303,\"count\":1,\"chance\":\"1980\"},{\"id\":11314,\"count\":1,\"chance\":\"19790\"},{\"id\":11315,\"count\":1,\"chance\":\"10\"},{\"id\":11355,\"count\":1,\"chance\":\"620\"},{\"id\":11356,\"count\":1,\"chance\":\"770\"},{\"id\":12410,\"count\":1,\"chance\":\"1980\"},{\"id\":12614,\"count\":1,\"chance\":\"3930\"},{\"id\":13294,\"count\":1,\"chance\":\"30\"},{\"id\":13538,\"count\":1,\"chance\":\"180\"}]'),
(1629, 0, 'Draken Warmaster', 0, 2400, 4150, 52, 0, '[\"Attack aggrezzively! Dezztroy zze intruderzz!\",\"Hizzzzz!\"]', '[\"fire\",\"earth\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2148\",\"count\":\"200\",\"chance\":\"97355\"},{\"id\":\"2152\",\"count\":\"5\",\"chance\":\"50252\"},{\"id\":\"2666\",\"count\":1,\"chance\":\"30158\"},{\"id\":\"11321\",\"count\":1,\"chance\":\"12048\"},{\"id\":\"11323\",\"count\":1,\"chance\":\"8001\"},{\"id\":\"11322\",\"count\":1,\"chance\":\"6993\"},{\"id\":\"7591\",\"count\":\"3\",\"chance\":\"5049\"},{\"id\":\"8473\",\"count\":1,\"chance\":\"3981\"},{\"id\":\"11303\",\"count\":1,\"chance\":\"2026\"},{\"id\":\"2528\",\"count\":1,\"chance\":\"1991\"},{\"id\":\"2147\",\"count\":\"5\",\"chance\":\"1573\"},{\"id\":\"11304\",\"count\":1,\"chance\":\"943\"},{\"id\":\"11305\",\"count\":1,\"chance\":\"827\"},{\"id\":\"11301\",\"count\":1,\"chance\":\"791\"},{\"id\":\"2123\",\"count\":1,\"chance\":\"208\"}]'),
(1630, 0, 'Draptor', 0, 2400, 3000, 31, 1, '[]', '[\"energy\",\"paralyze\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":2148,\"count\":\"90\",\"chance\":\"33750\"},{\"id\":2148,\"count\":\"60\",\"chance\":\"33750\"},{\"id\":7588,\"count\":1,\"chance\":\"3150\"},{\"id\":7589,\"count\":1,\"chance\":\"4150\"},{\"id\":8867,\"count\":1,\"chance\":\"950\"},{\"id\":13296,\"count\":1,\"chance\":\"6650\"}]'),
(1631, 0, 'Drasilla', 0, 700, 1260, 1, 0, '[\"FCHHHHHHHH!\",\"GROOOOAAAAAAAAR!\",\"DIRTY LITTLE HUMANS\",\"YOU CAN\'T KEEP ME HERE FOREVER\"]', '[\"fire\",\"outfit\",\"drunk\",\"invisible\"]', 0, 0, 'blood', '[]'),
(1632, 0, 'Dreadbeast', 800, 250, 800, 1, 0, '[]', '[\"death\",\"earth\",\"paralyze\"]', 0, 1, 'undead', '[{\"id\":2148,\"count\":\"88\",\"chance\":\"11690\"},{\"id\":\"2230\",\"count\":1,\"chance\":\"8230\"},{\"id\":2463,\"count\":1,\"chance\":\"2810\"},{\"id\":\"2229\",\"count\":1,\"chance\":\"2810\"},{\"id\":\"2231\",\"count\":1,\"chance\":\"1950\"},{\"id\":2449,\"count\":1,\"chance\":\"1520\"},{\"id\":2541,\"count\":1,\"chance\":\"1520\"},{\"id\":7618,\"count\":1,\"chance\":\"870\"},{\"id\":2796,\"count\":1,\"chance\":\"650\"},{\"id\":5925,\"count\":1,\"chance\":\"650\"}]'),
(1633, 0, 'Dreadwing', 0, 3750, 8500, 13, 0, '[]', '[\"death\",\"earth\",\"invisible\"]', 0, 0, 'blood', '[]'),
(1634, 0, 'Drillworm', 0, 858, 1500, 1, 0, '[\"Krrrk!\",\"Knarrrk!\"]', '[\"earth\",\"paralyze\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2148\",\"count\":\"150\",\"chance\":\"100000\"},{\"id\":\"11222\",\"count\":1,\"chance\":\"15049\"},{\"id\":\"13757\",\"count\":1,\"chance\":\"12155\"},{\"id\":\"18417\",\"count\":1,\"chance\":\"10095\"},{\"id\":\"18416\",\"count\":1,\"chance\":\"10029\"},{\"id\":\"18418\",\"count\":1,\"chance\":\"9978\"},{\"id\":\"18429\",\"count\":1,\"chance\":\"7329\"},{\"id\":\"18427\",\"count\":1,\"chance\":\"5172\"},{\"id\":\"3456\",\"count\":1,\"chance\":\"5087\"},{\"id\":\"18436\",\"count\":\"2\",\"chance\":\"5000\"},{\"id\":\"3976\",\"count\":\"5\",\"chance\":\"5000\"},{\"id\":\"7887\",\"count\":1,\"chance\":\"2571\"},{\"id\":\"2213\",\"count\":1,\"chance\":\"2387\"},{\"id\":\"5880\",\"count\":1,\"chance\":\"1537\"},{\"id\":\"11339\",\"count\":1,\"chance\":\"751\"},{\"id\":\"7452\",\"count\":1,\"chance\":\"519\"}]'),
(1635, 0, 'Dromedary', 0, 0, 45, 1, 0, '[\"Snort\",\"Grunt!\"]', '[]', 0, 0, 'blood', '[{\"id\":2666,\"count\":\"2\",\"chance\":\"36000\"},{\"id\":13939,\"count\":1,\"chance\":\"1000\"}]'),
(1636, 0, 'Dryad', 0, 190, 310, 5, 0, '[\"Feel the wrath of mother Nature!\",\"Defiler of nature!\"]', '[\"invisible\",\"earth\"]', 0, 0, 'blood', '[{\"id\":\"2787\",\"count\":\"2\",\"chance\":\"55000\"},{\"id\":\"2148\",\"count\":\"30\",\"chance\":\"40000\"},{\"id\":\"7732\",\"count\":\"3\",\"chance\":\"11000\"},{\"id\":\"9928\",\"count\":1,\"chance\":\"1280\"},{\"id\":\"9931\",\"count\":1,\"chance\":\"1200\"},{\"id\":\"9929\",\"count\":1,\"chance\":\"1100\"},{\"id\":\"9927\",\"count\":1,\"chance\":\"970\"},{\"id\":\"2790\",\"count\":\"2\",\"chance\":\"780\"},{\"id\":\"13298\",\"count\":1,\"chance\":\"210\"},{\"id\":\"2150\",\"count\":1,\"chance\":\"130\"}]'),
(1637, 0, 'Dwarf Dispenser', 0, 0, 100, 1, 0, '[]', '[\"invisible\"]', 0, 0, 'undead', '[]'),
(1638, 0, 'Dwarf Geomancer', 0, 265, 380, 1, 0, '[\"Hail Durin!\",\"Earth is the strongest element.\",\"Dust to dust.\"]', '[\"invisible\"]', 0, 0, 'blood', '[{\"id\":2148,\"count\":\"45\",\"chance\":\"75000\"},{\"id\":2787,\"count\":\"2\",\"chance\":\"60000\"},{\"id\":2260,\"count\":1,\"chance\":\"33000\"},{\"id\":2673,\"count\":1,\"chance\":\"24000\"},{\"id\":\"2162\",\"count\":1,\"chance\":\"14000\"},{\"id\":12414,\"count\":1,\"chance\":\"8000\"},{\"id\":12419,\"count\":1,\"chance\":\"7000\"},{\"id\":2423,\"count\":1,\"chance\":\"1120\"},{\"id\":2213,\"count\":1,\"chance\":\"580\"},{\"id\":2146,\"count\":1,\"chance\":\"580\"},{\"id\":\"2175\",\"count\":1,\"chance\":\"500\"},{\"id\":7886,\"count\":1,\"chance\":\"500\"},{\"id\":5880,\"count\":1,\"chance\":\"290\"}]'),
(1639, 0, 'Dwarf Guard', 650, 165, 245, 1, 0, '[\"Hail Durin!\"]', '[\"invisible\"]', 1, 1, 'blood', '[{\"id\":\"2787\",\"count\":\"2\",\"chance\":\"55243\"},{\"id\":\"2643\",\"count\":1,\"chance\":\"40075\"},{\"id\":\"2148\",\"count\":\"30\",\"chance\":\"39985\"},{\"id\":\"2483\",\"count\":1,\"chance\":\"9009\"},{\"id\":\"2513\",\"count\":1,\"chance\":\"6014\"},{\"id\":\"2417\",\"count\":1,\"chance\":\"3849\"},{\"id\":\"3351\",\"count\":1,\"chance\":\"1549\"},{\"id\":\"2387\",\"count\":1,\"chance\":\"592\"},{\"id\":\"5880\",\"count\":1,\"chance\":\"481\"},{\"id\":\"7618\",\"count\":1,\"chance\":\"394\"},{\"id\":\"2208\",\"count\":1,\"chance\":\"198\"},{\"id\":\"13757\",\"count\":1,\"chance\":\"195\"},{\"id\":\"2150\",\"count\":1,\"chance\":\"120\"}]'),
(1640, 0, 'Dwarf Henchman', 0, 15, 350, 1, 0, '[\"This place is for our eyes only!\",\"We will live and let you die!\",\"I will die another day!\",\"We have license to kill!\"]', '[\"invisible\"]', 0, 0, 'blood', '[]'),
(1641, 0, 'Dwarf Miner', 420, 60, 120, 1, 0, '[\"Work, work!\",\"Intruders in the mines!\",\"Mine, all mine!\"]', '[]', 1, 1, 'blood', '[{\"id\":\"2148\",\"count\":\"10\",\"chance\":\"41358\"},{\"id\":\"2386\",\"count\":1,\"chance\":\"15123\"},{\"id\":\"3456\",\"count\":1,\"chance\":\"12037\"},{\"id\":\"2649\",\"count\":1,\"chance\":\"8951\"},{\"id\":\"2484\",\"count\":1,\"chance\":\"7099\"},{\"id\":\"2666\",\"count\":1,\"chance\":\"3704\"},{\"id\":\"2213\",\"count\":1,\"chance\":\"617\"},{\"id\":\"5880\",\"count\":1,\"chance\":\"617\"}]'),
(1642, 0, 'Dwarf Soldier', 360, 70, 135, 1, 0, '[\"Hail Durin!\"]', '[]', 1, 1, 'blood', '[{\"id\":\"2787\",\"count\":\"2\",\"chance\":\"39924\"},{\"id\":\"2543\",\"count\":\"7\",\"chance\":\"37815\"},{\"id\":\"2148\",\"count\":\"12\",\"chance\":\"28337\"},{\"id\":\"2481\",\"count\":1,\"chance\":\"11820\"},{\"id\":\"2554\",\"count\":1,\"chance\":\"10026\"},{\"id\":\"2464\",\"count\":1,\"chance\":\"7525\"},{\"id\":\"7363\",\"count\":\"3\",\"chance\":\"3822\"},{\"id\":\"2525\",\"count\":1,\"chance\":\"3056\"},{\"id\":\"2455\",\"count\":1,\"chance\":\"3023\"},{\"id\":\"2378\",\"count\":1,\"chance\":\"2481\"},{\"id\":\"5880\",\"count\":1,\"chance\":\"303\"},{\"id\":\"2208\",\"count\":1,\"chance\":\"121\"}]'),
(1643, 0, 'Dwarf', 320, 45, 90, 1, 0, '[\"Hail Durin!\"]', '[]', 1, 1, 'blood', '[{\"id\":\"2787\",\"count\":1,\"chance\":\"50140\"},{\"id\":\"2148\",\"count\":\"8\",\"chance\":\"35361\"},{\"id\":\"2388\",\"count\":1,\"chance\":\"24739\"},{\"id\":\"2386\",\"count\":1,\"chance\":\"14596\"},{\"id\":\"3456\",\"count\":1,\"chance\":\"10143\"},{\"id\":\"2530\",\"count\":1,\"chance\":\"10098\"},{\"id\":\"2649\",\"count\":1,\"chance\":\"9682\"},{\"id\":\"2484\",\"count\":1,\"chance\":\"8017\"},{\"id\":\"2597\",\"count\":1,\"chance\":\"7929\"},{\"id\":\"2213\",\"count\":1,\"chance\":\"95\"},{\"id\":\"5880\",\"count\":1,\"chance\":\"83\"}]'),
(1644, 0, 'Dworc Fleshhunter', 0, 40, 85, 1, 0, '[\"Grak brrretz!\",\"Grow truk grrrrr.\",\"Prek tars, dekklep zurk.\"]', '[\"earth\"]', 0, 0, 'blood', '[{\"id\":\"2148\",\"count\":\"13\",\"chance\":\"74874\"},{\"id\":\"2467\",\"count\":1,\"chance\":\"10817\"},{\"id\":\"2568\",\"count\":1,\"chance\":\"8991\"},{\"id\":\"2050\",\"count\":1,\"chance\":\"5553\"},{\"id\":\"2229\",\"count\":\"3\",\"chance\":\"3027\"},{\"id\":\"2411\",\"count\":1,\"chance\":\"2061\"},{\"id\":\"3965\",\"count\":1,\"chance\":\"1950\"},{\"id\":\"2541\",\"count\":1,\"chance\":\"1035\"},{\"id\":\"3967\",\"count\":1,\"chance\":\"480\"},{\"id\":\"3964\",\"count\":1,\"chance\":\"97\"}]'),
(1645, 0, 'Dworc Venomsniper', 0, 35, 80, 1, 0, '[\"Brak brrretz!\",\"Grow truk grrrrr.\",\"Prek tars, dekklep zurk.\"]', '[\"earth\"]', 0, 0, 'blood', '[{\"id\":\"2148\",\"count\":\"13\",\"chance\":\"74992\"},{\"id\":\"2467\",\"count\":1,\"chance\":\"10048\"},{\"id\":\"2410\",\"count\":\"2\",\"chance\":\"7906\"},{\"id\":\"2050\",\"count\":1,\"chance\":\"5486\"},{\"id\":\"2545\",\"count\":\"3\",\"chance\":\"4957\"},{\"id\":\"2411\",\"count\":1,\"chance\":\"1500\"},{\"id\":\"2229\",\"count\":\"2\",\"chance\":\"983\"},{\"id\":\"3967\",\"count\":1,\"chance\":\"502\"},{\"id\":\"7732\",\"count\":1,\"chance\":\"193\"},{\"id\":\"3983\",\"count\":1,\"chance\":\"99\"},{\"id\":\"2172\",\"count\":1,\"chance\":\"97\"}]'),
(1646, 0, 'Dworc Voodoomaster', 0, 55, 80, 1, 1, '[\"Brak brrretz!\",\"Grow truk grrrrr.\",\"Prek tars, dekklep zurk.\"]', '[\"earth\"]', 0, 0, 'blood', '[{\"id\":\"2148\",\"count\":\"17\",\"chance\":\"74835\"},{\"id\":\"2467\",\"count\":1,\"chance\":\"10093\"},{\"id\":\"2230\",\"count\":1,\"chance\":\"5812\"},{\"id\":\"2050\",\"count\":1,\"chance\":\"5547\"},{\"id\":\"2231\",\"count\":1,\"chance\":\"3066\"},{\"id\":\"2229\",\"count\":\"3\",\"chance\":\"1973\"},{\"id\":\"2411\",\"count\":1,\"chance\":\"1009\"},{\"id\":\"7618\",\"count\":1,\"chance\":\"586\"},{\"id\":\"2174\",\"count\":1,\"chance\":\"503\"},{\"id\":\"3967\",\"count\":1,\"chance\":\"486\"},{\"id\":\"3955\",\"count\":1,\"chance\":\"120\"}]'),
(1647, 0, 'Earth Elemental', 0, 450, 650, 1, 0, '[]', '[\"paralyze\",\"invisible\",\"earth\",\"energy\"]', 0, 0, 'undead', '[{\"id\":1294,\"count\":\"10\",\"chance\":\"10000\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"43000\"},{\"id\":2148,\"count\":\"30\",\"chance\":\"50000\"},{\"id\":2260,\"count\":1,\"chance\":\"10000\"},{\"id\":7589,\"count\":1,\"chance\":\"1910\"},{\"id\":7850,\"count\":\"30\",\"chance\":\"20160\"},{\"id\":\"9808\",\"count\":1,\"chance\":\"350\"},{\"id\":9970,\"count\":1,\"chance\":\"620\"},{\"id\":11222,\"count\":1,\"chance\":\"20460\"},{\"id\":11339,\"count\":1,\"chance\":\"570\"},{\"id\":\"13757\",\"count\":1,\"chance\":\"470\"}]'),
(1648, 0, 'Earth Overlord', 0, 2800, 4000, 55, 0, '[]', '[\"earth\"]', 0, 0, 'undead', '[{\"id\":2148,\"count\":\"100\",\"chance\":\"100000\"},{\"id\":2148,\"count\":\"68\",\"chance\":\"100000\"},{\"id\":2152,\"count\":\"3\",\"chance\":\"33333\"},{\"id\":7884,\"count\":1,\"chance\":\"1923\"},{\"id\":8305,\"count\":1,\"chance\":\"100000\"},{\"id\":11222,\"count\":1,\"chance\":\"33333\"},{\"id\":11227,\"count\":1,\"chance\":\"8333\"},{\"id\":\"13757\",\"count\":1,\"chance\":\"552\"}]'),
(1649, 0, 'Efreet', 0, 410, 550, 7, 0, '[\"I grant you a deathwish!\",\"Good wishes are for fairytales\"]', '[\"paralyze\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":2148,\"count\":\"100\",\"chance\":\"47000\"},{\"id\":2148,\"count\":\"30\",\"chance\":\"47000\"},{\"id\":7378,\"count\":\"3\",\"chance\":\"15570\"},{\"id\":7589,\"count\":1,\"chance\":\"10500\"},{\"id\":2673,\"count\":\"5\",\"chance\":\"9390\"},{\"id\":12426,\"count\":1,\"chance\":\"8540\"},{\"id\":2149,\"count\":1,\"chance\":\"7200\"},{\"id\":2442,\"count\":1,\"chance\":\"5000\"},{\"id\":5910,\"count\":1,\"chance\":\"3000\"},{\"id\":\"1860\",\"count\":1,\"chance\":\"2200\"},{\"id\":12442,\"count\":1,\"chance\":\"1130\"},{\"id\":7900,\"count\":1,\"chance\":\"420\"},{\"id\":2187,\"count\":1,\"chance\":\"390\"},{\"id\":2663,\"count\":1,\"chance\":\"180\"},{\"id\":2063,\"count\":1,\"chance\":\"180\"},{\"id\":2155,\"count\":1,\"chance\":\"150\"}]'),
(1650, 0, 'Elder Bonelord', 0, 280, 500, 1, 0, '[\"Let me take a look at you!\",\"Inferior creatures, bow before my power!\",\"659978 54764!\",\"653768764!\"]', '[\"earth\",\"lifedrain\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2148\",\"count\":\"90\",\"chance\":\"99298\"},{\"id\":\"11193\",\"count\":1,\"chance\":\"20030\"},{\"id\":\"12468\",\"count\":1,\"chance\":\"9698\"},{\"id\":\"7364\",\"count\":\"4\",\"chance\":\"8785\"},{\"id\":\"2377\",\"count\":1,\"chance\":\"2968\"},{\"id\":\"2509\",\"count\":1,\"chance\":\"2033\"},{\"id\":\"5898\",\"count\":1,\"chance\":\"1927\"},{\"id\":\"2175\",\"count\":1,\"chance\":\"1016\"},{\"id\":\"7589\",\"count\":1,\"chance\":\"836\"},{\"id\":\"11197\",\"count\":1,\"chance\":\"458\"},{\"id\":\"2518\",\"count\":1,\"chance\":\"86\"},{\"id\":\"3972\",\"count\":1,\"chance\":\"84\"}]'),
(1651, 0, 'Elder Forest Fury', 0, 330, 670, 10, 0, '[\"To arms, sisters!\",\"Feel the wrath of mother forest!\",\"By the power of Greenskull!\"]', '[]', 0, 0, 'blood', '[{\"id\":\"2148\",\"count\":\"68\",\"chance\":\"90713\"},{\"id\":\"2543\",\"count\":\"15\",\"chance\":\"43844\"},{\"id\":\"2666\",\"count\":1,\"chance\":\"20086\"},{\"id\":\"21312\",\"count\":1,\"chance\":\"18575\"},{\"id\":\"7363\",\"count\":\"5\",\"chance\":\"17063\"},{\"id\":\"21311\",\"count\":1,\"chance\":\"11879\"},{\"id\":\"3965\",\"count\":\"2\",\"chance\":\"9071\"},{\"id\":\"2455\",\"count\":1,\"chance\":\"3456\"},{\"id\":\"2149\",\"count\":1,\"chance\":\"3240\"},{\"id\":\"8840\",\"count\":\"3\",\"chance\":\"864\"},{\"id\":\"7443\",\"count\":1,\"chance\":\"432\"},{\"id\":\"2181\",\"count\":1,\"chance\":\"432\"}]'),
(1652, 0, 'Elder Mummy', 0, 560, 850, 1, 0, '[]', '[\"earth\",\"death\",\"lifedrain\",\"paralyze\",\"invisible\"]', 0, 0, 'undead', '[{\"id\":\"2124\",\"count\":1,\"chance\":\"1650\"},{\"id\":2134,\"count\":1,\"chance\":\"4000\"},{\"id\":2144,\"count\":1,\"chance\":\"1340\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"43000\"},{\"id\":2148,\"count\":\"60\",\"chance\":\"43000\"},{\"id\":2159,\"count\":\"3\",\"chance\":\"10000\"},{\"id\":2161,\"count\":1,\"chance\":\"4500\"},{\"id\":\"2162\",\"count\":1,\"chance\":\"6000\"},{\"id\":2411,\"count\":1,\"chance\":\"380\"},{\"id\":3976,\"count\":\"3\",\"chance\":\"20000\"},{\"id\":10566,\"count\":1,\"chance\":\"10000\"},{\"id\":12422,\"count\":1,\"chance\":\"12600\"},{\"id\":\"13472\",\"count\":1,\"chance\":\"2400\"}]'),
(1653, 0, 'Elder Wyrm', 0, 2500, 2700, 30, 0, '[\"GRRR!\",\"GRROARR\"]', '[\"energy\",\"paralyze\",\"invisible\",\"lifedrain\"]', 0, 0, 'blood', '[{\"id\":2145,\"count\":\"5\",\"chance\":\"4000\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"50000\"},{\"id\":2148,\"count\":\"74\",\"chance\":\"50000\"},{\"id\":2152,\"count\":\"3\",\"chance\":\"25150\"},{\"id\":2455,\"count\":1,\"chance\":\"9690\"},{\"id\":2672,\"count\":\"2\",\"chance\":\"32420\"},{\"id\":5944,\"count\":1,\"chance\":\"5980\"},{\"id\":7430,\"count\":1,\"chance\":\"100\"},{\"id\":7451,\"count\":1,\"chance\":\"310\"},{\"id\":7588,\"count\":1,\"chance\":\"17710\"},{\"id\":7589,\"count\":1,\"chance\":\"20930\"},{\"id\":7889,\"count\":1,\"chance\":\"520\"},{\"id\":7893,\"count\":1,\"chance\":\"310\"},{\"id\":7895,\"count\":1,\"chance\":\"930\"},{\"id\":7898,\"count\":1,\"chance\":\"310\"},{\"id\":8855,\"count\":1,\"chance\":\"310\"},{\"id\":8871,\"count\":1,\"chance\":\"100\"},{\"id\":8920,\"count\":1,\"chance\":\"410\"},{\"id\":8921,\"count\":1,\"chance\":\"2000\"},{\"id\":10221,\"count\":1,\"chance\":\"100\"},{\"id\":10582,\"count\":1,\"chance\":\"15980\"}]'),
(1654, 0, 'Elephant', 500, 160, 320, 1, 0, '[\"Hooooot-Toooooot!\",\"Tooooot!\",\"Trooooot!\"]', '[]', 1, 1, 'blood', '[{\"id\":\"2666\",\"count\":1,\"chance\":\"40494\"},{\"id\":\"2671\",\"count\":1,\"chance\":\"29278\"},{\"id\":\"3956\",\"count\":\"2\",\"chance\":\"1089\"},{\"id\":\"3973\",\"count\":1,\"chance\":\"151\"}]'),
(1655, 0, 'Elf Arcanist', 0, 175, 220, 1, 0, '[\"Feel my wrath!\",\"For the Daughter of the Stars!\",\"I\'ll bring balance upon you!\",\"Tha\'shi Cenath!\",\"Vihil Ealuel!\"]', '[\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2148\",\"count\":\"49\",\"chance\":\"37127\"},{\"id\":\"1949\",\"count\":1,\"chance\":\"30500\"},{\"id\":\"2682\",\"count\":1,\"chance\":\"21814\"},{\"id\":\"2260\",\"count\":1,\"chance\":\"17953\"},{\"id\":\"2689\",\"count\":1,\"chance\":\"13899\"},{\"id\":\"10552\",\"count\":1,\"chance\":\"10070\"},{\"id\":\"12421\",\"count\":1,\"chance\":\"7786\"},{\"id\":\"2652\",\"count\":1,\"chance\":\"7294\"},{\"id\":\"2544\",\"count\":\"3\",\"chance\":\"6127\"},{\"id\":\"2802\",\"count\":1,\"chance\":\"4846\"},{\"id\":\"7618\",\"count\":1,\"chance\":\"4050\"},{\"id\":\"7589\",\"count\":1,\"chance\":\"2991\"},{\"id\":\"2047\",\"count\":1,\"chance\":\"2192\"},{\"id\":\"2198\",\"count\":1,\"chance\":\"2047\"},{\"id\":\"5922\",\"count\":1,\"chance\":\"2047\"},{\"id\":\"2189\",\"count\":1,\"chance\":\"1126\"},{\"id\":\"2177\",\"count\":1,\"chance\":\"1059\"},{\"id\":\"2642\",\"count\":1,\"chance\":\"974\"},{\"id\":\"2600\",\"count\":1,\"chance\":\"951\"},{\"id\":\"2747\",\"count\":1,\"chance\":\"803\"},{\"id\":\"2154\",\"count\":1,\"chance\":\"48\"}]'),
(1656, 0, 'Elf Overseer', 0, 290, 500, 1, 0, '[\"Do YOU want some more water, yes? YES?\",\"DOWN WITH THE FIRES OF IGNORANCE!!\"]', '[\"fire\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":2148,\"count\":\"50\",\"chance\":\"51000\"},{\"id\":10552,\"count\":1,\"chance\":\"20000\"},{\"id\":2689,\"count\":\"3\",\"chance\":\"14000\"},{\"id\":7618,\"count\":1,\"chance\":\"14000\"},{\"id\":2513,\"count\":1,\"chance\":\"11000\"},{\"id\":5922,\"count\":1,\"chance\":\"8500\"},{\"id\":7620,\"count\":1,\"chance\":\"8500\"},{\"id\":7449,\"count\":1,\"chance\":\"5700\"}]'),
(1657, 0, 'Elf Scout', 360, 75, 160, 1, 0, '[\"Tha\'shi Ab\'Dendriel!\",\"Feel the sting of my arrows!\",\"Thy blood will quench the soil\'s thirst!\",\"Evicor guide my arrow.\",\"Your existence will end here!\"]', '[\"invisible\"]', 0, 1, 'blood', '[{\"id\":2148,\"count\":\"25\",\"chance\":\"75000\"},{\"id\":\"2544\",\"count\":\"12\",\"chance\":\"30710\"},{\"id\":2681,\"count\":1,\"chance\":\"17750\"},{\"id\":2545,\"count\":\"4\",\"chance\":\"15400\"},{\"id\":12420,\"count\":1,\"chance\":\"9750\"},{\"id\":10552,\"count\":1,\"chance\":\"5200\"},{\"id\":2456,\"count\":1,\"chance\":\"4000\"},{\"id\":2031,\"count\":1,\"chance\":\"1350\"},{\"id\":2642,\"count\":1,\"chance\":\"1180\"},{\"id\":\"5921\",\"count\":1,\"chance\":\"1130\"},{\"id\":7438,\"count\":1,\"chance\":\"140\"}]'),
(1658, 0, 'Elf', 320, 42, 100, 1, 0, '[\"Ulathil beia Thratha!\",\"Bahaha aka!\",\"You are not welcome here.\",\"Flee as long as you can.\",\"Death to the defilers!\"]', '[\"invisible\"]', 0, 1, 'blood', '[{\"id\":\"2148\",\"count\":\"30\",\"chance\":\"44661\"},{\"id\":\"8839\",\"count\":\"2\",\"chance\":\"20013\"},{\"id\":\"2482\",\"count\":1,\"chance\":\"15055\"},{\"id\":\"2643\",\"count\":1,\"chance\":\"11113\"},{\"id\":\"2397\",\"count\":1,\"chance\":\"10918\"},{\"id\":\"2484\",\"count\":1,\"chance\":\"9010\"},{\"id\":\"2510\",\"count\":1,\"chance\":\"8957\"},{\"id\":\"2544\",\"count\":\"3\",\"chance\":\"7026\"},{\"id\":\"10552\",\"count\":1,\"chance\":\"1984\"},{\"id\":\"5921\",\"count\":1,\"chance\":\"1011\"}]'),
(1659, 0, 'Elvira Hammerthrust', 0, 165, 245, 1, 0, '[\"Didn\'t think a dwarf girl could be so pretty and strong at the same time, did you?\",\"Hail no one except for me!\",\"You won\'t get this bag, I worked hard for this!\"]', '[\"invisible\"]', 0, 0, 'blood', '[{\"id\":14903,\"count\":1,\"chance\":\"100000\"},{\"id\":2152,\"count\":\"100\",\"chance\":\"77000\"}]'),
(1660, 0, 'Emerald Damselfly', 0, 35, 90, 1, 0, '[\"Bzzzzz!\"]', '[]', 0, 0, 'venom', '[{\"id\":\"2148\",\"count\":\"18\",\"chance\":\"90901\"},{\"id\":\"19738\",\"count\":1,\"chance\":\"11824\"},{\"id\":\"19743\",\"count\":1,\"chance\":\"9986\"},{\"id\":\"2544\",\"count\":\"5\",\"chance\":\"7541\"},{\"id\":\"2120\",\"count\":1,\"chance\":\"5031\"},{\"id\":\"7618\",\"count\":1,\"chance\":\"3588\"},{\"id\":\"7620\",\"count\":1,\"chance\":\"3560\"}]'),
(1661, 0, 'Energized Raging Mage', 0, 0, 3500, 5, 0, '[\"Behold the all permeating powers I draw from this gate!!\",\"ENERGY!!\",\"I FEEL, I FEEEEL... OMNIPOTENCE!!\",\"MWAAAHAHAAA!! NO ONE!! NO ONE CAN DEFEAT MEEE!!!\"]', '[\"energy\",\"outfit\",\"fire\",\"drunk\",\"invisible\"]', 0, 0, 'blood', '[]'),
(1662, 0, 'Energy Elemental', 0, 550, 500, 1, 0, '[]', '[\"fire\",\"energy\",\"ice\",\"lifedrain\",\"invisible\",\"paralyze\"]', 0, 0, 'energy', '[{\"id\":\"2124\",\"count\":1,\"chance\":\"2000\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"50000\"},{\"id\":2148,\"count\":\"70\",\"chance\":\"50000\"},{\"id\":2150,\"count\":\"2\",\"chance\":\"5000\"},{\"id\":2167,\"count\":1,\"chance\":\"892\"},{\"id\":2170,\"count\":1,\"chance\":\"1020\"},{\"id\":2189,\"count\":1,\"chance\":\"636\"},{\"id\":2399,\"count\":\"5\",\"chance\":\"9900\"},{\"id\":2425,\"count\":1,\"chance\":\"3571\"},{\"id\":2515,\"count\":1,\"chance\":\"243\"},{\"id\":7449,\"count\":1,\"chance\":\"5882\"},{\"id\":7589,\"count\":1,\"chance\":\"7692\"},{\"id\":7620,\"count\":1,\"chance\":\"11711\"},{\"id\":7838,\"count\":\"10\",\"chance\":\"10000\"}]'),
(1663, 0, 'Energy Overlord', 0, 2800, 4000, 35, 0, '[]', '[\"ice\",\"energy\"]', 0, 0, 'undead', '[{\"id\":2148,\"count\":\"64\",\"chance\":\"100000\"},{\"id\":2152,\"count\":\"2\",\"chance\":\"25000\"}]'),
(1664, 0, 'Enlightened of the Cult', 0, 500, 700, 1, 0, '[\"Praise to my master Urgith!\",\"You will rise as my servant!\",\"Praise to my masters! Long live the triangle!\",\"You will die in the name of the triangle!\"]', '[\"paralyze\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"1962\",\"count\":1,\"chance\":\"910\"},{\"id\":2114,\"count\":1,\"chance\":\"130\"},{\"id\":2146,\"count\":1,\"chance\":\"550\"},{\"id\":2148,\"count\":\"70\",\"chance\":\"64550\"},{\"id\":2167,\"count\":1,\"chance\":\"450\"},{\"id\":2171,\"count\":1,\"chance\":\"200\"},{\"id\":2187,\"count\":1,\"chance\":\"180\"},{\"id\":2200,\"count\":1,\"chance\":\"790\"},{\"id\":2436,\"count\":1,\"chance\":\"350\"},{\"id\":2656,\"count\":1,\"chance\":\"40\"},{\"id\":5670,\"count\":1,\"chance\":\"130\"},{\"id\":5801,\"count\":1,\"chance\":\"100\"},{\"id\":5810,\"count\":1,\"chance\":\"430\"},{\"id\":\"6090\",\"count\":1,\"chance\":\"490\"},{\"id\":7426,\"count\":1,\"chance\":\"100\"},{\"id\":7589,\"count\":1,\"chance\":\"740\"},{\"id\":10555,\"count\":1,\"chance\":\"10250\"},{\"id\":12411,\"count\":1,\"chance\":\"890\"},{\"id\":12608,\"count\":1,\"chance\":\"100\"}]'),
(1665, 0, 'Enraged Crystal Golem', 0, 550, 700, 1, 0, '[\"Crrrrk! Chhhhr!\"]', '[\"fire\",\"ice\",\"paralyze\",\"invisible\"]', 0, 0, 'energy', '[{\"id\":2148,\"count\":\"100\",\"chance\":\"100000\"},{\"id\":7449,\"count\":1,\"chance\":\"4710\"},{\"id\":7454,\"count\":1,\"chance\":\"360\"},{\"id\":7588,\"count\":1,\"chance\":\"7140\"},{\"id\":7589,\"count\":1,\"chance\":\"8270\"},{\"id\":18418,\"count\":1,\"chance\":\"4120\"},{\"id\":18419,\"count\":1,\"chance\":\"1050\"},{\"id\":18432,\"count\":1,\"chance\":\"7980\"},{\"id\":18451,\"count\":\"5\",\"chance\":\"5008\"}]'),
(1666, 0, 'Enraged White Deer', 0, 165, 255, 1, 0, '[\"*wheeze*\",\"ROOOAAARR!!\",\"*sniff*\",\"*bell*\"]', '[]', 0, 0, 'blood', '[{\"id\":\"13534\",\"count\":1,\"chance\":\"19968\"},{\"id\":\"2671\",\"count\":1,\"chance\":\"19727\"},{\"id\":\"13533\",\"count\":1,\"chance\":\"19647\"}]'),
(1667, 0, 'Enslaved Dwarf', 0, 2700, 3800, 25, 0, '[\"Bark!\",\"Blood!\"]', '[\"fire\",\"paralyze\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2148\",\"count\":\"149\",\"chance\":\"100000\"},{\"id\":\"2152\",\"count\":\"6\",\"chance\":\"100000\"},{\"id\":\"2789\",\"count\":\"2\",\"chance\":\"14724\"},{\"id\":\"5880\",\"count\":1,\"chance\":\"10357\"},{\"id\":\"2150\",\"count\":\"2\",\"chance\":\"10328\"},{\"id\":\"2149\",\"count\":\"2\",\"chance\":\"9826\"},{\"id\":\"7590\",\"count\":1,\"chance\":\"6019\"},{\"id\":\"7591\",\"count\":1,\"chance\":\"5754\"},{\"id\":\"11227\",\"count\":1,\"chance\":\"5341\"},{\"id\":\"18436\",\"count\":\"5\",\"chance\":\"5193\"},{\"id\":\"18417\",\"count\":\"2\",\"chance\":\"4721\"},{\"id\":\"2391\",\"count\":1,\"chance\":\"3924\"},{\"id\":\"18420\",\"count\":1,\"chance\":\"3747\"},{\"id\":\"2532\",\"count\":1,\"chance\":\"3305\"},{\"id\":\"18416\",\"count\":1,\"chance\":\"3275\"},{\"id\":\"2515\",\"count\":1,\"chance\":\"2567\"},{\"id\":\"2208\",\"count\":1,\"chance\":\"2006\"},{\"id\":\"18415\",\"count\":1,\"chance\":\"1977\"},{\"id\":\"7454\",\"count\":1,\"chance\":\"1564\"},{\"id\":\"13757\",\"count\":1,\"chance\":\"1121\"},{\"id\":\"7413\",\"count\":1,\"chance\":\"1121\"},{\"id\":\"2528\",\"count\":1,\"chance\":\"472\"},{\"id\":\"7437\",\"count\":1,\"chance\":\"384\"},{\"id\":\"2475\",\"count\":1,\"chance\":\"325\"}]'),
(1668, 0, 'Esmeralda', 0, 600, 800, 13, 0, '[\"Fcccccchhhhhh\"]', '[\"death\",\"earth\",\"paralyze\",\"lifedrain\",\"drunk\",\"drown\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2148\",\"count\":\"170\",\"chance\":\"100000\"},{\"id\":\"10585\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2214\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2152\",\"count\":\"4\",\"chance\":\"94872\"},{\"id\":\"2147\",\"count\":\"3\",\"chance\":\"71795\"},{\"id\":\"2476\",\"count\":1,\"chance\":\"52564\"},{\"id\":\"2528\",\"count\":1,\"chance\":\"43590\"},{\"id\":\"2381\",\"count\":1,\"chance\":\"28205\"},{\"id\":\"2438\",\"count\":1,\"chance\":\"25641\"},{\"id\":\"7884\",\"count\":1,\"chance\":\"10256\"},{\"id\":\"2799\",\"count\":1,\"chance\":\"5128\"}]'),
(1669, 0, 'Essence of Darkness', 0, 30, 1000, 5, 0, '[]', '[\"physical\",\"death\",\"energy\",\"ice\",\"earth\",\"lifedrain\"]', 0, 0, 'undead', '[]'),
(1670, 0, 'Eternal Guardian', 0, 1800, 2500, 1, 0, '[\"Zzrkrrch!\",\"<crackle>\"]', '[\"earth\",\"drown\",\"paralyze\",\"invisible\"]', 0, 0, 'undead', '[{\"id\":\"2148\",\"count\":\"100\",\"chance\":\"99955\"},{\"id\":\"2152\",\"count\":\"4\",\"chance\":\"99708\"},{\"id\":\"1294\",\"count\":\"10\",\"chance\":\"30268\"},{\"id\":\"10549\",\"count\":1,\"chance\":\"20024\"},{\"id\":\"11325\",\"count\":1,\"chance\":\"10020\"},{\"id\":\"11323\",\"count\":1,\"chance\":\"1991\"},{\"id\":\"5880\",\"count\":1,\"chance\":\"1682\"},{\"id\":\"11227\",\"count\":1,\"chance\":\"819\"},{\"id\":\"2528\",\"count\":1,\"chance\":\"807\"},{\"id\":\"11339\",\"count\":1,\"chance\":\"729\"},{\"id\":\"2427\",\"count\":1,\"chance\":\"566\"},{\"id\":\"11343\",\"count\":1,\"chance\":\"499\"},{\"id\":\"13757\",\"count\":1,\"chance\":\"443\"},{\"id\":\"11307\",\"count\":1,\"chance\":\"107\"}]'),
(1671, 0, 'Evil Mastermind', 0, 675, 1295, 65, 0, '[\"You won\'t stop my masterplan to flood the world market with fake Bonelord language dictionaries!\",\"My calculations tell me you\'ll die!\",\"You can\'t stop me!\",\"Beware! My evil monolog is coming!\"]', '[\"earth\",\"death\",\"invisible\"]', 0, 0, 'undead', '[]'),
(1672, 0, 'Evil Sheep Lord', 0, 340, 400, 40, 0, '[\"You can COUNT on us!\",\"Maeh!\",\"I feel you\'re getting sleepy! Maeh!\"]', '[\"invisible\"]', 0, 0, 'blood', '[{\"id\":2148,\"count\":\"60\",\"chance\":\"75000\"}]'),
(1673, 0, 'Evil Sheep', 0, 240, 350, 15, 0, '[\"Grrrr\"]', '[\"lifedrain\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":2148,\"count\":\"50\",\"chance\":\"50000\"}]'),
(1674, 0, 'Execowtioner', 0, 2400, 3500, 25, 0, '[\"I\'m the one who puts the cute into execute!\",\"I\'m here to punish!\",\"Justice is swift and unavoidable!\",\"I\'ll bring justice!\",\"There is excellence in execution!\",\"Your sentence is death!\"]', '[\"paralyze\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2148\",\"count\":\"100\",\"chance\":\"100000\"},{\"id\":\"2148\",\"count\":\"98\",\"chance\":\"100000\"},{\"id\":\"2152\",\"count\":\"3\",\"chance\":\"67610\"},{\"id\":\"9971\",\"count\":1,\"chance\":\"390\"},{\"id\":\"5911\",\"count\":1,\"chance\":\"3230\"},{\"id\":\"5878\",\"count\":1,\"chance\":\"14710\"},{\"id\":\"12428\",\"count\":\"2\",\"chance\":\"6580\"},{\"id\":\"23572\",\"count\":1,\"chance\":\"13160\"},{\"id\":\"7591\",\"count\":1,\"chance\":\"11480\"},{\"id\":\"7590\",\"count\":1,\"chance\":\"10060\"},{\"id\":\"2666\",\"count\":1,\"chance\":\"7230\"},{\"id\":\"9970\",\"count\":\"2\",\"chance\":\"5810\"},{\"id\":\"2147\",\"count\":\"2\",\"chance\":\"4520\"},{\"id\":\"7412\",\"count\":1,\"chance\":\"900\"},{\"id\":\"2487\",\"count\":1,\"chance\":\"770\"},{\"id\":\"23547\",\"count\":1,\"chance\":\"1420\"},{\"id\":\"2430\",\"count\":1,\"chance\":\"770\"},{\"id\":\"7413\",\"count\":1,\"chance\":\"390\"},{\"id\":\"7401\",\"count\":1,\"chance\":\"520\"}]'),
(1675, 0, 'Eye of the Seven', 0, 0, 1, 1, 0, '[]', '[\"physical\",\"energy\",\"fire\",\"earth\",\"drown\",\"ice\",\"holy\",\"death\",\"lifedrain\",\"manadrain\",\"paralyze\",\"drunk\",\"outfit\"]', 0, 0, 'venom', '[]'),
(1676, 0, 'Fallen Mooh\'tah Master Ghar', 0, 4400, 7990, 1, 0, '[\"I will finish you!\",\"You are no match for a master of the Mooh\'Tha!\",\"I might be fallen but you will fall before me!\"]', '[\"outfit\",\"drunk\",\"invisible\"]', 0, 0, 'blood', '[]'),
(1677, 0, 'Fatality', 0, 3250, 6000, 1, 0, '[]', '[\"earth\",\"invisible\"]', 0, 0, 'blood', '[]'),
(1678, 0, 'Fernfang', 0, 600, 400, 10, 1, '[\"You desecrated this place!\",\"I will cleanse this isle!\",\"Grrrrrrr\",\"Yoooohhuuuu!\"]', '[\"invisible\",\"lifedrain\"]', 0, 0, 'blood', '[{\"id\":2148,\"count\":\"94\",\"chance\":\"100000\"},{\"id\":10563,\"count\":1,\"chance\":\"100000\"},{\"id\":2152,\"count\":\"3\",\"chance\":\"97000\"},{\"id\":2800,\"count\":1,\"chance\":\"92000\"},{\"id\":12448,\"count\":1,\"chance\":\"56000\"},{\"id\":2154,\"count\":1,\"chance\":\"43000\"},{\"id\":12449,\"count\":1,\"chance\":\"41000\"},{\"id\":2166,\"count\":1,\"chance\":\"41000\"},{\"id\":2260,\"count\":1,\"chance\":\"17000\"},{\"id\":2015,\"count\":1,\"chance\":\"12000\"},{\"id\":2689,\"count\":1,\"chance\":\"12000\"},{\"id\":\"2044\",\"count\":1,\"chance\":\"12000\"},{\"id\":\"2401\",\"count\":1,\"chance\":\"12000\"},{\"id\":2652,\"count\":1,\"chance\":\"12000\"},{\"id\":7589,\"count\":1,\"chance\":\"10200\"},{\"id\":5786,\"count\":1,\"chance\":\"7600\"},{\"id\":2802,\"count\":1,\"chance\":\"5100\"},{\"id\":2129,\"count\":1,\"chance\":\"5100\"},{\"id\":2177,\"count\":1,\"chance\":\"2500\"}]'),
(1679, 0, 'Ferumbras Mortal Shell', 0, 100000, 300000, 85, 1, '[\"INSECTS!\",\"I\' STILL POWERFUL ENOUGH TO CRUSH YOU!\",\"If you strike me down, I shall become more powerful than you could possibly imagine!\"]', '[\"lifedrain\",\"paralyze\",\"outfit\",\"drunk\",\"invisible\"]', 0, 0, 'venom', '[{\"id\":\"7895\",\"count\":1,\"chance\":\"800\"},{\"id\":\"8869\",\"count\":1,\"chance\":\"400\"},{\"id\":\"2146\",\"count\":\"10\",\"chance\":\"10000\"},{\"id\":\"7416\",\"count\":1,\"chance\":\"800\"},{\"id\":\"7427\",\"count\":1,\"chance\":\"800\"},{\"id\":\"2466\",\"count\":1,\"chance\":\"800\"},{\"id\":\"8930\",\"count\":1,\"chance\":\"400\"},{\"id\":\"25429\",\"count\":1,\"chance\":\"800\"},{\"id\":\"2148\",\"count\":\"100\",\"chance\":\"100000\"},{\"id\":\"2149\",\"count\":\"10\",\"chance\":\"10000\"},{\"id\":\"7632\",\"count\":1,\"chance\":\"1000\"},{\"id\":\"2156\",\"count\":1,\"chance\":\"1000\"},{\"id\":\"8868\",\"count\":1,\"chance\":\"300\"},{\"id\":\"2127\",\"count\":1,\"chance\":\"1000\"},{\"id\":\"7423\",\"count\":1,\"chance\":\"300\"},{\"id\":\"2150\",\"count\":\"10\",\"chance\":\"10000\"},{\"id\":\"25420\",\"count\":1,\"chance\":\"800\"},{\"id\":\"7422\",\"count\":1,\"chance\":\"800\"},{\"id\":\"2143\",\"count\":\"5\",\"chance\":\"10000\"},{\"id\":\"7418\",\"count\":1,\"chance\":\"600\"},{\"id\":\"2539\",\"count\":1,\"chance\":\"800\"},{\"id\":\"2520\",\"count\":1,\"chance\":\"800\"},{\"id\":\"25521\",\"count\":1,\"chance\":\"150\"},{\"id\":\"2148\",\"count\":\"100\",\"chance\":\"100000\"},{\"id\":\"7896\",\"count\":1,\"chance\":\"800\"},{\"id\":\"2472\",\"count\":1,\"chance\":\"400\"},{\"id\":\"25414\",\"count\":1,\"chance\":\"100\"},{\"id\":\"7403\",\"count\":1,\"chance\":\"800\"},{\"id\":\"25522\",\"count\":1,\"chance\":\"500\"},{\"id\":\"8926\",\"count\":1,\"chance\":\"300\"},{\"id\":\"25387\",\"count\":1,\"chance\":\"3000\"},{\"id\":\"7410\",\"count\":1,\"chance\":\"800\"},{\"id\":\"2158\",\"count\":1,\"chance\":\"800\"},{\"id\":\"2152\",\"count\":\"25\",\"chance\":\"100000\"},{\"id\":\"8928\",\"count\":1,\"chance\":\"400\"},{\"id\":\"7414\",\"count\":1,\"chance\":\"800\"},{\"id\":\"5903\",\"count\":1,\"chance\":\"100\"},{\"id\":\"25425\",\"count\":1,\"chance\":\"800\"},{\"id\":\"7382\",\"count\":1,\"chance\":\"800\"},{\"id\":\"2155\",\"count\":1,\"chance\":\"4000\"},{\"id\":\"2514\",\"count\":1,\"chance\":\"600\"},{\"id\":\"7435\",\"count\":1,\"chance\":\"800\"},{\"id\":\"25172\",\"count\":\"3\",\"chance\":\"100000\"},{\"id\":\"2144\",\"count\":\"5\",\"chance\":\"10000\"},{\"id\":\"2145\",\"count\":\"10\",\"chance\":\"10000\"},{\"id\":\"25427\",\"count\":1,\"chance\":\"800\"},{\"id\":\"9970\",\"count\":\"10\",\"chance\":\"10000\"},{\"id\":\"25423\",\"count\":1,\"chance\":\"800\"},{\"id\":\"25523\",\"count\":1,\"chance\":\"500\"},{\"id\":\"8885\",\"count\":1,\"chance\":\"800\"},{\"id\":\"2415\",\"count\":1,\"chance\":\"700\"},{\"id\":\"2522\",\"count\":1,\"chance\":\"100\"},{\"id\":\"7894\",\"count\":1,\"chance\":\"800\"},{\"id\":\"9971\",\"count\":1,\"chance\":\"800\"},{\"id\":\"7405\",\"count\":1,\"chance\":\"800\"},{\"id\":\"7411\",\"count\":1,\"chance\":\"400\"},{\"id\":\"25393\",\"count\":1,\"chance\":\"3500\"}]'),
(1680, 0, 'Ferumbras', 0, 35000, 90000, 50, 1, '[\"NOONE WILL STOP ME THIS TIME!\",\"THE POWER IS MINE!\",\"I returned from death and you dream about defeating me?\",\"Witness the first seconds of my eternal world domination!\",\"Even in my weakened state I will crush you all!\"]', '[\"earth\",\"lifedrain\",\"paralyze\",\"outfit\",\"drunk\",\"invisible\"]', 0, 0, 'venom', '[{\"id\":\"5903\",\"count\":1,\"chance\":\"100000\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"97000\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"97000\"},{\"id\":2148,\"count\":\"70\",\"chance\":\"33000\"},{\"id\":9971,\"count\":\"2\",\"chance\":\"75000\"},{\"id\":2522,\"count\":1,\"chance\":\"26000\"},{\"id\":8903,\"count\":1,\"chance\":\"26000\"},{\"id\":2466,\"count\":1,\"chance\":\"24000\"},{\"id\":2470,\"count\":1,\"chance\":\"22000\"},{\"id\":8902,\"count\":1,\"chance\":\"22000\"},{\"id\":8868,\"count\":1,\"chance\":\"22000\"},{\"id\":2520,\"count\":1,\"chance\":\"20000\"},{\"id\":8885,\"count\":1,\"chance\":\"20000\"},{\"id\":7894,\"count\":1,\"chance\":\"20000\"},{\"id\":2542,\"count\":1,\"chance\":\"20000\"},{\"id\":2127,\"count\":1,\"chance\":\"18000\"},{\"id\":7896,\"count\":1,\"chance\":\"18000\"},{\"id\":7895,\"count\":1,\"chance\":\"18000\"},{\"id\":2539,\"count\":1,\"chance\":\"18000\"},{\"id\":8918,\"count\":1,\"chance\":\"18000\"},{\"id\":7885,\"count\":1,\"chance\":\"18000\"},{\"id\":8930,\"count\":1,\"chance\":\"16000\"},{\"id\":7405,\"count\":1,\"chance\":\"16000\"},{\"id\":7451,\"count\":1,\"chance\":\"16000\"},{\"id\":2149,\"count\":\"100\",\"chance\":\"16000\"},{\"id\":\"7632\",\"count\":\"5\",\"chance\":\"14000\"},{\"id\":\"7633\",\"count\":\"5\",\"chance\":\"14000\"},{\"id\":2472,\"count\":1,\"chance\":\"14000\"},{\"id\":\"2514\",\"count\":1,\"chance\":\"14000\"},{\"id\":7417,\"count\":1,\"chance\":\"14000\"},{\"id\":8904,\"count\":1,\"chance\":\"14000\"},{\"id\":7427,\"count\":1,\"chance\":\"12000\"},{\"id\":8926,\"count\":1,\"chance\":\"12000\"},{\"id\":8869,\"count\":1,\"chance\":\"12000\"},{\"id\":2146,\"count\":\"98\",\"chance\":\"12000\"},{\"id\":2143,\"count\":\"88\",\"chance\":\"12000\"},{\"id\":7407,\"count\":1,\"chance\":\"10000\"},{\"id\":8924,\"count\":1,\"chance\":\"10000\"},{\"id\":8928,\"count\":1,\"chance\":\"10000\"},{\"id\":7411,\"count\":1,\"chance\":\"10000\"},{\"id\":7410,\"count\":1,\"chance\":\"10000\"},{\"id\":2150,\"count\":\"54\",\"chance\":\"10000\"},{\"id\":9970,\"count\":\"87\",\"chance\":\"10000\"},{\"id\":7382,\"count\":1,\"chance\":\"8100\"},{\"id\":7422,\"count\":1,\"chance\":\"8100\"},{\"id\":2152,\"count\":\"58\",\"chance\":\"8100\"},{\"id\":7423,\"count\":1,\"chance\":\"8100\"},{\"id\":5944,\"count\":\"9\",\"chance\":\"8100\"},{\"id\":7388,\"count\":1,\"chance\":\"8100\"},{\"id\":7414,\"count\":1,\"chance\":\"6100\"},{\"id\":7403,\"count\":1,\"chance\":\"6100\"},{\"id\":2144,\"count\":\"83\",\"chance\":\"6100\"},{\"id\":7416,\"count\":1,\"chance\":\"6100\"},{\"id\":7418,\"count\":1,\"chance\":\"6100\"},{\"id\":2415,\"count\":1,\"chance\":\"4000\"},{\"id\":7435,\"count\":1,\"chance\":\"4000\"},{\"id\":1986,\"count\":1,\"chance\":\"4000\"},{\"id\":2145,\"count\":\"82\",\"chance\":\"4000\"},{\"id\":2147,\"count\":\"92\",\"chance\":\"4000\"}]'),
(1681, 0, 'Feverish Citizen', 0, 30, 125, 1, 0, '[\"Aaaaargh!\",\"I am the king of the world!\",\"Die Ferumbras!\",\"Tigerblood is running through my veins!\",\"You! It\'s you again!\",\"Stand still you tasty morsel!\",\"<giggle>\",\"Burn heretic! Burn!\",\"Harrr!\",\"This is Venore!\"]', '[]', 0, 0, 'blood', '[{\"id\":2148,\"count\":\"35\",\"chance\":\"30300\"},{\"id\":\"2230\",\"count\":1,\"chance\":\"4920\"},{\"id\":3976,\"count\":\"3\",\"chance\":\"25730\"},{\"id\":13540,\"count\":1,\"chance\":\"1660\"},{\"id\":13541,\"count\":1,\"chance\":\"1720\"},{\"id\":13542,\"count\":1,\"chance\":\"2290\"},{\"id\":13543,\"count\":1,\"chance\":\"2006\"},{\"id\":13544,\"count\":1,\"chance\":\"2060\"},{\"id\":13545,\"count\":1,\"chance\":\"2290\"},{\"id\":13925,\"count\":1,\"chance\":\"100\"},{\"id\":13926,\"count\":1,\"chance\":\"100\"}]'),
(1682, 0, 'Feversleep', 0, 4400, 5900, 25, 0, '[]', '[\"earth\",\"paralyze\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":2148,\"count\":\"100\",\"chance\":\"100000\"},{\"id\":2149,\"count\":\"2\",\"chance\":\"11000\"},{\"id\":2150,\"count\":\"3\",\"chance\":\"12000\"},{\"id\":2152,\"count\":\"9\",\"chance\":\"100000\"},{\"id\":2656,\"count\":1,\"chance\":\"1500\"},{\"id\":7590,\"count\":\"2\",\"chance\":\"40000\"},{\"id\":8473,\"count\":1,\"chance\":\"18000\"},{\"id\":9970,\"count\":\"2\",\"chance\":\"16000\"},{\"id\":18413,\"count\":1,\"chance\":\"11000\"},{\"id\":18418,\"count\":1,\"chance\":\"13000\"},{\"id\":18419,\"count\":1,\"chance\":\"18000\"},{\"id\":22537,\"count\":1,\"chance\":\"17000\"},{\"id\":22538,\"count\":1,\"chance\":\"14000\"}]'),
(1683, 0, 'Filth Toad', 0, 90, 185, 1, 1, '[\"Ribbit, ribbit!\",\"Ribbit!\"]', '[]', 0, 0, 'blood', '[{\"id\":2148,\"count\":\"21\",\"chance\":\"75000\"},{\"id\":2377,\"count\":1,\"chance\":\"500\"},{\"id\":2398,\"count\":1,\"chance\":\"2000\"},{\"id\":\"2667\",\"count\":1,\"chance\":\"22000\"},{\"id\":10557,\"count\":1,\"chance\":\"3000\"}]'),
(1684, 0, 'Fire Devil', 530, 145, 200, 1, 0, '[\"Hot, eh?\",\"Hell, oh, hell!\"]', '[\"fire\"]', 1, 1, 'blood', '[{\"id\":12469,\"count\":1,\"chance\":\"19770\"},{\"id\":2260,\"count\":1,\"chance\":\"11000\"},{\"id\":\"2419\",\"count\":1,\"chance\":\"3000\"},{\"id\":\"2050\",\"count\":\"2\",\"chance\":\"1370\"},{\"id\":2387,\"count\":1,\"chance\":\"1200\"},{\"id\":2568,\"count\":1,\"chance\":\"920\"},{\"id\":2185,\"count\":1,\"chance\":\"460\"},{\"id\":2150,\"count\":1,\"chance\":\"280\"},{\"id\":2515,\"count\":1,\"chance\":\"210\"}]'),
(1685, 0, 'Fire Elemental', 690, 220, 280, 1, 0, '[]', '[\"death\",\"fire\",\"lifedrain\",\"paralyze\",\"invisible\"]', 1, 0, 'fire', '[]'),
(1686, 0, 'Fire Overlord', 0, 2800, 4000, 40, 0, '[]', '[\"fire\"]', 0, 0, 'fire', '[{\"id\":2148,\"count\":\"75\",\"chance\":\"50000\"},{\"id\":2152,\"count\":\"3\",\"chance\":\"50000\"},{\"id\":7899,\"count\":1,\"chance\":\"819\"},{\"id\":8304,\"count\":1,\"chance\":\"100000\"},{\"id\":10553,\"count\":1,\"chance\":\"100000\"}]'),
(1687, 0, 'Firestarter', 0, 80, 180, 1, 0, '[\"FIRE!\",\"BURN!\",\"DEATH to the FALSE GOD!!\",\"You shall burn in the thornfires!!\",\"DOWN with the followers of the bog!!\"]', '[\"fire\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":2148,\"count\":\"35\",\"chance\":\"79000\"},{\"id\":2397,\"count\":1,\"chance\":\"6000\"},{\"id\":2456,\"count\":1,\"chance\":\"4000\"},{\"id\":2681,\"count\":1,\"chance\":\"20000\"},{\"id\":\"5921\",\"count\":1,\"chance\":\"930\"},{\"id\":7438,\"count\":1,\"chance\":\"100\"},{\"id\":7840,\"count\":\"12\",\"chance\":\"30000\"},{\"id\":10552,\"count\":1,\"chance\":\"5000\"},{\"id\":\"13757\",\"count\":1,\"chance\":\"15280\"},{\"id\":13943,\"count\":1,\"chance\":\"340\"}]'),
(1688, 0, 'Fish', 0, 0, 25, 1, 0, '[\"Blib!\",\"Blub!\"]', '[\"fire\",\"earth\",\"invisible\",\"drown\"]', 0, 0, 'undead', '[]'),
(1689, 0, 'Flamethrower', 0, 0, 1, 1, 0, '[]', '[\"physical\",\"energy\",\"fire\",\"earth\",\"drown\",\"ice\",\"holy\",\"death\",\"lifedrain\",\"manadrain\",\"paralyze\",\"drunk\",\"outfit\",\"invisible\"]', 0, 0, 'undead', '[]'),
(1690, 0, 'Flamingo', 250, 0, 25, 1, 0, '[]', '[]', 1, 1, 'blood', '[{\"id\":12640,\"count\":1,\"chance\":\"1000\"}]'),
(1691, 0, 'Fleshslicer', 0, 5500, 5700, 70, 1, '[]', '[\"earth\",\"invisible\"]', 0, 0, 'venom', '[{\"id\":\"15486\",\"count\":\"2\",\"chance\":\"100000\"},{\"id\":\"2148\",\"count\":\"185\",\"chance\":\"100000\"},{\"id\":\"2152\",\"count\":\"5\",\"chance\":\"100000\"},{\"id\":\"15485\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"7590\",\"count\":\"2\",\"chance\":\"82353\"},{\"id\":\"16096\",\"count\":\"2\",\"chance\":\"76471\"},{\"id\":\"2147\",\"count\":\"5\",\"chance\":\"35294\"},{\"id\":\"3964\",\"count\":1,\"chance\":\"29412\"},{\"id\":\"2143\",\"count\":\"5\",\"chance\":\"29412\"},{\"id\":\"2156\",\"count\":1,\"chance\":\"23529\"},{\"id\":\"8473\",\"count\":1,\"chance\":\"17647\"},{\"id\":\"7632\",\"count\":1,\"chance\":\"11765\"},{\"id\":\"7413\",\"count\":1,\"chance\":\"11765\"},{\"id\":\"6300\",\"count\":1,\"chance\":\"5882\"}]'),
(1692, 0, 'Floor Blob', 0, 0, 1, 1, 0, '[]', '[\"physical\",\"energy\",\"fire\",\"earth\",\"drown\",\"ice\",\"holy\",\"death\",\"lifedrain\",\"manadrain\",\"paralyze\",\"drunk\",\"outfit\",\"invisible\"]', 0, 0, 'venom', '[]'),
(1693, 0, 'Fluffy', 0, 3550, 4500, 45, 0, '[\"Wooof!\"]', '[\"drunk\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":2148,\"count\":\"100\",\"chance\":\"100000\"},{\"id\":2148,\"count\":\"20\",\"chance\":\"100000\"},{\"id\":\"2230\",\"count\":1,\"chance\":\"25000\"},{\"id\":2383,\"count\":1,\"chance\":\"2500\"},{\"id\":2430,\"count\":1,\"chance\":\"2857\"},{\"id\":\"2671\",\"count\":\"8\",\"chance\":\"50000\"},{\"id\":5944,\"count\":1,\"chance\":\"5555\"},{\"id\":6500,\"count\":1,\"chance\":\"7200\"},{\"id\":\"6558\",\"count\":1,\"chance\":\"8888\"},{\"id\":\"6570\",\"count\":\"4\",\"chance\":\"5538\"},{\"id\":\"6571\",\"count\":1,\"chance\":\"1538\"}]'),
(1694, 0, 'Foreman Kneebiter', 0, 445, 570, 1, 0, '[]', '[\"invisible\"]', 0, 0, 'blood', '[{\"id\":2148,\"count\":\"100\",\"chance\":\"90000\"},{\"id\":2513,\"count\":1,\"chance\":\"6666\"},{\"id\":5880,\"count\":\"2\",\"chance\":\"2500\"}]'),
(1695, 0, 'Forest Fury', 0, 235, 480, 1, 0, '[\"To arms, sisters!\",\"Feel the wrath of mother forest!\",\"By the power of Greenskull!\"]', '[]', 0, 0, 'blood', '[{\"id\":\"2148\",\"count\":\"55\",\"chance\":\"87797\"},{\"id\":\"2543\",\"count\":\"15\",\"chance\":\"50567\"},{\"id\":\"2666\",\"count\":1,\"chance\":\"24975\"},{\"id\":\"7363\",\"count\":\"5\",\"chance\":\"14846\"},{\"id\":\"21312\",\"count\":1,\"chance\":\"12036\"},{\"id\":\"21311\",\"count\":1,\"chance\":\"7445\"},{\"id\":\"2455\",\"count\":1,\"chance\":\"2579\"},{\"id\":\"9970\",\"count\":1,\"chance\":\"482\"},{\"id\":\"7438\",\"count\":1,\"chance\":\"79\"}]'),
(1696, 0, 'Frazzlemaw', 0, 3400, 4100, 90, 0, '[\"Mwaaahgod! Overmwaaaaah! *gurgle*\",\"Mwaaaahnducate youuuuuu *gurgle*, mwaaah!\",\"MMMWAHMWAHMWAHMWAAAAH!\",\"Mmmwhamwhamwhah, mwaaah!\"]', '[\"paralyze\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2152\",\"count\":\"7\",\"chance\":\"90539\"},{\"id\":\"2148\",\"count\":\"100\",\"chance\":\"78242\"},{\"id\":\"22532\",\"count\":1,\"chance\":\"14245\"},{\"id\":\"22533\",\"count\":1,\"chance\":\"12119\"},{\"id\":\"7590\",\"count\":\"3\",\"chance\":\"12048\"},{\"id\":\"18417\",\"count\":1,\"chance\":\"11977\"},{\"id\":\"7591\",\"count\":\"2\",\"chance\":\"11836\"},{\"id\":\"2226\",\"count\":1,\"chance\":\"10064\"},{\"id\":\"2229\",\"count\":1,\"chance\":\"9497\"},{\"id\":\"5951\",\"count\":1,\"chance\":\"8717\"},{\"id\":\"2230\",\"count\":1,\"chance\":\"8079\"},{\"id\":\"2225\",\"count\":1,\"chance\":\"7760\"},{\"id\":\"2240\",\"count\":1,\"chance\":\"7548\"},{\"id\":\"18554\",\"count\":1,\"chance\":\"7512\"},{\"id\":\"2219\",\"count\":1,\"chance\":\"7335\"},{\"id\":\"2667\",\"count\":\"3\",\"chance\":\"5067\"},{\"id\":\"5895\",\"count\":1,\"chance\":\"4465\"},{\"id\":\"2671\",\"count\":1,\"chance\":\"4394\"},{\"id\":\"18420\",\"count\":1,\"chance\":\"4146\"},{\"id\":\"5925\",\"count\":1,\"chance\":\"3792\"},{\"id\":\"2231\",\"count\":1,\"chance\":\"3650\"},{\"id\":\"5880\",\"count\":1,\"chance\":\"2729\"},{\"id\":\"18414\",\"count\":1,\"chance\":\"2516\"},{\"id\":\"2377\",\"count\":1,\"chance\":\"2303\"},{\"id\":\"9971\",\"count\":1,\"chance\":\"1914\"},{\"id\":\"7407\",\"count\":1,\"chance\":\"1453\"},{\"id\":\"11306\",\"count\":1,\"chance\":\"886\"},{\"id\":\"22396\",\"count\":1,\"chance\":\"532\"},{\"id\":\"7418\",\"count\":1,\"chance\":\"532\"},{\"id\":\"7404\",\"count\":1,\"chance\":\"390\"}]');
INSERT INTO `myaac_monsters` (`id`, `hidden`, `name`, `mana`, `exp`, `health`, `speed_lvl`, `use_haste`, `voices`, `immunities`, `summonable`, `convinceable`, `race`, `loot`) VALUES
(1697, 0, 'Freegoiz', 0, 35000, 80000, 80, 1, '[\"BOW TO THE POWER OF THE RUTHLESS SEVEN!\",\"DESTRUCTION!\",\"CHAOS!\",\"DEATH TO ALL!\"]', '[\"energy\",\"fire\",\"earth\",\"lifedrain\",\"paralyze\",\"outfit\",\"drunk\",\"invisible\"]', 0, 0, 'fire', '[{\"id\":1982,\"count\":1,\"chance\":\"2600\"},{\"id\":2033,\"count\":1,\"chance\":\"7500\"},{\"id\":2112,\"count\":1,\"chance\":\"14500\"},{\"id\":2123,\"count\":1,\"chance\":\"3500\"},{\"id\":\"2124\",\"count\":1,\"chance\":\"5500\"},{\"id\":2125,\"count\":1,\"chance\":\"1500\"},{\"id\":\"2142\",\"count\":1,\"chance\":\"3500\"},{\"id\":2143,\"count\":\"15\",\"chance\":\"12500\"},{\"id\":2144,\"count\":\"15\",\"chance\":\"15000\"},{\"id\":2145,\"count\":\"5\",\"chance\":\"9500\"},{\"id\":2146,\"count\":\"10\",\"chance\":\"13500\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"99900\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"88800\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"77700\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"66600\"},{\"id\":2149,\"count\":\"10\",\"chance\":\"15500\"},{\"id\":2150,\"count\":\"20\",\"chance\":\"13500\"},{\"id\":2151,\"count\":\"7\",\"chance\":\"14000\"},{\"id\":2155,\"count\":1,\"chance\":\"1500\"},{\"id\":2158,\"count\":1,\"chance\":\"1500\"},{\"id\":\"2162\",\"count\":1,\"chance\":\"11500\"},{\"id\":2164,\"count\":1,\"chance\":\"5000\"},{\"id\":2165,\"count\":1,\"chance\":\"9500\"},{\"id\":2167,\"count\":1,\"chance\":\"13500\"},{\"id\":2170,\"count\":1,\"chance\":\"13000\"},{\"id\":2171,\"count\":1,\"chance\":\"4500\"},{\"id\":2174,\"count\":1,\"chance\":\"2500\"},{\"id\":2176,\"count\":1,\"chance\":\"12000\"},{\"id\":2177,\"count\":1,\"chance\":\"1000\"},{\"id\":\"2178\",\"count\":1,\"chance\":\"4000\"},{\"id\":2179,\"count\":1,\"chance\":\"8000\"},{\"id\":2182,\"count\":1,\"chance\":\"3500\"},{\"id\":2185,\"count\":1,\"chance\":\"3500\"},{\"id\":2186,\"count\":1,\"chance\":\"3500\"},{\"id\":2188,\"count\":1,\"chance\":\"2500\"},{\"id\":\"2192\",\"count\":1,\"chance\":\"2500\"},{\"id\":2195,\"count\":1,\"chance\":\"4000\"},{\"id\":2197,\"count\":1,\"chance\":\"4000\"},{\"id\":2200,\"count\":1,\"chance\":\"4500\"},{\"id\":2214,\"count\":1,\"chance\":\"13000\"},{\"id\":\"2231\",\"count\":1,\"chance\":\"9000\"},{\"id\":2377,\"count\":1,\"chance\":\"20000\"},{\"id\":2387,\"count\":1,\"chance\":\"20000\"},{\"id\":2393,\"count\":1,\"chance\":\"12500\"},{\"id\":2396,\"count\":1,\"chance\":\"7500\"},{\"id\":2402,\"count\":1,\"chance\":\"15500\"},{\"id\":2418,\"count\":1,\"chance\":\"4500\"},{\"id\":2421,\"count\":1,\"chance\":\"13500\"},{\"id\":2432,\"count\":1,\"chance\":\"17000\"},{\"id\":2434,\"count\":1,\"chance\":\"4500\"},{\"id\":2436,\"count\":1,\"chance\":\"5000\"},{\"id\":2462,\"count\":1,\"chance\":\"11000\"},{\"id\":2470,\"count\":1,\"chance\":\"5000\"},{\"id\":2472,\"count\":1,\"chance\":\"3000\"},{\"id\":\"2514\",\"count\":1,\"chance\":\"7500\"},{\"id\":2520,\"count\":1,\"chance\":\"15500\"},{\"id\":\"3955\",\"count\":1,\"chance\":\"100\"}]'),
(1698, 0, 'Frost Dragon Hatchling', 0, 745, 800, 1, 0, '[\"Rooawwrr\",\"Fchu?\"]', '[\"fire\",\"lifedrain\",\"ice\",\"earth\",\"invisible\"]', 0, 0, 'undead', '[{\"id\":2148,\"count\":\"55\",\"chance\":\"86750\"},{\"id\":2672,\"count\":1,\"chance\":\"79600\"},{\"id\":7618,\"count\":1,\"chance\":\"560\"},{\"id\":8900,\"count\":1,\"chance\":\"400\"},{\"id\":10578,\"count\":1,\"chance\":\"5000\"}]'),
(1699, 0, 'Frost Dragon', 0, 2100, 1800, 1, 1, '[\"YOU WILL FREEZE!\",\"ZCHHHHH!\",\"I am so cool.\",\"Chill out!\"]', '[\"lifedrain\",\"paralyze\",\"invisible\",\"fire\",\"ice\",\"earth\"]', 0, 0, 'undead', '[{\"id\":\"2148\",\"count\":\"243\",\"chance\":\"95017\"},{\"id\":\"2672\",\"count\":1,\"chance\":\"79868\"},{\"id\":\"2796\",\"count\":1,\"chance\":\"12151\"},{\"id\":\"1976\",\"count\":1,\"chance\":\"8835\"},{\"id\":\"2547\",\"count\":\"6\",\"chance\":\"5895\"},{\"id\":\"2146\",\"count\":1,\"chance\":\"5092\"},{\"id\":\"2167\",\"count\":1,\"chance\":\"4952\"},{\"id\":\"7441\",\"count\":1,\"chance\":\"4089\"},{\"id\":\"2033\",\"count\":1,\"chance\":\"3081\"},{\"id\":\"2177\",\"count\":1,\"chance\":\"608\"},{\"id\":\"7290\",\"count\":1,\"chance\":\"524\"},{\"id\":\"2479\",\"count\":1,\"chance\":\"453\"},{\"id\":\"2396\",\"count\":1,\"chance\":\"342\"},{\"id\":\"2528\",\"count\":1,\"chance\":\"291\"},{\"id\":\"2498\",\"count\":1,\"chance\":\"206\"},{\"id\":\"2492\",\"count\":1,\"chance\":\"111\"},{\"id\":\"7402\",\"count\":1,\"chance\":\"97\"}]'),
(1700, 0, 'Frost Giant', 490, 150, 270, 1, 1, '[\"Hmm Humansoup!\",\"Stand still ya tasy snack!\",\"Joh Thun!\",\"H\\u00f6rre Sjan Flan!\",\"Br\\u00f6re Sm\\u00f6de!\",\"Forle Bramma\"]', '[\"ice\"]', 0, 1, 'blood', '[{\"id\":\"2148\",\"count\":\"40\",\"chance\":\"82076\"},{\"id\":\"2406\",\"count\":1,\"chance\":\"8228\"},{\"id\":\"10575\",\"count\":1,\"chance\":\"4926\"},{\"id\":\"2666\",\"count\":1,\"chance\":\"4919\"},{\"id\":\"7441\",\"count\":1,\"chance\":\"2204\"},{\"id\":\"2513\",\"count\":1,\"chance\":\"1386\"},{\"id\":\"7618\",\"count\":1,\"chance\":\"905\"},{\"id\":\"2381\",\"count\":1,\"chance\":\"556\"},{\"id\":\"7460\",\"count\":1,\"chance\":\"287\"},{\"id\":\"2490\",\"count\":1,\"chance\":\"169\"},{\"id\":\"2209\",\"count\":1,\"chance\":\"119\"},{\"id\":\"7290\",\"count\":1,\"chance\":\"62\"}]'),
(1701, 0, 'Frost Giantess', 490, 150, 275, 1, 1, '[\"Ymirs Mjalle!\",\"No run so much, must stay fat!\",\"H\\u00f6rre Sjan Flan!\",\"Damned fast food.\",\"Come kiss the cook!\"]', '[\"ice\"]', 0, 1, 'blood', '[{\"id\":\"2148\",\"count\":\"40\",\"chance\":\"82053\"},{\"id\":\"2671\",\"count\":1,\"chance\":\"20794\"},{\"id\":\"1294\",\"count\":\"3\",\"chance\":\"10397\"},{\"id\":\"2406\",\"count\":1,\"chance\":\"7946\"},{\"id\":\"10575\",\"count\":1,\"chance\":\"4953\"},{\"id\":\"7441\",\"count\":1,\"chance\":\"2093\"},{\"id\":\"2513\",\"count\":1,\"chance\":\"1532\"},{\"id\":\"7620\",\"count\":1,\"chance\":\"945\"},{\"id\":\"7460\",\"count\":1,\"chance\":\"287\"},{\"id\":\"2490\",\"count\":1,\"chance\":\"172\"},{\"id\":\"7290\",\"count\":1,\"chance\":\"102\"},{\"id\":\"2209\",\"count\":1,\"chance\":\"70\"}]'),
(1702, 0, 'Frost Troll', 300, 23, 55, 1, 0, '[\"Brrr\",\"Broar!\"]', '[]', 1, 1, 'blood', '[{\"id\":\"2148\",\"count\":\"12\",\"chance\":\"50404\"},{\"id\":\"2389\",\"count\":1,\"chance\":\"20343\"},{\"id\":\"2667\",\"count\":1,\"chance\":\"18162\"},{\"id\":\"2384\",\"count\":1,\"chance\":\"15591\"},{\"id\":\"2512\",\"count\":1,\"chance\":\"15508\"},{\"id\":\"2245\",\"count\":1,\"chance\":\"8229\"},{\"id\":\"10565\",\"count\":1,\"chance\":\"2011\"},{\"id\":\"2651\",\"count\":1,\"chance\":\"1126\"}]'),
(1703, 0, 'Frostfur', 0, 35, 65, 1, 0, '[]', '[\"outfit\",\"drunk\",\"invisible\"]', 0, 0, 'blood', '[]'),
(1704, 0, 'Furious Orc Berserker', 220, 0, 15, 80, 0, '[]', '[]', 1, 1, 'blood', '[{\"id\":2666,\"count\":\"2\",\"chance\":\"20000\"},{\"id\":\"2684\",\"count\":\"2\",\"chance\":\"9000\"}]'),
(1705, 0, 'Furious Troll', 0, 185, 245, 1, 0, '[\"Slice! Slice!\",\"DIE!!!\"]', '[\"invisible\"]', 0, 0, 'blood', '[{\"id\":2148,\"count\":\"100\",\"chance\":\"47000\"},{\"id\":2148,\"count\":\"46\",\"chance\":\"47000\"},{\"id\":2152,\"count\":1,\"chance\":\"6000\"},{\"id\":2391,\"count\":1,\"chance\":\"750\"},{\"id\":10606,\"count\":1,\"chance\":\"4400\"}]'),
(1706, 0, 'Fury of the Emperor', 0, 26600, 28800, 115, 0, '[]', '[\"death\",\"earth\"]', 0, 0, 'undead', '[]'),
(1707, 0, 'Fury', 0, 4500, 4100, 15, 1, '[\"Ahhhhrrrr!\",\"Waaaaah!\",\"Carnage!\",\"Dieee!\"]', '[\"paralyze\",\"invisible\",\"fire\"]', 0, 0, 'blood', '[{\"id\":\"2120\",\"count\":\"3\",\"chance\":\"8000\"},{\"id\":\"2124\",\"count\":1,\"chance\":\"410\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"30000\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"30000\"},{\"id\":2148,\"count\":\"69\",\"chance\":\"38000\"},{\"id\":2152,\"count\":\"4\",\"chance\":\"2800\"},{\"id\":2181,\"count\":1,\"chance\":\"20000\"},{\"id\":2470,\"count\":1,\"chance\":\"130\"},{\"id\":2645,\"count\":1,\"chance\":\"790\"},{\"id\":2666,\"count\":1,\"chance\":\"25000\"},{\"id\":5022,\"count\":\"4\",\"chance\":\"1500\"},{\"id\":5911,\"count\":1,\"chance\":\"4000\"},{\"id\":5944,\"count\":1,\"chance\":\"21500\"},{\"id\":5944,\"count\":1,\"chance\":\"50\"},{\"id\":\"6301\",\"count\":1,\"chance\":\"60\"},{\"id\":6500,\"count\":1,\"chance\":\"22500\"},{\"id\":7404,\"count\":1,\"chance\":\"660\"},{\"id\":7456,\"count\":1,\"chance\":\"2000\"},{\"id\":7591,\"count\":1,\"chance\":\"10500\"},{\"id\":8844,\"count\":\"4\",\"chance\":\"29280\"},{\"id\":\"9813\",\"count\":1,\"chance\":\"1920\"}]'),
(1708, 0, 'Gang Member', 420, 70, 295, 1, 0, '[\"This is our territory!\",\"Help me guys!\",\"I don\'t like the way you look!\",\"You\'re wearing the wrong colours!\",\"Don\'t mess with us!\"]', '[]', 0, 1, 'blood', '[{\"id\":\"2148\",\"count\":\"30\",\"chance\":\"48971\"},{\"id\":\"2649\",\"count\":1,\"chance\":\"15541\"},{\"id\":\"2398\",\"count\":1,\"chance\":\"9182\"},{\"id\":\"2691\",\"count\":1,\"chance\":\"5251\"},{\"id\":\"2468\",\"count\":1,\"chance\":\"5040\"},{\"id\":\"2209\",\"count\":1,\"chance\":\"1029\"}]'),
(1709, 0, 'Gargoyle', 0, 150, 250, 1, 0, '[\"Harrrr Harrrr!\",\"Stone sweet stone.\",\"Feel my claws, softskin.\",\"Chhhhhrrrrk!\",\"There is a stone in your shoe!\"]', '[\"lifedrain\",\"earth\"]', 0, 0, 'undead', '[{\"id\":2148,\"count\":\"30\",\"chance\":\"88000\"},{\"id\":1294,\"count\":\"10\",\"chance\":\"15800\"},{\"id\":11195,\"count\":1,\"chance\":\"11730\"},{\"id\":8838,\"count\":\"2\",\"chance\":\"9220\"},{\"id\":2680,\"count\":\"5\",\"chance\":\"1910\"},{\"id\":2394,\"count\":1,\"chance\":\"1500\"},{\"id\":2513,\"count\":1,\"chance\":\"1300\"},{\"id\":2129,\"count\":1,\"chance\":\"1180\"},{\"id\":2457,\"count\":1,\"chance\":\"850\"},{\"id\":11343,\"count\":1,\"chance\":\"450\"},{\"id\":2489,\"count\":1,\"chance\":\"300\"},{\"id\":2209,\"count\":1,\"chance\":\"260\"},{\"id\":11227,\"count\":1,\"chance\":\"190\"}]'),
(1710, 0, 'Gaz\'haragoth', 0, 1000000, 350000, 90, 1, '[\"NO ONE WILL ESCAPE ME!\",\"I\'LL KEEP THE ORDER UP!\",\"You puny humans will be my snacks!\",\"I\'ve beaten tougher demons than you even know!\",\"How dare you come to this place!\"]', '[\"paralyze\",\"invisible\"]', 0, 0, 'fire', '[{\"id\":\"22396\",\"count\":\"13\",\"chance\":\"100000\"},{\"id\":\"2160\",\"count\":\"10\",\"chance\":\"100000\"},{\"id\":\"22397\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"11258\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"11262\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"11260\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"11261\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"11259\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"6500\",\"count\":1,\"chance\":\"92857\"},{\"id\":\"22598\",\"count\":\"3\",\"chance\":\"92857\"},{\"id\":\"5911\",\"count\":1,\"chance\":\"71429\"},{\"id\":\"5914\",\"count\":1,\"chance\":\"71429\"},{\"id\":\"18416\",\"count\":\"23\",\"chance\":\"50000\"},{\"id\":\"18413\",\"count\":\"22\",\"chance\":\"35714\"},{\"id\":\"8472\",\"count\":\"183\",\"chance\":\"35714\"},{\"id\":\"8473\",\"count\":\"119\",\"chance\":\"35714\"},{\"id\":\"2158\",\"count\":1,\"chance\":\"28571\"},{\"id\":\"5954\",\"count\":1,\"chance\":\"28571\"},{\"id\":\"7632\",\"count\":1,\"chance\":\"28571\"},{\"id\":\"7590\",\"count\":\"181\",\"chance\":\"28571\"},{\"id\":\"18415\",\"count\":\"20\",\"chance\":\"28571\"},{\"id\":\"6529\",\"count\":\"194\",\"chance\":\"28571\"},{\"id\":\"18418\",\"count\":\"27\",\"chance\":\"21429\"},{\"id\":\"18417\",\"count\":\"28\",\"chance\":\"21429\"},{\"id\":\"22401\",\"count\":1,\"chance\":\"21429\"},{\"id\":\"7368\",\"count\":\"109\",\"chance\":\"14286\"},{\"id\":\"22404\",\"count\":1,\"chance\":\"14286\"},{\"id\":\"22398\",\"count\":1,\"chance\":\"14286\"},{\"id\":\"22614\",\"count\":1,\"chance\":\"14286\"},{\"id\":\"2195\",\"count\":1,\"chance\":\"7143\"},{\"id\":\"22419\",\"count\":1,\"chance\":\"7143\"},{\"id\":\"22413\",\"count\":1,\"chance\":\"7143\"},{\"id\":\"22422\",\"count\":1,\"chance\":\"7143\"},{\"id\":\"22610\",\"count\":1,\"chance\":\"7143\"},{\"id\":\"22613\",\"count\":1,\"chance\":\"7143\"},{\"id\":\"2168\",\"count\":1,\"chance\":\"7143\"},{\"id\":\"7899\",\"count\":1,\"chance\":\"7143\"},{\"id\":\"22616\",\"count\":1,\"chance\":\"7143\"},{\"id\":\"22608\",\"count\":1,\"chance\":\"7143\"},{\"id\":\"22611\",\"count\":1,\"chance\":\"7143\"},{\"id\":\"22408\",\"count\":1,\"chance\":\"7143\"},{\"id\":\"22400\",\"count\":1,\"chance\":\"7143\"},{\"id\":\"18414\",\"count\":\"26\",\"chance\":\"7143\"}]'),
(1711, 0, 'Gazer', 0, 90, 120, 1, 0, '[\"Mommy!?\",\"Buuuuhaaaahhaaaaa!\",\"Me need mana!\"]', '[\"invisible\",\"earth\"]', 0, 0, 'venom', '[{\"id\":2148,\"count\":\"24\",\"chance\":\"99000\"},{\"id\":12468,\"count\":1,\"chance\":\"3330\"}]'),
(1712, 0, 'General Murius', 0, 450, 550, 10, 0, '[\"Feel the power of the Mooh\'Tah!\",\"You will get what you deserve!\",\"For the king!\",\"Guards!\"]', '[\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"12428\",\"count\":\"2\",\"chance\":\"100000\"},{\"id\":\"5878\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2148\",\"count\":\"97\",\"chance\":\"93333\"},{\"id\":\"2152\",\"count\":\"3\",\"chance\":\"93333\"},{\"id\":\"2387\",\"count\":1,\"chance\":\"80000\"},{\"id\":\"2465\",\"count\":1,\"chance\":\"66667\"},{\"id\":\"2513\",\"count\":1,\"chance\":\"33333\"},{\"id\":\"7363\",\"count\":\"11\",\"chance\":\"33333\"},{\"id\":\"2666\",\"count\":1,\"chance\":\"26667\"},{\"id\":\"2648\",\"count\":1,\"chance\":\"20000\"},{\"id\":\"7401\",\"count\":1,\"chance\":\"20000\"},{\"id\":\"2547\",\"count\":\"7\",\"chance\":\"20000\"},{\"id\":\"2580\",\"count\":1,\"chance\":\"6667\"},{\"id\":\"7588\",\"count\":1,\"chance\":\"6667\"}]'),
(1713, 0, 'Ghastly Dragon', 0, 4600, 7800, 50, 0, '[\"EMBRACE MY GIFTS!\",\"I WILL FEAST ON YOUR SOUL!\"]', '[\"paralyze\",\"invisible\",\"death\",\"earth\"]', 0, 0, 'undead', '[{\"id\":2148,\"count\":\"100\",\"chance\":\"33725\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"33725\"},{\"id\":2148,\"count\":\"66\",\"chance\":\"33725\"},{\"id\":2152,\"count\":\"2\",\"chance\":\"29840\"},{\"id\":5944,\"count\":1,\"chance\":\"12170\"},{\"id\":6500,\"count\":1,\"chance\":\"8920\"},{\"id\":7590,\"count\":\"2\",\"chance\":\"30560\"},{\"id\":7885,\"count\":1,\"chance\":\"3130\"},{\"id\":7886,\"count\":1,\"chance\":\"9510\"},{\"id\":8472,\"count\":\"2\",\"chance\":\"29460\"},{\"id\":8473,\"count\":1,\"chance\":\"24700\"},{\"id\":\"9810\",\"count\":1,\"chance\":\"180\"},{\"id\":11227,\"count\":1,\"chance\":\"860\"},{\"id\":11240,\"count\":1,\"chance\":\"200\"},{\"id\":11301,\"count\":1,\"chance\":\"870\"},{\"id\":11302,\"count\":1,\"chance\":\"150\"},{\"id\":11303,\"count\":1,\"chance\":\"870\"},{\"id\":11304,\"count\":1,\"chance\":\"1400\"},{\"id\":11305,\"count\":1,\"chance\":\"1470\"},{\"id\":11307,\"count\":1,\"chance\":\"100\"},{\"id\":11309,\"count\":1,\"chance\":\"15100\"},{\"id\":11323,\"count\":1,\"chance\":\"15020\"},{\"id\":11355,\"count\":1,\"chance\":\"690\"},{\"id\":11366,\"count\":1,\"chance\":\"6650\"},{\"id\":11367,\"count\":1,\"chance\":\"19830\"},{\"id\":11368,\"count\":1,\"chance\":\"810\"}]'),
(1714, 0, 'Ghazbaran', 0, 15000, 77000, 90, 1, '[\"COME AND GIVE ME SOME AMUSEMENT\",\"IS THAT THE BEST YOU HAVE TO OFFER?\",\"I AM GHAZBARAN OF THE TRIANGLE... AND I AM HERE TO CHALLENGE YOU ALL.\",\"FLAWLESS VICTORY!\"]', '[\"fire\",\"ice\",\"earth\",\"paralyze\",\"invisible\"]', 0, 0, 'fire', '[{\"id\":1984,\"count\":1,\"chance\":\"20000\"},{\"id\":2112,\"count\":1,\"chance\":\"12500\"},{\"id\":\"2124\",\"count\":1,\"chance\":\"8333\"},{\"id\":2143,\"count\":\"15\",\"chance\":\"25000\"},{\"id\":2144,\"count\":\"14\",\"chance\":\"11111\"},{\"id\":2145,\"count\":\"5\",\"chance\":\"25000\"},{\"id\":2146,\"count\":\"10\",\"chance\":\"25000\"},{\"id\":2149,\"count\":\"10\",\"chance\":\"25000\"},{\"id\":2150,\"count\":\"17\",\"chance\":\"25000\"},{\"id\":2151,\"count\":\"7\",\"chance\":\"12500\"},{\"id\":2152,\"count\":\"69\",\"chance\":\"100000\"},{\"id\":2155,\"count\":1,\"chance\":\"20000\"},{\"id\":2158,\"count\":1,\"chance\":\"14285\"},{\"id\":2164,\"count\":1,\"chance\":\"12500\"},{\"id\":2165,\"count\":1,\"chance\":\"12500\"},{\"id\":2174,\"count\":1,\"chance\":\"11111\"},{\"id\":2177,\"count\":1,\"chance\":\"12500\"},{\"id\":\"2178\",\"count\":1,\"chance\":\"20000\"},{\"id\":\"2178\",\"count\":1,\"chance\":\"20000\"},{\"id\":2179,\"count\":1,\"chance\":\"20000\"},{\"id\":2214,\"count\":1,\"chance\":\"20000\"},{\"id\":2447,\"count\":1,\"chance\":\"11111\"},{\"id\":2466,\"count\":1,\"chance\":\"8333\"},{\"id\":2472,\"count\":1,\"chance\":\"8333\"},{\"id\":2520,\"count\":1,\"chance\":\"12500\"},{\"id\":2646,\"count\":1,\"chance\":\"8333\"},{\"id\":5954,\"count\":\"2\",\"chance\":\"33333\"},{\"id\":\"6300\",\"count\":1,\"chance\":\"25000\"},{\"id\":6500,\"count\":1,\"chance\":\"100000\"},{\"id\":6553,\"count\":1,\"chance\":\"14285\"},{\"id\":7368,\"count\":\"44\",\"chance\":\"12500\"},{\"id\":7405,\"count\":1,\"chance\":\"16666\"},{\"id\":7433,\"count\":1,\"chance\":\"14285\"},{\"id\":7493,\"count\":1,\"chance\":\"20000\"},{\"id\":7590,\"count\":1,\"chance\":\"20000\"},{\"id\":7591,\"count\":1,\"chance\":\"20000\"},{\"id\":7896,\"count\":1,\"chance\":\"8333\"},{\"id\":8472,\"count\":1,\"chance\":\"25000\"},{\"id\":8473,\"count\":1,\"chance\":\"25000\"},{\"id\":8884,\"count\":1,\"chance\":\"16666\"},{\"id\":8887,\"count\":1,\"chance\":\"8333\"},{\"id\":8901,\"count\":1,\"chance\":\"20000\"},{\"id\":8902,\"count\":1,\"chance\":\"11111\"},{\"id\":8903,\"count\":1,\"chance\":\"16666\"},{\"id\":8904,\"count\":1,\"chance\":\"25000\"},{\"id\":8918,\"count\":1,\"chance\":\"20000\"}]'),
(1715, 0, 'Ghost Wolf', 0, 65, 160, 1, 0, '[]', '[]', 0, 0, 'undead', '[{\"id\":2148,\"count\":\"20\",\"chance\":\"69320\"}]'),
(1716, 0, 'Ghost', 0, 120, 150, 1, 0, '[\"Huh!\",\"Shhhhhh\",\"Buuuuuh\"]', '[\"physical\",\"drown\",\"earth\",\"death\",\"lifedrain\",\"paralyze\"]', 0, 0, 'undead', '[{\"id\":\"1962\",\"count\":1,\"chance\":\"1310\"},{\"id\":2165,\"count\":1,\"chance\":\"180\"},{\"id\":2394,\"count\":1,\"chance\":\"10610\"},{\"id\":2404,\"count\":1,\"chance\":\"7002\"},{\"id\":2532,\"count\":1,\"chance\":\"860\"},{\"id\":2654,\"count\":1,\"chance\":\"8800\"},{\"id\":2804,\"count\":1,\"chance\":\"14400\"},{\"id\":5909,\"count\":1,\"chance\":\"1940\"},{\"id\":10607,\"count\":1,\"chance\":\"1870\"}]'),
(1717, 0, 'Ghoul', 450, 85, 100, 1, 0, '[]', '[\"death\",\"drown\",\"lifedrain\",\"drunk\",\"paralyze\",\"invisible\"]', 1, 1, 'blood', '[{\"id\":\"2148\",\"count\":\"30\",\"chance\":\"69832\"},{\"id\":\"11208\",\"count\":1,\"chance\":\"14661\"},{\"id\":\"3976\",\"count\":\"2\",\"chance\":\"9815\"},{\"id\":\"2050\",\"count\":1,\"chance\":\"5171\"},{\"id\":\"12423\",\"count\":1,\"chance\":\"5064\"},{\"id\":\"12440\",\"count\":1,\"chance\":\"1028\"},{\"id\":\"2483\",\"count\":1,\"chance\":\"1012\"},{\"id\":\"2473\",\"count\":1,\"chance\":\"1012\"},{\"id\":\"5913\",\"count\":1,\"chance\":\"1001\"},{\"id\":\"2229\",\"count\":1,\"chance\":\"320\"},{\"id\":\"2168\",\"count\":1,\"chance\":\"181\"}]'),
(1718, 0, 'Ghoulish Hyaena', 275, 195, 400, 1, 1, '[\"Grawrrr!!\",\"Hoouu!\"]', '[\"death\",\"invisible\"]', 1, 1, 'blood', '[{\"id\":2147,\"count\":\"2\",\"chance\":\"2700\"},{\"id\":2148,\"count\":\"40\",\"chance\":\"89000\"},{\"id\":2666,\"count\":\"3\",\"chance\":\"51060\"},{\"id\":3976,\"count\":\"7\",\"chance\":\"65000\"},{\"id\":7618,\"count\":1,\"chance\":\"19840\"}]'),
(1719, 0, 'Giant Spider', 0, 12, 20, 1, 0, '[]', '[]', 0, 0, 'venom', '[{\"id\":2148,\"count\":\"5\",\"chance\":\"65000\"},{\"id\":8859,\"count\":1,\"chance\":\"950\"}]'),
(1720, 0, 'Gladiator', 470, 90, 185, 1, 1, '[\"You are no match for me!\",\"Feel my prowess\",\"Fight!\",\"Take this!\"]', '[]', 0, 1, 'blood', '[{\"id\":2148,\"count\":\"30\",\"chance\":\"49500\"},{\"id\":\"2376\",\"count\":1,\"chance\":\"12620\"},{\"id\":2398,\"count\":1,\"chance\":\"11160\"},{\"id\":2458,\"count\":1,\"chance\":\"5200\"},{\"id\":2459,\"count\":1,\"chance\":\"590\"},{\"id\":2465,\"count\":1,\"chance\":\"2750\"},{\"id\":2509,\"count\":1,\"chance\":\"840\"},{\"id\":2510,\"count\":1,\"chance\":\"9950\"},{\"id\":2666,\"count\":1,\"chance\":\"19000\"},{\"id\":8872,\"count\":1,\"chance\":\"340\"}]'),
(1721, 0, 'Glitterscale', 0, 700, 1000, 1, 0, '[]', '[\"fire\",\"paralyze\",\"invisible\"]', 0, 0, 'blood', '[]'),
(1722, 0, 'Gloom Wolf', 0, 70, 200, 15, 1, '[]', '[]', 0, 0, 'blood', '[{\"id\":\"2148\",\"count\":\"15\",\"chance\":\"66035\"},{\"id\":\"2666\",\"count\":1,\"chance\":\"40928\"},{\"id\":\"2671\",\"count\":1,\"chance\":\"39744\"},{\"id\":\"24663\",\"count\":1,\"chance\":\"8100\"},{\"id\":\"2129\",\"count\":1,\"chance\":\"7248\"},{\"id\":\"5897\",\"count\":1,\"chance\":\"3221\"}]'),
(1723, 0, 'Glooth Anemone', 0, 1800, 2400, 1, 0, '[\"*shglib*\"]', '[\"paralyze\",\"lifedrain\",\"invisible\",\"poison\"]', 0, 0, 'venom', '[{\"id\":\"23515\",\"count\":1,\"chance\":\"10190\"},{\"id\":\"23568\",\"count\":1,\"chance\":\"21020\"},{\"id\":\"2796\",\"count\":1,\"chance\":\"3180\"},{\"id\":\"23554\",\"count\":1,\"chance\":\"320\"},{\"id\":\"2148\",\"count\":\"100\",\"chance\":\"100000\"},{\"id\":\"2148\",\"count\":\"70\",\"chance\":\"60000\"},{\"id\":\"7588\",\"count\":\"2\",\"chance\":\"6690\"},{\"id\":\"7589\",\"count\":\"2\",\"chance\":\"6690\"},{\"id\":\"8473\",\"count\":1,\"chance\":\"960\"},{\"id\":\"2152\",\"count\":\"3\",\"chance\":\"57320\"},{\"id\":\"9970\",\"count\":\"3\",\"chance\":\"9240\"},{\"id\":\"2149\",\"count\":\"3\",\"chance\":\"8600\"},{\"id\":\"2147\",\"count\":\"3\",\"chance\":\"11150\"},{\"id\":\"23534\",\"count\":1,\"chance\":\"640\"},{\"id\":\"23543\",\"count\":1,\"chance\":\"5100\"},{\"id\":\"23550\",\"count\":1,\"chance\":\"320\"},{\"id\":\"23549\",\"count\":1,\"chance\":\"1270\"},{\"id\":\"23551\",\"count\":1,\"chance\":\"640\"},{\"id\":\"23529\",\"count\":1,\"chance\":\"1270\"}]'),
(1724, 0, 'Glooth Bandit', 0, 2000, 2600, 30, 0, '[]', '[\"poison\",\"paralyze\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"3962\",\"count\":1,\"chance\":\"800\"},{\"id\":\"23554\",\"count\":1,\"chance\":\"990\"},{\"id\":\"23551\",\"count\":1,\"chance\":\"1030\"},{\"id\":\"23574\",\"count\":1,\"chance\":\"5070\"},{\"id\":\"23550\",\"count\":1,\"chance\":\"1000\"},{\"id\":\"23535\",\"count\":1,\"chance\":\"580\"},{\"id\":\"24183\",\"count\":1,\"chance\":\"3010\"},{\"id\":\"23549\",\"count\":1,\"chance\":\"1000\"},{\"id\":\"23514\",\"count\":1,\"chance\":\"2470\"},{\"id\":\"23529\",\"count\":1,\"chance\":\"1010\"},{\"id\":\"23517\",\"count\":1,\"chance\":\"2600\"},{\"id\":\"2148\",\"count\":\"100\",\"chance\":\"100000\"},{\"id\":\"7591\",\"count\":1,\"chance\":\"8090\"},{\"id\":\"7590\",\"count\":\"2\",\"chance\":\"7400\"},{\"id\":\"8472\",\"count\":1,\"chance\":\"3480\"},{\"id\":\"2155\",\"count\":1,\"chance\":\"160\"},{\"id\":\"2152\",\"count\":\"3\",\"chance\":\"60050\"},{\"id\":\"23536\",\"count\":1,\"chance\":\"730\"},{\"id\":\"2436\",\"count\":1,\"chance\":\"420\"},{\"id\":\"2149\",\"count\":\"2\",\"chance\":\"2040\"},{\"id\":\"9970\",\"count\":\"2\",\"chance\":\"2530\"},{\"id\":\"24185\",\"count\":1,\"chance\":\"8010\"},{\"id\":\"7886\",\"count\":1,\"chance\":\"490\"},{\"id\":\"7903\",\"count\":1,\"chance\":\"600\"},{\"id\":\"7885\",\"count\":1,\"chance\":\"480\"},{\"id\":\"7884\",\"count\":1,\"chance\":\"600\"},{\"id\":\"8473\",\"count\":1,\"chance\":\"3440\"},{\"id\":\"2454\",\"count\":1,\"chance\":\"100\"}]'),
(1725, 0, 'Glooth Blob', 0, 700, 750, 1, 0, '[]', '[\"earth\",\"death\",\"lifedrain\"]', 0, 0, 'venom', '[{\"id\":\"2148\",\"count\":\"70\",\"chance\":\"100000\"},{\"id\":\"23553\",\"count\":1,\"chance\":\"15410\"},{\"id\":\"2146\",\"count\":\"2\",\"chance\":\"3310\"},{\"id\":\"9970\",\"count\":\"2\",\"chance\":\"3420\"},{\"id\":\"23554\",\"count\":1,\"chance\":\"400\"},{\"id\":\"23550\",\"count\":1,\"chance\":\"510\"},{\"id\":\"23549\",\"count\":1,\"chance\":\"580\"},{\"id\":\"23551\",\"count\":1,\"chance\":\"560\"}]'),
(1726, 0, 'Glooth Brigand', 0, 1900, 2400, 30, 0, '[]', '[\"poison\",\"paralyze\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"7412\",\"count\":1,\"chance\":\"50\"},{\"id\":\"7419\",\"count\":1,\"chance\":\"100\"},{\"id\":\"7632\",\"count\":1,\"chance\":\"1500\"},{\"id\":\"23554\",\"count\":1,\"chance\":\"960\"},{\"id\":\"23551\",\"count\":1,\"chance\":\"980\"},{\"id\":\"23574\",\"count\":\"2\",\"chance\":\"9830\"},{\"id\":\"23550\",\"count\":1,\"chance\":\"1000\"},{\"id\":\"24183\",\"count\":1,\"chance\":\"3100\"},{\"id\":\"23549\",\"count\":1,\"chance\":\"1000\"},{\"id\":\"23514\",\"count\":1,\"chance\":\"2480\"},{\"id\":\"23529\",\"count\":1,\"chance\":\"1000\"},{\"id\":\"23517\",\"count\":1,\"chance\":\"2500\"},{\"id\":\"2148\",\"count\":\"100\",\"chance\":\"100000\"},{\"id\":\"7590\",\"count\":1,\"chance\":\"3490\"},{\"id\":\"8472\",\"count\":1,\"chance\":\"3540\"},{\"id\":\"2155\",\"count\":1,\"chance\":\"200\"},{\"id\":\"23538\",\"count\":1,\"chance\":\"160\"},{\"id\":\"7386\",\"count\":1,\"chance\":\"150\"},{\"id\":\"2152\",\"count\":\"3\",\"chance\":\"79920\"},{\"id\":\"23536\",\"count\":1,\"chance\":\"640\"},{\"id\":\"24185\",\"count\":1,\"chance\":\"8070\"},{\"id\":\"7887\",\"count\":1,\"chance\":\"400\"},{\"id\":\"7886\",\"count\":1,\"chance\":\"490\"},{\"id\":\"7903\",\"count\":1,\"chance\":\"710\"},{\"id\":\"7885\",\"count\":1,\"chance\":\"500\"},{\"id\":\"7884\",\"count\":1,\"chance\":\"600\"},{\"id\":\"8473\",\"count\":1,\"chance\":\"3450\"}]'),
(1727, 0, 'Glooth Golem', 0, 2200, 2700, 20, 1, '[\"*slosh*\",\"*clank*\"]', '[\"invisible\",\"earth\",\"paralyze\"]', 0, 0, 'venom', '[{\"id\":\"5880\",\"count\":1,\"chance\":\"1030\"},{\"id\":\"23554\",\"count\":1,\"chance\":\"1720\"},{\"id\":\"23541\",\"count\":1,\"chance\":\"1720\"},{\"id\":\"23536\",\"count\":1,\"chance\":\"1370\"},{\"id\":\"2148\",\"count\":\"100\",\"chance\":\"100000\"},{\"id\":\"2148\",\"count\":\"100\",\"chance\":\"60000\"},{\"id\":\"24124\",\"count\":1,\"chance\":\"4470\"},{\"id\":\"9690\",\"count\":1,\"chance\":\"690\"},{\"id\":\"23514\",\"count\":1,\"chance\":\"9970\"},{\"id\":\"2152\",\"count\":\"4\",\"chance\":\"56010\"},{\"id\":\"23474\",\"count\":1,\"chance\":\"16840\"},{\"id\":\"8473\",\"count\":1,\"chance\":\"4470\"},{\"id\":\"7590\",\"count\":1,\"chance\":\"9280\"},{\"id\":\"23538\",\"count\":1,\"chance\":\"690\"},{\"id\":\"23550\",\"count\":1,\"chance\":\"3440\"},{\"id\":\"23549\",\"count\":1,\"chance\":\"1030\"},{\"id\":\"23551\",\"count\":1,\"chance\":\"690\"},{\"id\":\"2154\",\"count\":1,\"chance\":\"1030\"},{\"id\":\"9970\",\"count\":\"4\",\"chance\":\"7560\"},{\"id\":\"2149\",\"count\":\"4\",\"chance\":\"8590\"}]'),
(1728, 0, 'Gnarlhound', 465, 60, 198, 30, 0, '[\"Gnarllll!\",\"Grrrrrr!\"]', '[]', 1, 1, 'blood', '[{\"id\":2148,\"count\":\"30\",\"chance\":\"48000\"},{\"id\":2666,\"count\":\"3\",\"chance\":\"39075\"},{\"id\":3976,\"count\":\"3\",\"chance\":\"33300\"},{\"id\":11324,\"count\":1,\"chance\":\"25550\"}]'),
(1729, 0, 'Gnomevil', 0, 45000, 250000, 125, 0, '[\"No more Mr. Nicegnome!\",\"Taste the power of the dark side!\",\"I\'ve seen the light! And it was all engulfing fire!\",\"Tatatata!!!\",\"Muhahaha!\",\"I\'m feeling grrrreat!\"]', '[\"outfit\",\"drown\",\"paralyze\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":18449,\"count\":1,\"chance\":\"1710\"},{\"id\":18450,\"count\":1,\"chance\":\"14100\"},{\"id\":18451,\"count\":1,\"chance\":\"9830\"},{\"id\":18452,\"count\":1,\"chance\":\"8120\"},{\"id\":18453,\"count\":1,\"chance\":\"8120\"},{\"id\":18454,\"count\":1,\"chance\":\"9400\"},{\"id\":18465,\"count\":1,\"chance\":\"7690\"},{\"id\":18495,\"count\":1,\"chance\":\"99150\"}]'),
(1730, 0, 'Gnorre Chyllson', 0, 4000, 7150, 75, 0, '[\"I am like the merciless northwind.\",\"Snow will be your death shroud.\",\"Feel the wrath of father chyll!\"]', '[\"fire\",\"ice\",\"earth\",\"paralyze\",\"outfit\",\"drunk\",\"invisible\"]', 0, 0, 'blood', '[]'),
(1731, 0, 'Goblin Assassin', 360, 52, 75, 1, 1, '[\"Goblin Powahhh!\",\"Me kill you!\",\"Me green menace!\",\"Gobabunga!\",\"Gooobliiiins!\"]', '[]', 0, 1, 'blood', '[{\"id\":\"2148\",\"count\":\"9\",\"chance\":\"49810\"},{\"id\":\"2379\",\"count\":1,\"chance\":\"17664\"},{\"id\":\"2667\",\"count\":1,\"chance\":\"12472\"},{\"id\":\"2230\",\"count\":1,\"chance\":\"12282\"},{\"id\":\"1294\",\"count\":\"3\",\"chance\":\"10620\"},{\"id\":\"2461\",\"count\":1,\"chance\":\"10130\"},{\"id\":\"2559\",\"count\":1,\"chance\":\"9687\"},{\"id\":\"2406\",\"count\":1,\"chance\":\"8816\"},{\"id\":\"2467\",\"count\":1,\"chance\":\"7281\"},{\"id\":\"2235\",\"count\":1,\"chance\":\"6933\"},{\"id\":\"2449\",\"count\":1,\"chance\":\"5065\"}]'),
(1732, 0, 'Goblin Leader', 290, 75, 50, 1, 0, '[\"Go go, Gobo attack!!\",\"Me the greenest and the meanest!\",\"Me have power to crush you!\",\"Goblinkiller! Catch him !!\"]', '[]', 1, 1, 'blood', '[{\"id\":\"2148\",\"count\":\"9\",\"chance\":\"49369\"},{\"id\":\"2379\",\"count\":1,\"chance\":\"17498\"},{\"id\":\"2667\",\"count\":1,\"chance\":\"12989\"},{\"id\":\"2230\",\"count\":1,\"chance\":\"11545\"},{\"id\":\"2559\",\"count\":1,\"chance\":\"10704\"},{\"id\":\"2461\",\"count\":1,\"chance\":\"9862\"},{\"id\":\"2406\",\"count\":1,\"chance\":\"9862\"},{\"id\":\"2467\",\"count\":1,\"chance\":\"7456\"},{\"id\":\"2235\",\"count\":1,\"chance\":\"7276\"},{\"id\":\"2449\",\"count\":1,\"chance\":\"4871\"}]'),
(1733, 0, 'Goblin Scavenger', 310, 37, 60, 1, 0, '[\"Shiny, shiny!\",\"You mean!\",\"All mine!\",\"Uhh!\",\"Gimme gimme!\"]', '[]', 0, 1, 'blood', '[{\"id\":\"2148\",\"count\":\"9\",\"chance\":\"50077\"},{\"id\":\"1294\",\"count\":\"2\",\"chance\":\"24937\"},{\"id\":\"2379\",\"count\":1,\"chance\":\"18190\"},{\"id\":\"2667\",\"count\":1,\"chance\":\"12982\"},{\"id\":\"2230\",\"count\":1,\"chance\":\"12643\"},{\"id\":\"2461\",\"count\":1,\"chance\":\"9855\"},{\"id\":\"2559\",\"count\":1,\"chance\":\"9448\"},{\"id\":\"2406\",\"count\":1,\"chance\":\"8993\"},{\"id\":\"2467\",\"count\":1,\"chance\":\"7696\"},{\"id\":\"2235\",\"count\":1,\"chance\":\"7018\"},{\"id\":\"2449\",\"count\":1,\"chance\":\"5044\"}]'),
(1734, 0, 'Goblin', 290, 25, 50, 1, 0, '[\"Me have him!\",\"Zig Zag! Gobo attack!\",\"Help! Goblinkiller!\",\"Bugga! Bugga!\",\"Me green, me mean!\"]', '[]', 1, 1, 'blood', '[{\"id\":\"2148\",\"count\":\"9\",\"chance\":\"50250\"},{\"id\":\"1294\",\"count\":1,\"chance\":\"15265\"},{\"id\":\"2667\",\"count\":1,\"chance\":\"13004\"},{\"id\":\"2559\",\"count\":1,\"chance\":\"9863\"},{\"id\":\"2406\",\"count\":1,\"chance\":\"8832\"},{\"id\":\"2449\",\"count\":1,\"chance\":\"4934\"},{\"id\":\"2467\",\"count\":1,\"chance\":\"2514\"},{\"id\":\"2461\",\"count\":1,\"chance\":\"1947\"},{\"id\":\"2379\",\"count\":1,\"chance\":\"1795\"},{\"id\":\"2230\",\"count\":1,\"chance\":\"1065\"},{\"id\":\"2235\",\"count\":1,\"chance\":\"999\"},{\"id\":\"12495\",\"count\":1,\"chance\":\"951\"}]'),
(1735, 0, 'Golden Servant', 0, 450, 550, 1, 0, '[\"Error. LOAD \'PROGRAM\',8,1\",\"Remain. Obedient.\"]', '[\"holy\",\"invisible\",\"paralyze\"]', 0, 0, 'energy', '[{\"id\":\"2148\",\"count\":\"140\",\"chance\":\"84992\"},{\"id\":\"7618\",\"count\":1,\"chance\":\"4962\"},{\"id\":\"7620\",\"count\":1,\"chance\":\"4960\"},{\"id\":\"2381\",\"count\":1,\"chance\":\"3030\"},{\"id\":\"2796\",\"count\":1,\"chance\":\"1510\"},{\"id\":\"9690\",\"count\":1,\"chance\":\"943\"},{\"id\":\"8900\",\"count\":1,\"chance\":\"524\"},{\"id\":\"2165\",\"count\":1,\"chance\":\"478\"},{\"id\":\"13758\",\"count\":1,\"chance\":\"356\"},{\"id\":\"13938\",\"count\":1,\"chance\":\"36\"},{\"id\":\"2466\",\"count\":1,\"chance\":\"22\"},{\"id\":\"2179\",\"count\":1,\"chance\":\"8\"}]'),
(1736, 0, 'Golgordan', 0, 10000, 40000, 65, 0, '[\"Latrivan your fool\"]', '[\"death\"]', 0, 0, 'fire', '[]'),
(1737, 0, 'Gozzler', 800, 180, 240, 1, 1, '[\"Huhuhuhuuu!\",\"Let the fun begin!\",\"Yihahaha!\",\"I\'ll bite you! Nyehehehehe!\"]', '[\"invisible\"]', 1, 0, 'undead', '[{\"id\":2015,\"count\":1,\"chance\":\"8750\"},{\"id\":2146,\"count\":1,\"chance\":\"360\"},{\"id\":2148,\"count\":\"70\",\"chance\":\"52500\"},{\"id\":2213,\"count\":1,\"chance\":\"190\"},{\"id\":2378,\"count\":1,\"chance\":\"3100\"},{\"id\":2385,\"count\":1,\"chance\":\"8250\"},{\"id\":2394,\"count\":1,\"chance\":\"5000\"},{\"id\":2409,\"count\":1,\"chance\":\"250\"},{\"id\":2423,\"count\":1,\"chance\":\"900\"},{\"id\":2510,\"count\":1,\"chance\":\"10000\"}]'),
(1738, 0, 'Grand Mother Foulscale', 0, 1400, 1850, 1, 0, '[\"GROOAAARRR\",\"FCHHHHH\"]', '[\"fire\",\"paralyze\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"5877\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"5920\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2148\",\"count\":\"97\",\"chance\":\"86486\"},{\"id\":\"2672\",\"count\":1,\"chance\":\"32432\"},{\"id\":\"2387\",\"count\":1,\"chance\":\"16216\"},{\"id\":\"2647\",\"count\":1,\"chance\":\"16216\"},{\"id\":\"2434\",\"count\":1,\"chance\":\"13514\"},{\"id\":\"2455\",\"count\":1,\"chance\":\"8108\"},{\"id\":\"2546\",\"count\":\"7\",\"chance\":\"5405\"},{\"id\":\"2516\",\"count\":1,\"chance\":\"5405\"},{\"id\":\"3351\",\"count\":1,\"chance\":\"5405\"},{\"id\":\"2413\",\"count\":1,\"chance\":\"2703\"},{\"id\":\"7430\",\"count\":1,\"chance\":\"2703\"}]'),
(1739, 0, 'Grandfather Tridian', 0, 1400, 1800, 1, 0, '[\"I will bring peace to your misguided soul!\",\"Your intrusion can\'t be tolerated!\"]', '[\"paralyze\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":2148,\"count\":\"80\",\"chance\":\"100000\"},{\"id\":2114,\"count\":1,\"chance\":\"100000\"},{\"id\":7589,\"count\":1,\"chance\":\"5000\"},{\"id\":2789,\"count\":1,\"chance\":\"5000\"},{\"id\":2187,\"count\":1,\"chance\":\"5000\"},{\"id\":2436,\"count\":1,\"chance\":\"5000\"},{\"id\":8922,\"count\":1,\"chance\":\"5000\"},{\"id\":7426,\"count\":1,\"chance\":\"3000\"},{\"id\":\"6087\",\"count\":1,\"chance\":\"3000\"},{\"id\":\"6088\",\"count\":1,\"chance\":\"3000\"},{\"id\":\"6089\",\"count\":1,\"chance\":\"3000\"},{\"id\":\"6090\",\"count\":1,\"chance\":\"3000\"},{\"id\":\"3955\",\"count\":1,\"chance\":\"1000\"},{\"id\":10555,\"count\":1,\"chance\":\"10250\"},{\"id\":\"1962\",\"count\":1,\"chance\":\"910\"},{\"id\":12411,\"count\":1,\"chance\":\"890\"},{\"id\":2200,\"count\":1,\"chance\":\"790\"},{\"id\":2146,\"count\":1,\"chance\":\"550\"},{\"id\":2167,\"count\":1,\"chance\":\"450\"},{\"id\":5810,\"count\":1,\"chance\":\"430\"},{\"id\":2171,\"count\":1,\"chance\":\"200\"},{\"id\":5669,\"count\":1,\"chance\":\"130\"},{\"id\":12608,\"count\":1,\"chance\":\"100\"},{\"id\":5801,\"count\":1,\"chance\":\"100\"},{\"id\":2656,\"count\":1,\"chance\":\"40\"}]'),
(1740, 0, 'Grave Guard', 0, 485, 720, 1, 0, '[]', '[\"fire\"]', 0, 0, 'undead', '[{\"id\":\"2148\",\"count\":\"129\",\"chance\":\"95445\"},{\"id\":\"2747\",\"count\":1,\"chance\":\"69968\"},{\"id\":\"7620\",\"count\":1,\"chance\":\"20318\"},{\"id\":\"7618\",\"count\":1,\"chance\":\"19920\"},{\"id\":\"2159\",\"count\":1,\"chance\":\"4802\"},{\"id\":\"6300\",\"count\":1,\"chance\":\"2181\"},{\"id\":\"2440\",\"count\":1,\"chance\":\"933\"}]'),
(1741, 0, 'Grave Robber', 355, 65, 165, 1, 0, '[\"This crypt is taken!\",\"Leave or you are hunted!\",\"The treasure will be mine!\",\"The X marks the spot!\"]', '[]', 1, 1, 'blood', '[{\"id\":2148,\"count\":\"38\",\"chance\":\"54260\"},{\"id\":2386,\"count\":1,\"chance\":\"2500\"},{\"id\":2398,\"count\":1,\"chance\":\"1700\"},{\"id\":2459,\"count\":1,\"chance\":\"500\"},{\"id\":2465,\"count\":1,\"chance\":\"1700\"},{\"id\":2509,\"count\":1,\"chance\":\"500\"},{\"id\":8267,\"count\":1,\"chance\":\"170\"},{\"id\":8838,\"count\":\"3\",\"chance\":\"5680\"},{\"id\":12412,\"count\":1,\"chance\":\"1700\"},{\"id\":12448,\"count\":1,\"chance\":\"7510\"}]'),
(1742, 0, 'Gravedigger', 0, 950, 1500, 5, 1, '[\"High Five!\",\"scrabble\",\"Put it there!\"]', '[\"ice\",\"energy\",\"death\",\"paralyze\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":2148,\"count\":\"100\",\"chance\":\"50000\"},{\"id\":2148,\"count\":\"37\",\"chance\":\"50000\"},{\"id\":2152,\"count\":1,\"chance\":\"24470\"},{\"id\":2154,\"count\":1,\"chance\":\"800\"},{\"id\":2187,\"count\":1,\"chance\":\"5590\"},{\"id\":2268,\"count\":\"9\",\"chance\":\"7300\"},{\"id\":2436,\"count\":1,\"chance\":\"130\"},{\"id\":5669,\"count\":1,\"chance\":\"100\"},{\"id\":5925,\"count\":1,\"chance\":\"50\"},{\"id\":\"6300\",\"count\":1,\"chance\":\"800\"},{\"id\":7588,\"count\":\"2\",\"chance\":\"2260\"},{\"id\":7589,\"count\":\"2\",\"chance\":\"3600\"},{\"id\":10609,\"count\":1,\"chance\":\"100\"},{\"id\":11233,\"count\":1,\"chance\":\"9570\"},{\"id\":12440,\"count\":1,\"chance\":\"6650\"},{\"id\":12449,\"count\":1,\"chance\":\"6000\"}]'),
(1743, 0, 'Gravelord Oshuran', 0, 2400, 3100, 110, 0, '[\"Your mortality is disgusting!\"]', '[\"death\",\"earth\",\"lifedrain\",\"paralyze\",\"invisible\"]', 0, 0, 'undead', '[{\"id\":\"2148\",\"count\":\"100\",\"chance\":\"50000\"},{\"id\":\"2148\",\"count\":\"15\",\"chance\":\"50000\"},{\"id\":\"7589\",\"count\":1,\"chance\":\"17500\"},{\"id\":\"2144\",\"count\":1,\"chance\":\"15960\"},{\"id\":\"2143\",\"count\":1,\"chance\":\"15000\"},{\"id\":\"2214\",\"count\":1,\"chance\":\"15040\"},{\"id\":\"2656\",\"count\":1,\"chance\":\"500\"},{\"id\":\"7893\",\"count\":1,\"chance\":\"900\"},{\"id\":\"8904\",\"count\":1,\"chance\":\"300\"},{\"id\":\"2175\",\"count\":1,\"chance\":\"4650\"}]'),
(1744, 0, 'Green Djinn', 0, 215, 330, 1, 0, '[\"Good wishes are for fairytales\",\"I wish you a merry trip to hell!\",\"Muhahahaha!\",\"I grant you a deathwish!\",\"Tell me your last wish!\"]', '[\"paralyze\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2148\",\"count\":\"115\",\"chance\":\"88234\"},{\"id\":\"3607\",\"count\":1,\"chance\":\"24327\"},{\"id\":\"7378\",\"count\":\"2\",\"chance\":\"5046\"},{\"id\":\"2149\",\"count\":\"4\",\"chance\":\"2933\"},{\"id\":\"1965\",\"count\":1,\"chance\":\"2295\"},{\"id\":\"12412\",\"count\":1,\"chance\":\"2121\"},{\"id\":\"5910\",\"count\":1,\"chance\":\"2005\"},{\"id\":\"2747\",\"count\":1,\"chance\":\"953\"},{\"id\":\"2063\",\"count\":1,\"chance\":\"870\"},{\"id\":\"7620\",\"count\":1,\"chance\":\"481\"},{\"id\":\"2663\",\"count\":1,\"chance\":\"116\"}]'),
(1745, 0, 'Green Frog', 250, 0, 25, 1, 0, '[\"Ribbit!\",\"Ribbit! Ribbit!\"]', '[]', 1, 1, 'blood', '[]'),
(1746, 0, 'Grim Reaper', 0, 5500, 3900, 50, 1, '[\"Death!\",\"Come a little closer!\",\"The end is near!\"]', '[\"paralyze\",\"invisible\"]', 0, 0, 'undead', '[{\"id\":\"2148\",\"count\":\"272\",\"chance\":\"99228\"},{\"id\":\"6558\",\"count\":1,\"chance\":\"36153\"},{\"id\":\"6500\",\"count\":1,\"chance\":\"11837\"},{\"id\":\"8473\",\"count\":1,\"chance\":\"10839\"},{\"id\":\"7590\",\"count\":1,\"chance\":\"10035\"},{\"id\":\"2550\",\"count\":1,\"chance\":\"9778\"},{\"id\":\"10577\",\"count\":1,\"chance\":\"5436\"},{\"id\":\"2152\",\"count\":\"4\",\"chance\":\"5146\"},{\"id\":\"2162\",\"count\":1,\"chance\":\"4921\"},{\"id\":\"2521\",\"count\":1,\"chance\":\"2830\"},{\"id\":\"9810\",\"count\":1,\"chance\":\"2509\"},{\"id\":\"5022\",\"count\":\"4\",\"chance\":\"1287\"},{\"id\":\"8910\",\"count\":1,\"chance\":\"1190\"},{\"id\":\"7418\",\"count\":1,\"chance\":\"868\"},{\"id\":\"7896\",\"count\":1,\"chance\":\"289\"},{\"id\":\"8889\",\"count\":1,\"chance\":\"257\"},{\"id\":\"6300\",\"count\":1,\"chance\":\"225\"}]'),
(1747, 0, 'Grimgor Guteater', 0, 670, 1115, 10, 0, '[\"Dont run, You\'re burning off precious fat.\"]', '[\"fire\",\"outfit\",\"drunk\",\"invisible\"]', 0, 0, 'blood', '[]'),
(1748, 0, 'Groam', 0, 180, 400, 170, 0, '[\"Njaaarh!!\",\"Begjone, intrjuder!!\",\"Djon\'t djare stjare injo the eyes of the djeep!\",\"Ljeave this sjacred pljace while you cjan\"]', '[\"ice\",\"drown\",\"fire\"]', 0, 0, 'blood', '[{\"id\":2148,\"count\":\"50\",\"chance\":\"100000\"},{\"id\":2168,\"count\":1,\"chance\":\"50000\"},{\"id\":3965,\"count\":\"4\",\"chance\":\"25000\"},{\"id\":\"9808\",\"count\":1,\"chance\":\"14285\"}]'),
(1749, 0, 'Grodrik', 0, 60, 120, 1, 0, '[\"By the great mother of fire! What is this?\",\"Can I at least have a beer??\",\"I\'ll hail no one, not even Durin, until I am brought back to where I was just moments ago!\",\"If I ever find out who is behind all that... GRR!\",\"What the... where is this place?\"]', '[]', 0, 0, 'blood', '[]'),
(1750, 0, 'Grorlam', 0, 2400, 3000, 10, 1, '[]', '[\"earth\",\"paralyze\",\"invisible\"]', 0, 0, 'undead', '[{\"id\":\"2148\",\"count\":\"98\",\"chance\":\"100000\"},{\"id\":\"2152\",\"count\":\"6\",\"chance\":\"100000\"},{\"id\":\"11227\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2150\",\"count\":\"2\",\"chance\":\"73077\"},{\"id\":\"2509\",\"count\":1,\"chance\":\"65385\"},{\"id\":\"11232\",\"count\":1,\"chance\":\"65385\"},{\"id\":\"2156\",\"count\":1,\"chance\":\"57692\"},{\"id\":\"2166\",\"count\":1,\"chance\":\"42308\"},{\"id\":\"2645\",\"count\":1,\"chance\":\"11538\"},{\"id\":\"2124\",\"count\":1,\"chance\":\"3846\"},{\"id\":\"1294\",\"count\":\"3\",\"chance\":\"3846\"}]'),
(1751, 0, 'Grynch Clan Goblin', 0, 4, 80, 1, 1, '[\"T\'was not me hand in your pocket!\",\"Look! Cool stuff in house. Let\'s get it!\",\"Uhh! Nobody home! <chuckle>\",\"Me just borrowed it!\",\"Me no steal! Me found it!\",\"Me had it for five minutes. It\'s family heirloom now!\",\"Nice human won\'t hurt little, good goblin?\",\"Gimmegimme!\",\"Invite me in you lovely house plx!\",\"Other Goblin stole it!\",\"All presents mine!\",\"Me got ugly ones purse\",\"Free itans plz!\",\"Not me! Not me!\",\"Guys, help me here! Guys? Guys???\",\"That only much dust in me pocket! Honest!\",\"Can me have your stuff?\",\"Halp, Big dumb one is after me!\",\"Uh, So many shiny things!\",\"Utani hur hur hur!\",\"Mee? Stealing? Never!!!\",\"Oh what fun it is to steal a one-horse open sleigh!\",\"Must have it! Must have it!\",\"Where me put me lockpick?\",\"Catch me if you can!\"]', '[\"fire\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2148\",\"count\":\"16\",\"chance\":\"55320\"},{\"id\":\"6497\",\"count\":1,\"chance\":\"29918\"},{\"id\":\"2111\",\"count\":\"3\",\"chance\":\"14919\"},{\"id\":\"2674\",\"count\":\"3\",\"chance\":\"10196\"},{\"id\":\"2687\",\"count\":\"5\",\"chance\":\"8023\"},{\"id\":\"2675\",\"count\":\"2\",\"chance\":\"5033\"},{\"id\":\"6277\",\"count\":1,\"chance\":\"4934\"},{\"id\":\"7909\",\"count\":\"4\",\"chance\":\"1998\"},{\"id\":\"3606\",\"count\":\"2\",\"chance\":\"1019\"},{\"id\":\"2688\",\"count\":\"3\",\"chance\":\"997\"},{\"id\":\"10207\",\"count\":1,\"chance\":\"965\"},{\"id\":\"7910\",\"count\":\"5\",\"chance\":\"961\"},{\"id\":\"2661\",\"count\":1,\"chance\":\"808\"},{\"id\":\"5894\",\"count\":\"3\",\"chance\":\"638\"},{\"id\":\"2007\",\"count\":1,\"chance\":\"543\"},{\"id\":\"4873\",\"count\":1,\"chance\":\"476\"},{\"id\":\"2324\",\"count\":1,\"chance\":\"400\"},{\"id\":\"5902\",\"count\":1,\"chance\":\"400\"},{\"id\":\"6501\",\"count\":1,\"chance\":\"391\"},{\"id\":\"5890\",\"count\":\"3\",\"chance\":\"382\"},{\"id\":\"2679\",\"count\":\"4\",\"chance\":\"341\"},{\"id\":\"2260\",\"count\":1,\"chance\":\"121\"},{\"id\":\"2983\",\"count\":1,\"chance\":\"117\"},{\"id\":\"2036\",\"count\":1,\"chance\":\"117\"},{\"id\":\"1852\",\"count\":1,\"chance\":\"112\"},{\"id\":\"6393\",\"count\":1,\"chance\":\"108\"},{\"id\":\"2162\",\"count\":1,\"chance\":\"108\"},{\"id\":\"6393\",\"count\":1,\"chance\":\"108\"},{\"id\":\"5792\",\"count\":1,\"chance\":\"103\"},{\"id\":\"2159\",\"count\":1,\"chance\":\"99\"},{\"id\":\"2072\",\"count\":1,\"chance\":\"90\"},{\"id\":\"5022\",\"count\":1,\"chance\":\"81\"},{\"id\":\"2120\",\"count\":1,\"chance\":\"81\"},{\"id\":\"1684\",\"count\":1,\"chance\":\"76\"},{\"id\":\"2560\",\"count\":1,\"chance\":\"72\"},{\"id\":\"2114\",\"count\":1,\"chance\":\"72\"}]'),
(1752, 0, 'Guzzlemaw', 0, 6050, 6400, 90, 0, '[\"Gmmmooooh! *chomp*\",\"MWAAAH! *gurgle*\",\"*chomp* Mmmoh! *chomp*\"]', '[\"paralyze\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2152\",\"count\":\"7\",\"chance\":\"87952\"},{\"id\":\"2148\",\"count\":\"100\",\"chance\":\"75663\"},{\"id\":\"7590\",\"count\":\"3\",\"chance\":\"15261\"},{\"id\":\"7591\",\"count\":\"2\",\"chance\":\"11968\"},{\"id\":\"22532\",\"count\":1,\"chance\":\"10281\"},{\"id\":\"2229\",\"count\":1,\"chance\":\"9719\"},{\"id\":\"22533\",\"count\":1,\"chance\":\"9157\"},{\"id\":\"2226\",\"count\":1,\"chance\":\"8353\"},{\"id\":\"5951\",\"count\":1,\"chance\":\"7952\"},{\"id\":\"2225\",\"count\":1,\"chance\":\"7871\"},{\"id\":\"2230\",\"count\":1,\"chance\":\"7791\"},{\"id\":\"2240\",\"count\":1,\"chance\":\"7791\"},{\"id\":\"2671\",\"count\":1,\"chance\":\"7550\"},{\"id\":\"18554\",\"count\":1,\"chance\":\"7229\"},{\"id\":\"2219\",\"count\":1,\"chance\":\"7149\"},{\"id\":\"18417\",\"count\":\"2\",\"chance\":\"6827\"},{\"id\":\"18420\",\"count\":1,\"chance\":\"5542\"},{\"id\":\"2667\",\"count\":\"3\",\"chance\":\"4498\"},{\"id\":\"2231\",\"count\":1,\"chance\":\"4016\"},{\"id\":\"5895\",\"count\":1,\"chance\":\"3614\"},{\"id\":\"5925\",\"count\":1,\"chance\":\"3052\"},{\"id\":\"2377\",\"count\":1,\"chance\":\"2249\"},{\"id\":\"5880\",\"count\":1,\"chance\":\"2169\"},{\"id\":\"18414\",\"count\":1,\"chance\":\"2088\"},{\"id\":\"22396\",\"count\":1,\"chance\":\"1526\"},{\"id\":\"7407\",\"count\":1,\"chance\":\"1446\"},{\"id\":\"11306\",\"count\":1,\"chance\":\"1285\"},{\"id\":\"7404\",\"count\":1,\"chance\":\"643\"},{\"id\":\"7418\",\"count\":1,\"chance\":\"643\"}]'),
(1753, 0, 'Hacker', 0, 45, 430, 15, 1, '[\"Feel the wrath of me dos attack!\",\"You\'re next!\",\"Gimme free gold!\",\"Me sooo smart!\",\"Me have a cheating link for you!\",\"Me is GM!\",\"Gimme your password!\",\"Me just need the code!\",\"Me not stink!\",\"Me other char is highlevel!\"]', '[\"energy\",\"fire\",\"earth\",\"drunk\"]', 0, 0, 'blood', '[{\"id\":\"2044\",\"count\":1,\"chance\":\"6666\"},{\"id\":2148,\"count\":\"12\",\"chance\":\"100000\"},{\"id\":2378,\"count\":1,\"chance\":\"5000\"},{\"id\":\"2381\",\"count\":1,\"chance\":\"10000\"},{\"id\":2386,\"count\":1,\"chance\":\"10000\"},{\"id\":2391,\"count\":1,\"chance\":\"5000\"},{\"id\":\"2671\",\"count\":1,\"chance\":\"50000\"},{\"id\":\"6570\",\"count\":1,\"chance\":\"5538\"},{\"id\":\"6571\",\"count\":1,\"chance\":\"1538\"}]'),
(1754, 0, 'Hairman The Huge', 0, 335, 600, 5, 1, '[\"Hugah!\",\"Ungh! Ungh!\",\"Huaauaauaauaa!\"]', '[]', 0, 0, 'blood', '[{\"id\":2148,\"count\":\"60\",\"chance\":\"50000\"},{\"id\":2166,\"count\":1,\"chance\":\"7500\"},{\"id\":2200,\"count\":1,\"chance\":\"3000\"},{\"id\":2463,\"count\":1,\"chance\":\"5000\"},{\"id\":\"2676\",\"count\":\"2\",\"chance\":\"7500\"},{\"id\":5883,\"count\":1,\"chance\":\"2500\"}]'),
(1755, 0, 'Hand Of Cursed Fate', 0, 5000, 7500, 20, 1, '[]', '[\"earth\",\"energy\",\"fire\",\"death\",\"paralyze\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2148\",\"count\":\"267\",\"chance\":\"100000\"},{\"id\":\"2152\",\"count\":\"7\",\"chance\":\"98310\"},{\"id\":\"5944\",\"count\":1,\"chance\":\"30516\"},{\"id\":\"6558\",\"count\":1,\"chance\":\"29935\"},{\"id\":\"7590\",\"count\":\"2\",\"chance\":\"19632\"},{\"id\":\"8473\",\"count\":1,\"chance\":\"18835\"},{\"id\":\"2178\",\"count\":1,\"chance\":\"15373\"},{\"id\":\"7368\",\"count\":\"5\",\"chance\":\"15116\"},{\"id\":\"2146\",\"count\":\"4\",\"chance\":\"14413\"},{\"id\":\"6500\",\"count\":1,\"chance\":\"11696\"},{\"id\":\"2200\",\"count\":1,\"chance\":\"10249\"},{\"id\":\"2154\",\"count\":1,\"chance\":\"5773\"},{\"id\":\"2127\",\"count\":1,\"chance\":\"5219\"},{\"id\":\"2187\",\"count\":1,\"chance\":\"4800\"},{\"id\":\"2268\",\"count\":\"8\",\"chance\":\"4381\"},{\"id\":\"2476\",\"count\":1,\"chance\":\"3921\"},{\"id\":\"2167\",\"count\":1,\"chance\":\"2177\"},{\"id\":\"2158\",\"count\":1,\"chance\":\"1690\"},{\"id\":\"6300\",\"count\":1,\"chance\":\"1312\"},{\"id\":\"2153\",\"count\":1,\"chance\":\"1001\"},{\"id\":\"2171\",\"count\":1,\"chance\":\"960\"},{\"id\":\"2436\",\"count\":1,\"chance\":\"933\"},{\"id\":\"1962\",\"count\":1,\"chance\":\"879\"},{\"id\":\"2487\",\"count\":1,\"chance\":\"879\"},{\"id\":\"9971\",\"count\":1,\"chance\":\"568\"},{\"id\":\"2195\",\"count\":1,\"chance\":\"135\"},{\"id\":\"5669\",\"count\":1,\"chance\":\"108\"},{\"id\":\"7414\",\"count\":1,\"chance\":\"68\"}]'),
(1756, 0, 'Haunted Treeling', 0, 310, 450, 5, 0, '[\"Knarrrz\",\"Huuhuuhuuuhuuaarrr\",\"Knorrrrrr\"]', '[\"earth\",\"invisible\"]', 0, 0, 'undead', '[{\"id\":\"2148\",\"count\":\"95\",\"chance\":\"92016\"},{\"id\":\"4860\",\"count\":1,\"chance\":\"29201\"},{\"id\":\"2788\",\"count\":1,\"chance\":\"7814\"},{\"id\":\"7618\",\"count\":1,\"chance\":\"5051\"},{\"id\":\"2787\",\"count\":\"2\",\"chance\":\"5033\"},{\"id\":\"10600\",\"count\":1,\"chance\":\"4983\"},{\"id\":\"2790\",\"count\":1,\"chance\":\"1817\"},{\"id\":\"7588\",\"count\":1,\"chance\":\"1081\"},{\"id\":\"2213\",\"count\":1,\"chance\":\"655\"},{\"id\":\"2149\",\"count\":1,\"chance\":\"646\"},{\"id\":\"7443\",\"count\":1,\"chance\":\"103\"}]'),
(1757, 0, 'Haunter', 0, 4000, 8500, 25, 1, '[\"Surrender and I\'ll end it quick!\"]', '[\"invisible\"]', 0, 0, 'blood', '[]'),
(1758, 0, 'Hell Hole', 0, 0, 100, 1, 0, '[]', '[\"physical\",\"energy\",\"fire\",\"poison\",\"ice\",\"holy\",\"death\",\"lifedrain\",\"paralyze\",\"drown\",\"invisible\"]', 0, 0, 'undead', '[]');
INSERT INTO `myaac_monsters` (`id`, `hidden`, `name`, `mana`, `exp`, `health`, `speed_lvl`, `use_haste`, `voices`, `immunities`, `summonable`, `convinceable`, `race`, `loot`) VALUES
(1759, 0, 'Hellfire Fighter', 0, 3900, 3800, 1, 0, '[]', '[\"fire\",\"paralyze\",\"invisible\"]', 0, 0, 'fire', '[{\"id\":2127,\"count\":1,\"chance\":\"2200\"},{\"id\":\"2136\",\"count\":1,\"chance\":\"190\"},{\"id\":2145,\"count\":1,\"chance\":\"1400\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"50000\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"40000\"},{\"id\":2148,\"count\":\"46\",\"chance\":\"10000\"},{\"id\":2172,\"count\":1,\"chance\":\"1000\"},{\"id\":2187,\"count\":1,\"chance\":\"9450\"},{\"id\":2239,\"count\":1,\"chance\":\"50000\"},{\"id\":2260,\"count\":\"2\",\"chance\":\"30000\"},{\"id\":2392,\"count\":1,\"chance\":\"4140\"},{\"id\":2432,\"count\":1,\"chance\":\"440\"},{\"id\":5944,\"count\":1,\"chance\":\"12150\"},{\"id\":6500,\"count\":1,\"chance\":\"14500\"},{\"id\":7894,\"count\":1,\"chance\":\"730\"},{\"id\":7899,\"count\":1,\"chance\":\"470\"},{\"id\":10553,\"count\":1,\"chance\":\"9570\"},{\"id\":10581,\"count\":1,\"chance\":\"5060\"},{\"id\":\"13757\",\"count\":1,\"chance\":\"670\"}]'),
(1760, 0, 'Hellgorak', 0, 10000, 25850, 55, 0, '[\"I\'ll sacrifice yours souls to seven!\",\"I\'m bad news for you mortals!\",\"No man can defeat me!\",\"Your puny skills are no match for me.\",\"I smell your fear.\",\"Delicious!\"]', '[\"lifedrain\",\"paralyze\",\"invisible\"]', 0, 0, 'fire', '[{\"id\":\"6500\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2148\",\"count\":\"198\",\"chance\":\"100000\"},{\"id\":\"9813\",\"count\":1,\"chance\":\"51393\"},{\"id\":\"8473\",\"count\":\"2\",\"chance\":\"42605\"},{\"id\":\"9810\",\"count\":1,\"chance\":\"32476\"},{\"id\":\"8901\",\"count\":1,\"chance\":\"30493\"},{\"id\":\"3962\",\"count\":1,\"chance\":\"29957\"},{\"id\":\"8472\",\"count\":1,\"chance\":\"21115\"},{\"id\":\"2152\",\"count\":\"30\",\"chance\":\"20579\"},{\"id\":\"2487\",\"count\":1,\"chance\":\"18435\"},{\"id\":\"7591\",\"count\":1,\"chance\":\"18274\"},{\"id\":\"7590\",\"count\":1,\"chance\":\"17899\"},{\"id\":\"2125\",\"count\":1,\"chance\":\"14362\"},{\"id\":\"2144\",\"count\":\"25\",\"chance\":\"14148\"},{\"id\":\"2147\",\"count\":\"25\",\"chance\":\"13130\"},{\"id\":\"2143\",\"count\":\"25\",\"chance\":\"13076\"},{\"id\":\"2145\",\"count\":\"25\",\"chance\":\"12808\"},{\"id\":\"7456\",\"count\":1,\"chance\":\"12165\"},{\"id\":\"2150\",\"count\":\"25\",\"chance\":\"12004\"},{\"id\":\"2149\",\"count\":\"25\",\"chance\":\"11790\"},{\"id\":\"2146\",\"count\":\"25\",\"chance\":\"11576\"},{\"id\":\"9970\",\"count\":\"25\",\"chance\":\"11415\"},{\"id\":\"7894\",\"count\":1,\"chance\":\"11093\"},{\"id\":\"8870\",\"count\":1,\"chance\":\"10343\"},{\"id\":\"2133\",\"count\":1,\"chance\":\"10129\"},{\"id\":\"8902\",\"count\":1,\"chance\":\"10021\"},{\"id\":\"2488\",\"count\":1,\"chance\":\"9914\"},{\"id\":\"2197\",\"count\":1,\"chance\":\"9753\"},{\"id\":\"2130\",\"count\":1,\"chance\":\"9700\"},{\"id\":\"5954\",\"count\":\"2\",\"chance\":\"9539\"},{\"id\":\"2645\",\"count\":1,\"chance\":\"9539\"},{\"id\":\"8871\",\"count\":1,\"chance\":\"9486\"},{\"id\":\"8903\",\"count\":1,\"chance\":\"8896\"},{\"id\":\"2477\",\"count\":1,\"chance\":\"8789\"},{\"id\":\"2656\",\"count\":1,\"chance\":\"8039\"},{\"id\":\"7412\",\"count\":1,\"chance\":\"2304\"},{\"id\":\"2466\",\"count\":1,\"chance\":\"2036\"},{\"id\":\"7388\",\"count\":1,\"chance\":\"1179\"},{\"id\":\"8904\",\"count\":1,\"chance\":\"1018\"},{\"id\":\"7453\",\"count\":1,\"chance\":\"804\"},{\"id\":\"2470\",\"count\":1,\"chance\":\"643\"},{\"id\":\"2136\",\"count\":1,\"chance\":\"589\"},{\"id\":\"8879\",\"count\":1,\"chance\":\"375\"},{\"id\":\"8926\",\"count\":1,\"chance\":\"322\"},{\"id\":\"2415\",\"count\":1,\"chance\":\"268\"},{\"id\":\"8918\",\"count\":1,\"chance\":\"161\"}]'),
(1761, 0, 'Hellhound', 0, 5440, 7500, 70, 1, '[\"GROOOWL!\",\"GRRRRR!\"]', '[\"paralyze\",\"outfit\",\"drunk\",\"invisible\",\"fire\"]', 0, 0, 'blood', '[{\"id\":\"2152\",\"count\":\"7\",\"chance\":\"100000\"},{\"id\":\"2671\",\"count\":1,\"chance\":\"30654\"},{\"id\":\"7590\",\"count\":\"3\",\"chance\":\"29039\"},{\"id\":\"7368\",\"count\":\"10\",\"chance\":\"24901\"},{\"id\":\"6500\",\"count\":1,\"chance\":\"21552\"},{\"id\":\"10554\",\"count\":1,\"chance\":\"20449\"},{\"id\":\"6558\",\"count\":1,\"chance\":\"20331\"},{\"id\":\"8472\",\"count\":1,\"chance\":\"19819\"},{\"id\":\"5944\",\"count\":1,\"chance\":\"19622\"},{\"id\":\"8473\",\"count\":1,\"chance\":\"15288\"},{\"id\":\"18425\",\"count\":1,\"chance\":\"13396\"},{\"id\":\"2149\",\"count\":\"3\",\"chance\":\"11072\"},{\"id\":\"5925\",\"count\":1,\"chance\":\"10914\"},{\"id\":\"9970\",\"count\":\"3\",\"chance\":\"10402\"},{\"id\":\"10553\",\"count\":1,\"chance\":\"9890\"},{\"id\":\"2147\",\"count\":\"3\",\"chance\":\"9614\"},{\"id\":\"2144\",\"count\":\"4\",\"chance\":\"9456\"},{\"id\":\"2187\",\"count\":1,\"chance\":\"8353\"},{\"id\":\"2430\",\"count\":1,\"chance\":\"7486\"},{\"id\":\"2392\",\"count\":1,\"chance\":\"6422\"},{\"id\":\"5914\",\"count\":1,\"chance\":\"5792\"},{\"id\":\"5910\",\"count\":1,\"chance\":\"5280\"},{\"id\":\"2156\",\"count\":1,\"chance\":\"4610\"},{\"id\":\"2154\",\"count\":1,\"chance\":\"4452\"},{\"id\":\"5911\",\"count\":1,\"chance\":\"3034\"},{\"id\":\"9971\",\"count\":1,\"chance\":\"2955\"},{\"id\":\"7890\",\"count\":1,\"chance\":\"2561\"},{\"id\":\"7426\",\"count\":1,\"chance\":\"2049\"},{\"id\":\"7894\",\"count\":1,\"chance\":\"1458\"},{\"id\":\"7891\",\"count\":1,\"chance\":\"1340\"},{\"id\":\"2231\",\"count\":1,\"chance\":\"985\"},{\"id\":\"2155\",\"count\":1,\"chance\":\"985\"},{\"id\":\"7899\",\"count\":1,\"chance\":\"985\"},{\"id\":\"7900\",\"count\":1,\"chance\":\"985\"},{\"id\":\"7421\",\"count\":1,\"chance\":\"867\"},{\"id\":\"2393\",\"count\":1,\"chance\":\"827\"},{\"id\":\"6553\",\"count\":1,\"chance\":\"788\"},{\"id\":\"4873\",\"count\":1,\"chance\":\"276\"}]'),
(1762, 0, 'Hellspawn', 0, 2550, 3500, 62, 1, '[\"Your fragile bones are like toothpicks to me.\",\"You little weasel will not live to see another day.\",\"I\'m just a messenger of what\'s yet to come.\",\"HRAAAAAAAAAAAAAAAARRRR\",\"I\'m taking you down with me!\"]', '[\"paralyze\",\"invisible\"]', 0, 0, 'fire', '[{\"id\":\"2148\",\"count\":\"236\",\"chance\":\"92683\"},{\"id\":\"7591\",\"count\":1,\"chance\":\"30215\"},{\"id\":\"11221\",\"count\":1,\"chance\":\"14587\"},{\"id\":\"2394\",\"count\":1,\"chance\":\"7720\"},{\"id\":\"6500\",\"count\":1,\"chance\":\"7483\"},{\"id\":\"8473\",\"count\":1,\"chance\":\"7317\"},{\"id\":\"7368\",\"count\":\"2\",\"chance\":\"7151\"},{\"id\":\"2513\",\"count\":1,\"chance\":\"6938\"},{\"id\":\"2788\",\"count\":\"2\",\"chance\":\"6299\"},{\"id\":\"9970\",\"count\":\"3\",\"chance\":\"4736\"},{\"id\":\"9809\",\"count\":1,\"chance\":\"2226\"},{\"id\":\"2477\",\"count\":1,\"chance\":\"2202\"},{\"id\":\"2475\",\"count\":1,\"chance\":\"1397\"},{\"id\":\"7452\",\"count\":1,\"chance\":\"521\"},{\"id\":\"7439\",\"count\":1,\"chance\":\"497\"},{\"id\":\"9969\",\"count\":1,\"chance\":\"213\"},{\"id\":\"9810\",\"count\":1,\"chance\":\"189\"},{\"id\":\"9948\",\"count\":1,\"chance\":\"71\"},{\"id\":\"7421\",\"count\":1,\"chance\":\"24\"}]'),
(1763, 0, 'Heoni', 0, 515, 900, 40, 1, '[\"Shriiiek\"]', '[\"drunk\",\"invisible\"]', 0, 0, 'blood', '[]'),
(1764, 0, 'Herald of Gloom', 0, 450, 350, 20, 1, '[\"The powers of light are waning.\",\"You will join us in eternal night!\",\"The shadows will engulf the world.\"]', '[\"paralyze\",\"invisible\"]', 0, 0, 'undead', '[{\"id\":10531,\"count\":1,\"chance\":\"1886\"}]'),
(1765, 0, 'Hero', 0, 1200, 1400, 30, 0, '[\"Let\'s have a fight!\",\"Welcome to my battleground!\",\"Have you seen princess Lumelia?\",\"I will sing a tune at your grave.\"]', '[\"paralyze\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2148\",\"count\":\"100\",\"chance\":\"60324\"},{\"id\":\"1949\",\"count\":1,\"chance\":\"45128\"},{\"id\":\"2544\",\"count\":\"13\",\"chance\":\"27005\"},{\"id\":\"2744\",\"count\":1,\"chance\":\"20384\"},{\"id\":\"2681\",\"count\":1,\"chance\":\"20164\"},{\"id\":\"2456\",\"count\":1,\"chance\":\"13005\"},{\"id\":\"7364\",\"count\":\"4\",\"chance\":\"11558\"},{\"id\":\"2666\",\"count\":1,\"chance\":\"8585\"},{\"id\":\"2652\",\"count\":1,\"chance\":\"7964\"},{\"id\":\"2121\",\"count\":1,\"chance\":\"5153\"},{\"id\":\"12466\",\"count\":1,\"chance\":\"5038\"},{\"id\":\"2120\",\"count\":1,\"chance\":\"2079\"},{\"id\":\"5911\",\"count\":1,\"chance\":\"2013\"},{\"id\":\"2377\",\"count\":1,\"chance\":\"1612\"},{\"id\":\"2071\",\"count\":1,\"chance\":\"1577\"},{\"id\":\"2661\",\"count\":1,\"chance\":\"1120\"},{\"id\":\"2391\",\"count\":1,\"chance\":\"959\"},{\"id\":\"12406\",\"count\":1,\"chance\":\"952\"},{\"id\":\"7591\",\"count\":1,\"chance\":\"736\"},{\"id\":\"2487\",\"count\":1,\"chance\":\"614\"},{\"id\":\"2488\",\"count\":1,\"chance\":\"586\"},{\"id\":\"2164\",\"count\":1,\"chance\":\"527\"},{\"id\":\"2392\",\"count\":1,\"chance\":\"478\"},{\"id\":\"2491\",\"count\":1,\"chance\":\"450\"},{\"id\":\"2519\",\"count\":1,\"chance\":\"202\"},{\"id\":\"2114\",\"count\":1,\"chance\":\"73\"}]'),
(1766, 0, 'Hide', 0, 240, 500, 30, 1, '[]', '[\"outfit\",\"drunk\",\"invisible\",\"earth\"]', 0, 0, 'venom', '[{\"id\":2152,\"count\":\"5\",\"chance\":\"100000\"},{\"id\":\"2169\",\"count\":1,\"chance\":\"33333\"},{\"id\":2457,\"count\":1,\"chance\":\"50000\"},{\"id\":2477,\"count\":1,\"chance\":\"50000\"},{\"id\":5879,\"count\":1,\"chance\":\"50000\"},{\"id\":7903,\"count\":1,\"chance\":\"50000\"}]'),
(1767, 0, 'Hideous Fungus', 0, 2900, 4600, 20, 0, '[\"Munch munch munch!\"]', '[\"earth\",\"paralyze\",\"invisible\"]', 0, 0, 'venom', '[{\"id\":2148,\"count\":\"100\",\"chance\":\"70000\"},{\"id\":2148,\"count\":\"97\",\"chance\":\"70000\"},{\"id\":2152,\"count\":\"7\",\"chance\":\"100000\"},{\"id\":2391,\"count\":1,\"chance\":\"4010\"},{\"id\":5909,\"count\":1,\"chance\":\"6430\"},{\"id\":5910,\"count\":1,\"chance\":\"3003\"},{\"id\":5911,\"count\":1,\"chance\":\"1820\"},{\"id\":5912,\"count\":1,\"chance\":\"3700\"},{\"id\":7590,\"count\":1,\"chance\":\"7692\"},{\"id\":7591,\"count\":1,\"chance\":\"7220\"},{\"id\":7620,\"count\":1,\"chance\":\"9090\"},{\"id\":7884,\"count\":1,\"chance\":\"800\"},{\"id\":7885,\"count\":1,\"chance\":\"920\"},{\"id\":7886,\"count\":1,\"chance\":\"2000\"},{\"id\":7887,\"count\":1,\"chance\":\"2000\"},{\"id\":18393,\"count\":1,\"chance\":\"20\"},{\"id\":18397,\"count\":\"3\",\"chance\":\"14500\"},{\"id\":18411,\"count\":1,\"chance\":\"590\"},{\"id\":18434,\"count\":1,\"chance\":\"14285\"},{\"id\":18437,\"count\":\"15\",\"chance\":\"14500\"},{\"id\":18454,\"count\":1,\"chance\":\"60\"}]'),
(1768, 0, 'High Templar Cobrass', 0, 515, 410, 1, 0, '[\"Hissss!\"]', '[\"earth\"]', 0, 0, 'blood', '[{\"id\":2148,\"count\":\"100\",\"chance\":\"100000\"},{\"id\":5881,\"count\":1,\"chance\":\"100000\"},{\"id\":5876,\"count\":1,\"chance\":\"100000\"},{\"id\":2406,\"count\":1,\"chance\":\"10000\"},{\"id\":\"2376\",\"count\":1,\"chance\":\"5200\"},{\"id\":2457,\"count\":1,\"chance\":\"2500\"},{\"id\":2394,\"count\":1,\"chance\":\"2490\"},{\"id\":2463,\"count\":1,\"chance\":\"1500\"},{\"id\":7618,\"count\":1,\"chance\":\"1320\"},{\"id\":3963,\"count\":1,\"chance\":\"1050\"},{\"id\":2149,\"count\":1,\"chance\":\"760\"},{\"id\":3975,\"count\":1,\"chance\":\"610\"}]'),
(1769, 0, 'Hive Overseer', 0, 5500, 7500, 1, 0, '[\"Zopp!\",\"Kropp!\"]', '[\"earth\",\"invisible\"]', 0, 0, 'venom', '[{\"id\":2147,\"count\":\"2\",\"chance\":\"16000\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"40000\"},{\"id\":2148,\"count\":\"98\",\"chance\":\"58000\"},{\"id\":2152,\"count\":\"6\",\"chance\":\"84000\"},{\"id\":2645,\"count\":1,\"chance\":\"550\"},{\"id\":7590,\"count\":1,\"chance\":\"18000\"},{\"id\":\"7632\",\"count\":1,\"chance\":\"6000\"},{\"id\":8473,\"count\":1,\"chance\":\"12000\"},{\"id\":9971,\"count\":1,\"chance\":\"29000\"},{\"id\":15480,\"count\":1,\"chance\":\"28000\"},{\"id\":15486,\"count\":1,\"chance\":\"16000\"},{\"id\":15489,\"count\":1,\"chance\":\"830\"},{\"id\":15491,\"count\":1,\"chance\":\"920\"},{\"id\":15492,\"count\":1,\"chance\":\"1650\"},{\"id\":15572,\"count\":\"2\",\"chance\":\"13000\"},{\"id\":15643,\"count\":1,\"chance\":\"830\"}]'),
(1770, 0, 'Hive Pore', 0, 0, 1, 1, 0, '[]', '[\"physical\",\"energy\",\"fire\",\"earth\",\"drown\",\"ice\",\"holy\",\"death\",\"lifedrain\",\"manadrain\",\"paralyze\",\"drunk\",\"outfit\",\"invisible\"]', 0, 0, 'venom', '[]'),
(1771, 0, 'Honour Guard', 0, 55, 85, 1, 0, '[\"Horestis curse upon you!\",\"Vengeance!\",\"Thy punishment is at hand!\",\"For the pharao!\"]', '[\"death\"]', 0, 0, 'undead', '[{\"id\":2148,\"count\":\"15\",\"chance\":\"50000\"},{\"id\":2159,\"count\":1,\"chance\":\"2600\"},{\"id\":2398,\"count\":1,\"chance\":\"3760\"},{\"id\":\"2419\",\"count\":1,\"chance\":\"1640\"},{\"id\":2789,\"count\":\"2\",\"chance\":\"6120\"},{\"id\":12437,\"count\":1,\"chance\":\"8700\"}]'),
(1772, 0, 'Horadron', 0, 18000, 30000, 50, 0, '[\"Even I fear the wrath of the princes. And the cold touch of those whom they serve! You are not prepared!\",\"You foolish mortals with you medding you brought the end upon your world!\",\"After all those aeons I smell freedom at last!\"]', '[\"poison\",\"lifedrain\",\"paralyze\",\"outfit\",\"drunk\",\"invisible\"]', 0, 0, 'fire', '[{\"id\":\"22396\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"5954\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"6500\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"22397\",\"count\":1,\"chance\":\"13850\"},{\"id\":\"22610\",\"count\":1,\"chance\":\"5380\"},{\"id\":\"2148\",\"count\":\"100\",\"chance\":\"50000\"},{\"id\":\"2148\",\"count\":\"100\",\"chance\":\"50000\"},{\"id\":\"2152\",\"count\":\"50\",\"chance\":\"100000\"},{\"id\":\"22598\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"8903\",\"count\":1,\"chance\":\"5130\"},{\"id\":\"8901\",\"count\":1,\"chance\":\"35900\"},{\"id\":\"8902\",\"count\":1,\"chance\":\"10260\"},{\"id\":\"3962\",\"count\":1,\"chance\":\"33330\"},{\"id\":\"7456\",\"count\":1,\"chance\":\"12820\"},{\"id\":\"7453\",\"count\":1,\"chance\":\"2560\"},{\"id\":\"7388\",\"count\":1,\"chance\":\"2560\"},{\"id\":\"2466\",\"count\":1,\"chance\":\"1220\"},{\"id\":\"2656\",\"count\":1,\"chance\":\"1220\"},{\"id\":\"2487\",\"count\":1,\"chance\":\"17950\"},{\"id\":\"2470\",\"count\":1,\"chance\":\"250\"},{\"id\":\"2415\",\"count\":1,\"chance\":\"90\"},{\"id\":\"8926\",\"count\":1,\"chance\":\"90\"},{\"id\":\"7895\",\"count\":1,\"chance\":\"1750\"},{\"id\":\"2477\",\"count\":1,\"chance\":\"1750\"},{\"id\":\"2488\",\"count\":1,\"chance\":\"20510\"},{\"id\":\"2645\",\"count\":1,\"chance\":\"15380\"},{\"id\":\"2145\",\"count\":\"25\",\"chance\":\"17950\"},{\"id\":\"2150\",\"count\":\"25\",\"chance\":\"5130\"},{\"id\":\"2149\",\"count\":\"25\",\"chance\":\"10260\"},{\"id\":\"2146\",\"count\":\"25\",\"chance\":\"28210\"},{\"id\":\"9970\",\"count\":\"25\",\"chance\":\"15380\"},{\"id\":\"2147\",\"count\":\"25\",\"chance\":\"20510\"}]'),
(1773, 0, 'Horestis', 0, 3500, 6000, 28, 0, '[\"Feel my eternal wrath!\",\"I might be dead but I\'m not gone!\",\"Receive a lesson of the past!\"]', '[\"death\",\"paralyze\",\"invisible\"]', 0, 0, 'undead', '[{\"id\":2134,\"count\":1,\"chance\":\"12500\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"17000\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"17000\"},{\"id\":2148,\"count\":\"43\",\"chance\":\"17000\"},{\"id\":2152,\"count\":\"5\",\"chance\":\"33333\"},{\"id\":2159,\"count\":\"5\",\"chance\":\"14285\"},{\"id\":2446,\"count\":1,\"chance\":\"5000\"},{\"id\":2447,\"count\":1,\"chance\":\"2500\"},{\"id\":7590,\"count\":\"3\",\"chance\":\"10000\"},{\"id\":7591,\"count\":\"4\",\"chance\":\"5000\"},{\"id\":\"9813\",\"count\":1,\"chance\":\"2500\"},{\"id\":11207,\"count\":1,\"chance\":\"2500\"},{\"id\":\"13472\",\"count\":1,\"chance\":\"16666\"},{\"id\":13498,\"count\":1,\"chance\":\"100000\"},{\"id\":\"13739\",\"count\":1,\"chance\":\"12500\"}]'),
(1774, 0, 'Hot Dog', 220, 190, 505, 40, 0, '[\"Wuff Wuff\",\"Grrr Wuff\",\"Show me how good you are without some rolled newspaper!\"]', '[\"fire\",\"drown\",\"lifedrain\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":2148,\"count\":\"75\",\"chance\":\"50000\"}]'),
(1775, 0, 'Humongous Fungus', 0, 2600, 3400, 25, 0, '[\"Munch munch munch!\"]', '[\"earth\",\"paralyze\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":2148,\"count\":\"100\",\"chance\":\"60000\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"60000\"},{\"id\":2152,\"count\":\"6\",\"chance\":\"100000\"},{\"id\":5909,\"count\":1,\"chance\":\"10000\"},{\"id\":5911,\"count\":1,\"chance\":\"2941\"},{\"id\":5912,\"count\":1,\"chance\":\"4545\"},{\"id\":5913,\"count\":1,\"chance\":\"15285\"},{\"id\":7436,\"count\":1,\"chance\":\"1265\"},{\"id\":7588,\"count\":\"2\",\"chance\":\"5000\"},{\"id\":7589,\"count\":\"2\",\"chance\":\"5000\"},{\"id\":7590,\"count\":\"2\",\"chance\":\"5000\"},{\"id\":7591,\"count\":\"2\",\"chance\":\"5000\"},{\"id\":7620,\"count\":\"3\",\"chance\":\"5000\"},{\"id\":7884,\"count\":1,\"chance\":\"869\"},{\"id\":7885,\"count\":1,\"chance\":\"1123\"},{\"id\":7886,\"count\":1,\"chance\":\"1851\"},{\"id\":7887,\"count\":1,\"chance\":\"2127\"},{\"id\":18393,\"count\":1,\"chance\":\"20\"},{\"id\":18397,\"count\":\"3\",\"chance\":\"16666\"},{\"id\":18411,\"count\":1,\"chance\":\"680\"},{\"id\":18433,\"count\":1,\"chance\":\"10000\"},{\"id\":18436,\"count\":\"15\",\"chance\":\"14285\"},{\"id\":18454,\"count\":1,\"chance\":\"150\"}]'),
(1776, 0, 'Humorless Fungus', 0, 0, 2500, 5, 0, '[\"Munch munch munch!\",\"Chatter\"]', '[\"earth\",\"paralyze\",\"invisible\"]', 0, 0, 'venom', '[]'),
(1777, 0, 'Hunter', 530, 150, 150, 1, 0, '[\"Guess who we\'re hunting, haha!\",\"Guess who we are hunting!\",\"Bullseye!\",\"You\'ll make a nice trophy!\"]', '[]', 0, 1, 'blood', '[{\"id\":\"2544\",\"count\":\"22\",\"chance\":\"82000\"},{\"id\":2675,\"count\":\"2\",\"chance\":\"20300\"},{\"id\":2690,\"count\":\"2\",\"chance\":\"11370\"},{\"id\":12425,\"count\":1,\"chance\":\"10240\"},{\"id\":2456,\"count\":1,\"chance\":\"5770\"},{\"id\":\"2546\",\"count\":\"3\",\"chance\":\"5360\"},{\"id\":2465,\"count\":1,\"chance\":\"5070\"},{\"id\":2460,\"count\":1,\"chance\":\"5050\"},{\"id\":2545,\"count\":\"4\",\"chance\":\"4500\"},{\"id\":2201,\"count\":1,\"chance\":\"3000\"},{\"id\":\"2050\",\"count\":1,\"chance\":\"3300\"},{\"id\":5875,\"count\":1,\"chance\":\"610\"},{\"id\":\"7397\",\"count\":1,\"chance\":\"520\"},{\"id\":2147,\"count\":1,\"chance\":\"170\"},{\"id\":\"7400\",\"count\":1,\"chance\":\"140\"},{\"id\":\"7394\",\"count\":1,\"chance\":\"130\"},{\"id\":5907,\"count\":1,\"chance\":\"120\"}]'),
(1778, 0, 'Husky', 420, 0, 140, 15, 0, '[\"Yoooohuuuu!\",\"Grrrrrrr\",\"Ruff, ruff!\"]', '[]', 1, 1, 'blood', '[]'),
(1779, 0, 'Hyaena', 275, 20, 60, 1, 0, '[\"Grrrrrr\",\"Hou hou hou!\"]', '[]', 1, 1, 'blood', '[{\"id\":3976,\"count\":\"3\",\"chance\":\"50130\"},{\"id\":2666,\"count\":\"2\",\"chance\":\"30860\"}]'),
(1780, 0, 'Hydra', 0, 2100, 2350, 1, 0, '[\"FCHHHHH\",\"HISSSS\"]', '[\"earth\",\"lifedrain\",\"paralyze\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2148\",\"count\":\"246\",\"chance\":\"87759\"},{\"id\":\"2671\",\"count\":1,\"chance\":\"60233\"},{\"id\":\"2152\",\"count\":\"3\",\"chance\":\"49522\"},{\"id\":\"11199\",\"count\":1,\"chance\":\"10149\"},{\"id\":\"2146\",\"count\":1,\"chance\":\"4949\"},{\"id\":\"8842\",\"count\":1,\"chance\":\"4941\"},{\"id\":\"2214\",\"count\":1,\"chance\":\"1215\"},{\"id\":\"2476\",\"count\":1,\"chance\":\"1098\"},{\"id\":\"4850\",\"count\":1,\"chance\":\"942\"},{\"id\":\"2197\",\"count\":1,\"chance\":\"902\"},{\"id\":\"2475\",\"count\":1,\"chance\":\"823\"},{\"id\":\"2177\",\"count\":1,\"chance\":\"512\"},{\"id\":\"7589\",\"count\":1,\"chance\":\"465\"},{\"id\":\"2536\",\"count\":1,\"chance\":\"223\"},{\"id\":\"2498\",\"count\":1,\"chance\":\"223\"},{\"id\":\"2195\",\"count\":1,\"chance\":\"95\"}]'),
(1781, 0, 'Ice Golem', 0, 295, 385, 1, 0, '[\"Chrrr.\",\"Crrrrk.\",\"Gnarr.\"]', '[\"holy\",\"death\",\"fire\",\"ice\",\"invisible\",\"paralyze\",\"drunk\"]', 0, 0, 'undead', '[{\"id\":2144,\"count\":1,\"chance\":\"1612\"},{\"id\":2145,\"count\":1,\"chance\":\"66\"},{\"id\":2146,\"count\":1,\"chance\":\"578\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"50000\"},{\"id\":2148,\"count\":\"3\",\"chance\":\"50000\"},{\"id\":2396,\"count\":1,\"chance\":\"400\"},{\"id\":2479,\"count\":1,\"chance\":\"444\"},{\"id\":7290,\"count\":1,\"chance\":\"266\"},{\"id\":\"7441\",\"count\":1,\"chance\":\"5000\"},{\"id\":7449,\"count\":1,\"chance\":\"177\"},{\"id\":7588,\"count\":1,\"chance\":\"444\"},{\"id\":7902,\"count\":1,\"chance\":\"111\"},{\"id\":10578,\"count\":1,\"chance\":\"11111\"}]'),
(1782, 0, 'Ice Overlord', 0, 2800, 4000, 85, 0, '[]', '[\"fire\",\"ice\",\"earth\",\"drown\",\"invisible\"]', 0, 0, 'undead', '[{\"id\":2148,\"count\":\"38\",\"chance\":\"50000\"},{\"id\":2152,\"count\":\"3\",\"chance\":\"50000\"},{\"id\":8300,\"count\":1,\"chance\":\"100000\"}]'),
(1783, 0, 'Ice Witch', 0, 580, 650, 1, 0, '[\"So you think you are cool?\",\"I hope it is not too cold for you! HeHeHe.\",\"Freeze!\"]', '[\"ice\",\"paralyze\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":2148,\"count\":\"90\",\"chance\":\"29630\"},{\"id\":2423,\"count\":1,\"chance\":\"920\"},{\"id\":2663,\"count\":1,\"chance\":\"430\"},{\"id\":2796,\"count\":1,\"chance\":\"1310\"},{\"id\":7290,\"count\":1,\"chance\":\"530\"},{\"id\":7387,\"count\":1,\"chance\":\"330\"},{\"id\":\"7441\",\"count\":1,\"chance\":\"10000\"},{\"id\":7449,\"count\":1,\"chance\":\"400\"},{\"id\":7459,\"count\":1,\"chance\":\"90\"},{\"id\":7589,\"count\":1,\"chance\":\"820\"},{\"id\":7892,\"count\":1,\"chance\":\"280\"}]'),
(1784, 0, 'Incineron', 0, 3500, 7000, 20, 0, '[]', '[\"paralyze\",\"invisible\",\"fire\",\"ice\"]', 0, 0, 'fire', '[]'),
(1785, 0, 'Incredibly Old Witch', 0, 0, 100, 1, 0, '[\"Feel the wrath of the witch!\",\"Oh how you will regret to have distubed me!\",\"Everyone is so stupid!\",\"Stupid people!\",\"I will teach them all to leave me alone!\"]', '[\"physical\",\"energy\",\"fire\",\"earth\",\"drown\",\"ice\",\"holy\",\"death\",\"lifedrain\",\"manadrain\",\"paralyze\",\"drunk\",\"invisible\"]', 0, 0, 'blood', '[]'),
(1786, 0, 'Infected Weeper', 0, 4800, 6800, 15, 0, '[\"Moooaaan!\"]', '[\"fire\",\"earth\",\"paralyze\",\"invisible\"]', 0, 0, 'fire', '[{\"id\":2148,\"count\":\"100\",\"chance\":\"50000\"},{\"id\":2148,\"count\":\"98\",\"chance\":\"50000\"},{\"id\":2152,\"count\":\"7\",\"chance\":\"100000\"},{\"id\":\"8748\",\"count\":1,\"chance\":\"1460\"}]'),
(1787, 0, 'Infernal Frog', 0, 190, 655, 1, 1, '[\"Ribbit!\",\"Ribbit! Ribbit!\",\"No Kisses for you!\"]', '[\"earth\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":2148,\"count\":\"65\",\"chance\":\"77000\"}]'),
(1788, 0, 'Infernalist', 0, 4000, 3650, 1, 0, '[\"Nothing will remain but your scorched bones!\",\"Some like it hot!\",\"It\'s cooking time!\",\"Feel the heat of battle!\"]', '[\"energy\",\"fire\",\"paralyze\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":1986,\"count\":1,\"chance\":\"300\"},{\"id\":2114,\"count\":1,\"chance\":\"220\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"56500\"},{\"id\":2148,\"count\":\"47\",\"chance\":\"40000\"},{\"id\":2167,\"count\":1,\"chance\":\"1800\"},{\"id\":2436,\"count\":1,\"chance\":\"6500\"},{\"id\":5904,\"count\":1,\"chance\":\"600\"},{\"id\":5911,\"count\":1,\"chance\":\"1420\"},{\"id\":7590,\"count\":1,\"chance\":\"19700\"},{\"id\":7591,\"count\":1,\"chance\":\"1900\"},{\"id\":7760,\"count\":1,\"chance\":\"4250\"},{\"id\":7891,\"count\":1,\"chance\":\"300\"},{\"id\":8840,\"count\":\"5\",\"chance\":\"8500\"},{\"id\":8902,\"count\":1,\"chance\":\"370\"},{\"id\":9958,\"count\":1,\"chance\":\"520\"},{\"id\":9969,\"count\":1,\"chance\":\"820\"},{\"id\":9971,\"count\":1,\"chance\":\"70\"},{\"id\":9980,\"count\":1,\"chance\":\"220\"}]'),
(1789, 0, 'Infernatil', 0, 85000, 270000, 193, 1, '[\"Worship Zathroth pathetic mortal!\",\"Your soul will be mine!\",\"ASHES TO ASHES!\",\"YOU WILL ALL BURN!\",\"THE DAY OF RECKONING IS AT HAND!\",\"BOW TO THE POWER OF THE RUTHLESS SEVEN!\"]', '[\"energy\",\"fire\",\"earth\",\"lifedrain\",\"paralyze\",\"outfit\",\"drunk\",\"invisible\"]', 0, 0, 'fire', '[{\"id\":1982,\"count\":1,\"chance\":\"2600\"},{\"id\":2033,\"count\":1,\"chance\":\"7500\"},{\"id\":2112,\"count\":1,\"chance\":\"14500\"},{\"id\":2123,\"count\":1,\"chance\":\"3500\"},{\"id\":\"2124\",\"count\":1,\"chance\":\"5500\"},{\"id\":2125,\"count\":1,\"chance\":\"1500\"},{\"id\":\"2142\",\"count\":1,\"chance\":\"3500\"},{\"id\":2143,\"count\":\"15\",\"chance\":\"12500\"},{\"id\":2144,\"count\":\"15\",\"chance\":\"15000\"},{\"id\":2145,\"count\":\"5\",\"chance\":\"9500\"},{\"id\":2146,\"count\":\"10\",\"chance\":\"13500\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"99900\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"88800\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"77700\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"66600\"},{\"id\":2149,\"count\":\"10\",\"chance\":\"15500\"},{\"id\":2150,\"count\":\"20\",\"chance\":\"13500\"},{\"id\":2151,\"count\":\"7\",\"chance\":\"14000\"},{\"id\":2155,\"count\":1,\"chance\":\"1500\"},{\"id\":2158,\"count\":1,\"chance\":\"1500\"},{\"id\":\"2162\",\"count\":1,\"chance\":\"11500\"},{\"id\":2164,\"count\":1,\"chance\":\"5000\"},{\"id\":2165,\"count\":1,\"chance\":\"9500\"},{\"id\":2167,\"count\":1,\"chance\":\"13500\"},{\"id\":2170,\"count\":1,\"chance\":\"13000\"},{\"id\":2171,\"count\":1,\"chance\":\"4500\"},{\"id\":2174,\"count\":1,\"chance\":\"2500\"},{\"id\":2176,\"count\":1,\"chance\":\"12000\"},{\"id\":2177,\"count\":1,\"chance\":\"1000\"},{\"id\":\"2178\",\"count\":1,\"chance\":\"4000\"},{\"id\":2179,\"count\":1,\"chance\":\"8000\"},{\"id\":2182,\"count\":1,\"chance\":\"3500\"},{\"id\":2185,\"count\":1,\"chance\":\"3500\"},{\"id\":2186,\"count\":1,\"chance\":\"3500\"},{\"id\":2188,\"count\":1,\"chance\":\"2500\"},{\"id\":\"2192\",\"count\":1,\"chance\":\"2500\"},{\"id\":2195,\"count\":1,\"chance\":\"4000\"},{\"id\":2197,\"count\":1,\"chance\":\"4000\"},{\"id\":2200,\"count\":1,\"chance\":\"4500\"},{\"id\":2214,\"count\":1,\"chance\":\"13000\"},{\"id\":\"2231\",\"count\":1,\"chance\":\"9000\"},{\"id\":2377,\"count\":1,\"chance\":\"20000\"},{\"id\":2387,\"count\":1,\"chance\":\"20000\"},{\"id\":2393,\"count\":1,\"chance\":\"12500\"},{\"id\":2396,\"count\":1,\"chance\":\"7500\"},{\"id\":2402,\"count\":1,\"chance\":\"15500\"},{\"id\":2418,\"count\":1,\"chance\":\"4500\"},{\"id\":2421,\"count\":1,\"chance\":\"13500\"},{\"id\":2432,\"count\":1,\"chance\":\"17000\"},{\"id\":2434,\"count\":1,\"chance\":\"4500\"},{\"id\":2436,\"count\":1,\"chance\":\"5000\"},{\"id\":2462,\"count\":1,\"chance\":\"11000\"},{\"id\":2470,\"count\":1,\"chance\":\"5000\"},{\"id\":2472,\"count\":1,\"chance\":\"3000\"},{\"id\":\"2514\",\"count\":1,\"chance\":\"7500\"},{\"id\":2520,\"count\":1,\"chance\":\"15500\"},{\"id\":\"3955\",\"count\":1,\"chance\":\"100\"}]'),
(1790, 0, 'Inky', 670, 250, 600, 150, 0, '[\"Tssss!\",\"Gaaahhh!\",\"Gluh! Gluh!\",\"Boohaa!\"]', '[\"lifedrain\",\"ice\",\"earth\"]', 0, 0, 'blood', '[]'),
(1791, 0, 'Insect Swarm', 0, 40, 50, 1, 0, '[]', '[\"earth\"]', 0, 1, 'undead', '[]'),
(1792, 0, 'Insectoid Scout', 0, 150, 230, 1, 0, '[\"Chrrr! Chrr!\",\"Klk! Klk!\"]', '[\"invisible\"]', 0, 0, 'venom', '[{\"id\":2148,\"count\":\"80\",\"chance\":\"80000\"},{\"id\":2209,\"count\":1,\"chance\":\"100\"},{\"id\":3964,\"count\":1,\"chance\":\"850\"},{\"id\":7618,\"count\":1,\"chance\":\"280\"}]'),
(1793, 0, 'Insectoid Worker', 0, 650, 950, 1, 0, '[]', '[\"earth\",\"invisible\"]', 0, 0, 'venom', '[{\"id\":2148,\"count\":\"90\",\"chance\":\"100000\"},{\"id\":2149,\"count\":1,\"chance\":\"2880\"},{\"id\":2438,\"count\":1,\"chance\":\"560\"},{\"id\":7618,\"count\":1,\"chance\":\"5090\"},{\"id\":15486,\"count\":1,\"chance\":\"15380\"},{\"id\":\"15622\",\"count\":1,\"chance\":\"14990\"}]'),
(1794, 0, 'Iron Servant', 0, 210, 350, 1, 0, '[\"Error. LOAD \'PROGRAM\',8,1\",\"Remain. Obedient.\"]', '[\"invisible\",\"paralyze\"]', 0, 0, 'energy', '[{\"id\":\"2148\",\"count\":\"55\",\"chance\":\"82109\"},{\"id\":\"9690\",\"count\":1,\"chance\":\"4825\"},{\"id\":\"7618\",\"count\":1,\"chance\":\"1964\"},{\"id\":\"2381\",\"count\":1,\"chance\":\"1022\"},{\"id\":\"9808\",\"count\":1,\"chance\":\"504\"},{\"id\":\"13758\",\"count\":1,\"chance\":\"310\"}]'),
(1795, 0, 'Ironblight', 0, 4400, 6600, 33, 0, '[\"Clonk!\",\"Yowl!\"]', '[\"earth\",\"paralyze\",\"invisible\"]', 0, 0, 'undead', '[{\"id\":\"2148\",\"count\":\"199\",\"chance\":\"100000\"},{\"id\":\"2152\",\"count\":\"8\",\"chance\":\"100000\"},{\"id\":\"10571\",\"count\":1,\"chance\":\"21215\"},{\"id\":\"8473\",\"count\":1,\"chance\":\"18606\"},{\"id\":\"18432\",\"count\":1,\"chance\":\"17836\"},{\"id\":\"7590\",\"count\":1,\"chance\":\"17151\"},{\"id\":\"2150\",\"count\":\"3\",\"chance\":\"15141\"},{\"id\":\"11227\",\"count\":1,\"chance\":\"14286\"},{\"id\":\"18417\",\"count\":\"2\",\"chance\":\"12703\"},{\"id\":\"18420\",\"count\":1,\"chance\":\"10736\"},{\"id\":\"2149\",\"count\":\"3\",\"chance\":\"10565\"},{\"id\":\"18415\",\"count\":1,\"chance\":\"5518\"},{\"id\":\"9942\",\"count\":1,\"chance\":\"4962\"},{\"id\":\"2156\",\"count\":1,\"chance\":\"3464\"},{\"id\":\"9980\",\"count\":1,\"chance\":\"2352\"},{\"id\":\"8912\",\"count\":1,\"chance\":\"1668\"},{\"id\":\"18412\",\"count\":1,\"chance\":\"898\"},{\"id\":\"5904\",\"count\":1,\"chance\":\"898\"},{\"id\":\"7885\",\"count\":1,\"chance\":\"898\"},{\"id\":\"7437\",\"count\":1,\"chance\":\"770\"},{\"id\":\"2158\",\"count\":1,\"chance\":\"599\"},{\"id\":\"2438\",\"count\":1,\"chance\":\"599\"},{\"id\":\"2445\",\"count\":1,\"chance\":\"556\"},{\"id\":\"11368\",\"count\":1,\"chance\":\"257\"},{\"id\":\"8855\",\"count\":1,\"chance\":\"171\"}]'),
(1796, 0, 'Island Troll', 290, 20, 50, 1, 0, '[\"Hmmm, turtles\",\"Hmmm, dogs\",\"Hmmm, worms\",\"Groar\",\"Gruntz!\"]', '[]', 1, 1, 'blood', '[{\"id\":\"2148\",\"count\":\"10\",\"chance\":\"59656\"},{\"id\":\"5901\",\"count\":1,\"chance\":\"30727\"},{\"id\":\"2389\",\"count\":1,\"chance\":\"20007\"},{\"id\":\"2380\",\"count\":1,\"chance\":\"17701\"},{\"id\":\"2512\",\"count\":1,\"chance\":\"15244\"},{\"id\":\"2643\",\"count\":1,\"chance\":\"9794\"},{\"id\":\"2461\",\"count\":1,\"chance\":\"9670\"},{\"id\":\"2120\",\"count\":1,\"chance\":\"7889\"},{\"id\":\"2448\",\"count\":1,\"chance\":\"5182\"},{\"id\":\"5097\",\"count\":1,\"chance\":\"5102\"},{\"id\":\"7963\",\"count\":1,\"chance\":\"71\"},{\"id\":\"2170\",\"count\":1,\"chance\":\"71\"}]'),
(1797, 0, 'Jagged Earth Elemental', 0, 1300, 1500, 30, 0, '[\"*STOMP STOMP*\"]', '[\"paralyze\",\"invisible\",\"earth\"]', 0, 0, 'undead', '[{\"id\":\"2148\",\"count\":\"175\",\"chance\":\"87298\"},{\"id\":\"11222\",\"count\":1,\"chance\":\"48625\"},{\"id\":\"1294\",\"count\":\"10\",\"chance\":\"24919\"},{\"id\":\"2245\",\"count\":1,\"chance\":\"20874\"},{\"id\":\"8298\",\"count\":1,\"chance\":\"7686\"},{\"id\":\"2149\",\"count\":\"2\",\"chance\":\"5502\"},{\"id\":\"7732\",\"count\":1,\"chance\":\"2184\"},{\"id\":\"11339\",\"count\":1,\"chance\":\"1133\"},{\"id\":\"13757\",\"count\":1,\"chance\":\"485\"},{\"id\":\"5880\",\"count\":1,\"chance\":\"324\"}]'),
(1798, 0, 'Jaul', 0, 30000, 90000, 170, 0, '[\"QJELL AFAR GOU JEY!!\",\"DIE!! KENH!!\"]', '[\"ice\",\"paralyze\",\"drown\",\"fire\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":15404,\"count\":1,\"chance\":\"25000\"},{\"id\":15406,\"count\":1,\"chance\":\"25000\"},{\"id\":15407,\"count\":1,\"chance\":\"20000\"},{\"id\":\"15408\",\"count\":1,\"chance\":\"33333\"},{\"id\":15410,\"count\":1,\"chance\":\"14285\"},{\"id\":15412,\"count\":1,\"chance\":\"7142\"},{\"id\":15413,\"count\":1,\"chance\":\"50000\"},{\"id\":15414,\"count\":1,\"chance\":\"14285\"}]'),
(1799, 0, 'Jellyfish', 0, 0, 55, 1, 0, '[\"Luuurrrp\"]', '[\"fire\",\"earth\",\"invisible\",\"drown\"]', 0, 0, 'undead', '[{\"id\":2670,\"count\":1,\"chance\":\"8333\"}]'),
(1800, 0, 'Jesse the Wicked', 0, 180, 280, 1, 0, '[\"That banker never saw it coming!\"]', '[]', 0, 0, 'blood', '[{\"id\":14903,\"count\":1,\"chance\":\"100000\"},{\"id\":2152,\"count\":\"85\",\"chance\":\"100000\"}]'),
(1801, 0, 'Juggernaut', 0, 11200, 20000, 60, 1, '[\"RAAARRR!\",\"GRRRRRR!\",\"WAHHHH!\"]', '[\"paralyze\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2148\",\"count\":\"198\",\"chance\":\"87649\"},{\"id\":\"2152\",\"count\":\"15\",\"chance\":\"85549\"},{\"id\":\"2671\",\"count\":1,\"chance\":\"44730\"},{\"id\":\"6500\",\"count\":1,\"chance\":\"30098\"},{\"id\":\"5944\",\"count\":1,\"chance\":\"23144\"},{\"id\":\"7591\",\"count\":\"3\",\"chance\":\"21152\"},{\"id\":\"7590\",\"count\":\"3\",\"chance\":\"20645\"},{\"id\":\"6558\",\"count\":1,\"chance\":\"19775\"},{\"id\":\"7368\",\"count\":\"10\",\"chance\":\"16661\"},{\"id\":\"2149\",\"count\":\"5\",\"chance\":\"13654\"},{\"id\":\"9970\",\"count\":\"5\",\"chance\":\"13003\"},{\"id\":\"2147\",\"count\":\"5\",\"chance\":\"12821\"},{\"id\":\"2150\",\"count\":\"5\",\"chance\":\"12677\"},{\"id\":\"2145\",\"count\":\"5\",\"chance\":\"12387\"},{\"id\":\"7365\",\"count\":\"15\",\"chance\":\"10286\"},{\"id\":\"2156\",\"count\":1,\"chance\":\"9381\"},{\"id\":\"7632\",\"count\":1,\"chance\":\"6918\"},{\"id\":\"9971\",\"count\":\"2\",\"chance\":\"5179\"},{\"id\":\"7413\",\"count\":1,\"chance\":\"4745\"},{\"id\":\"2476\",\"count\":1,\"chance\":\"4382\"},{\"id\":\"7452\",\"count\":1,\"chance\":\"4020\"},{\"id\":\"2155\",\"count\":1,\"chance\":\"2390\"},{\"id\":\"2454\",\"count\":1,\"chance\":\"1594\"},{\"id\":\"2153\",\"count\":1,\"chance\":\"942\"},{\"id\":\"2514\",\"count\":1,\"chance\":\"435\"},{\"id\":\"2136\",\"count\":1,\"chance\":\"362\"},{\"id\":\"2466\",\"count\":1,\"chance\":\"326\"},{\"id\":\"2452\",\"count\":1,\"chance\":\"326\"},{\"id\":\"2578\",\"count\":1,\"chance\":\"181\"}]'),
(1802, 0, 'Killer Caiman', 0, 900, 1500, 1, 1, '[]', '[\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2148\",\"count\":\"180\",\"chance\":\"99997\"},{\"id\":\"2671\",\"count\":1,\"chance\":\"39807\"},{\"id\":\"11196\",\"count\":\"2\",\"chance\":\"24966\"},{\"id\":\"2149\",\"count\":\"5\",\"chance\":\"9963\"},{\"id\":\"2425\",\"count\":1,\"chance\":\"4982\"},{\"id\":\"11245\",\"count\":\"2\",\"chance\":\"4828\"},{\"id\":\"7632\",\"count\":1,\"chance\":\"974\"},{\"id\":\"3982\",\"count\":1,\"chance\":\"486\"}]'),
(1803, 0, 'Killer Rabbit', 220, 160, 205, 40, 1, '[\"Who is lunch NOW?\"]', '[]', 0, 0, 'blood', '[{\"id\":2148,\"count\":\"90\",\"chance\":\"50000\"}]'),
(1804, 0, 'Kitty', 0, 0, 75, 1, 1, '[]', '[\"physical\",\"energy\",\"fire\",\"poison\",\"ice\",\"holy\",\"death\",\"lifedrain\",\"paralyze\",\"invisible\",\"drown\"]', 0, 0, 'blood', '[]'),
(1805, 0, 'Kollos', 0, 2400, 3800, 1, 0, '[\"Zopp!\",\"Flzlzlzlzlzlz!\"]', '[\"earth\",\"invisible\"]', 0, 0, 'venom', '[{\"id\":2147,\"count\":\"2\",\"chance\":\"8180\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"49000\"},{\"id\":2148,\"count\":\"97\",\"chance\":\"50000\"},{\"id\":2152,\"count\":\"3\",\"chance\":\"66000\"},{\"id\":2214,\"count\":1,\"chance\":\"3270\"},{\"id\":2645,\"count\":1,\"chance\":\"130\"},{\"id\":7590,\"count\":\"4\",\"chance\":\"8950\"},{\"id\":\"7632\",\"count\":1,\"chance\":\"2600\"},{\"id\":8473,\"count\":\"3\",\"chance\":\"4000\"},{\"id\":9971,\"count\":1,\"chance\":\"5160\"},{\"id\":15480,\"count\":1,\"chance\":\"15390\"},{\"id\":15486,\"count\":1,\"chance\":\"15720\"},{\"id\":15489,\"count\":1,\"chance\":\"360\"},{\"id\":15491,\"count\":1,\"chance\":\"310\"},{\"id\":15492,\"count\":1,\"chance\":\"700\"},{\"id\":15646,\"count\":1,\"chance\":\"460\"},{\"id\":15648,\"count\":\"5\",\"chance\":\"10210\"}]'),
(1806, 0, 'Kongra', 0, 115, 340, 1, 1, '[\"Hugah!\",\"Ungh! Ungh!\",\"Huaauaauaauaa!\"]', '[]', 0, 0, 'blood', '[{\"id\":\"2148\",\"count\":\"40\",\"chance\":\"88003\"},{\"id\":\"2676\",\"count\":\"12\",\"chance\":\"30813\"},{\"id\":\"12427\",\"count\":1,\"chance\":\"9356\"},{\"id\":\"2200\",\"count\":1,\"chance\":\"1012\"},{\"id\":\"2463\",\"count\":1,\"chance\":\"1007\"},{\"id\":\"5883\",\"count\":1,\"chance\":\"968\"},{\"id\":\"7618\",\"count\":1,\"chance\":\"507\"},{\"id\":\"2166\",\"count\":1,\"chance\":\"310\"},{\"id\":\"2209\",\"count\":1,\"chance\":\"196\"}]'),
(1807, 0, 'Koshei The Deathless', 0, 0, 3000, 85, 0, '[\"Your pain will be beyond imagination!\",\"You can\'t defeat me! I will ressurect and take your soul!\",\"Death is my ally!\",\"Welcome to my domain, visitor!\",\"You will be my toy on the other side!\",\"What a disgusting smell of life!\"]', '[\"death\",\"earth\",\"paralyze\",\"invisible\"]', 0, 0, 'undead', '[{\"id\":2148,\"count\":\"100\",\"chance\":\"100000\"},{\"id\":2148,\"count\":\"12\",\"chance\":\"80000\"},{\"id\":2165,\"count\":1,\"chance\":\"888\"},{\"id\":2171,\"count\":1,\"chance\":\"1666\"},{\"id\":\"2175\",\"count\":1,\"chance\":\"10000\"},{\"id\":2179,\"count\":1,\"chance\":\"900\"},{\"id\":\"2237\",\"count\":1,\"chance\":\"10000\"},{\"id\":\"2401\",\"count\":1,\"chance\":\"10000\"},{\"id\":2535,\"count\":1,\"chance\":\"588\"},{\"id\":2656,\"count\":1,\"chance\":\"709\"},{\"id\":3961,\"count\":1,\"chance\":\"1000\"},{\"id\":7893,\"count\":1,\"chance\":\"688\"}]'),
(1808, 0, 'Kraknaknork\'s Demon', 0, 0, 120, 90, 0, '[\"STEP A BIT CLOSER, RIGHT THERE, HAHAHA!\",\"COME AND DIE!\",\"ROOKIE FOR BREAKFAST\"]', '[\"death\",\"paralyze\",\"invisible\"]', 0, 0, 'fire', '[{\"id\":2148,\"count\":\"100\",\"chance\":\"48025\"},{\"id\":2148,\"count\":\"86\",\"chance\":\"48025\"},{\"id\":2148,\"count\":1,\"chance\":\"24400\"}]'),
(1809, 0, 'Kraknaknork', 220, 300, 80, 80, 0, '[]', '[]', 1, 1, 'blood', '[{\"id\":2666,\"count\":\"2\",\"chance\":\"20000\"},{\"id\":\"2684\",\"count\":\"2\",\"chance\":\"9000\"}]'),
(1810, 0, 'Kreebosh the Exile', 0, 350, 705, 25, 0, '[\"I bet you wish you weren\'t here.\"]', '[\"outfit\",\"drunk\",\"invisible\"]', 0, 0, 'blood', '[]'),
(1811, 0, 'Ladybug', 0, 70, 255, 1, 0, '[\"Nee pah!\"]', '[\"invisible\"]', 0, 0, 'venom', '[{\"id\":2148,\"count\":\"40\",\"chance\":\"65000\"}]'),
(1812, 0, 'Lancer Beetle', 0, 275, 400, 1, 0, '[\"Crump!\"]', '[\"earth\",\"invisible\",\"lifedrain\",\"paralyze\"]', 0, 1, 'venom', '[{\"id\":2148,\"count\":\"61\",\"chance\":\"60000\"},{\"id\":2148,\"count\":\"79\",\"chance\":\"60000\"},{\"id\":2150,\"count\":1,\"chance\":\"247\"},{\"id\":10557,\"count\":1,\"chance\":\"8333\"},{\"id\":10609,\"count\":1,\"chance\":\"4166\"},{\"id\":11372,\"count\":1,\"chance\":\"16666\"},{\"id\":11374,\"count\":1,\"chance\":\"1123\"}]'),
(1813, 0, 'Larva', 355, 44, 70, 1, 0, '[]', '[\"earth\",\"paralyze\"]', 1, 0, 'venom', '[{\"id\":2148,\"count\":\"15\",\"chance\":\"65000\"},{\"id\":2666,\"count\":1,\"chance\":\"15000\"}]'),
(1814, 0, 'Latrivan', 0, 10000, 25000, 85, 0, '[\"I might reward you for killing my brother ~ with a swift dead!\",\"Colateral damage is so fun!\",\"Golgordan you fool!\",\"We are the brothers of fear!\"]', '[\"fire\"]', 0, 0, 'fire', '[{\"id\":\"2148\",\"count\":\"273\",\"chance\":\"100000\"},{\"id\":\"7591\",\"count\":\"2\",\"chance\":\"37674\"},{\"id\":\"2214\",\"count\":1,\"chance\":\"26977\"},{\"id\":\"2387\",\"count\":1,\"chance\":\"19535\"},{\"id\":\"2165\",\"count\":1,\"chance\":\"19535\"},{\"id\":\"2162\",\"count\":1,\"chance\":\"17674\"},{\"id\":\"2150\",\"count\":\"19\",\"chance\":\"16744\"},{\"id\":\"2144\",\"count\":\"15\",\"chance\":\"15814\"},{\"id\":\"2143\",\"count\":\"13\",\"chance\":\"15814\"},{\"id\":\"2402\",\"count\":1,\"chance\":\"14419\"},{\"id\":\"2170\",\"count\":1,\"chance\":\"13953\"},{\"id\":\"6300\",\"count\":1,\"chance\":\"13488\"},{\"id\":\"2146\",\"count\":\"10\",\"chance\":\"13488\"},{\"id\":\"2197\",\"count\":1,\"chance\":\"13488\"},{\"id\":\"2149\",\"count\":\"10\",\"chance\":\"12558\"},{\"id\":\"2520\",\"count\":1,\"chance\":\"11628\"},{\"id\":\"2432\",\"count\":1,\"chance\":\"10698\"},{\"id\":\"9971\",\"count\":1,\"chance\":\"10698\"},{\"id\":\"6500\",\"count\":1,\"chance\":\"10233\"},{\"id\":\"2167\",\"count\":1,\"chance\":\"9767\"},{\"id\":\"2145\",\"count\":\"5\",\"chance\":\"8372\"},{\"id\":\"2393\",\"count\":1,\"chance\":\"6977\"},{\"id\":\"2396\",\"count\":1,\"chance\":\"6977\"},{\"id\":\"2179\",\"count\":1,\"chance\":\"6512\"},{\"id\":\"2462\",\"count\":1,\"chance\":\"5581\"},{\"id\":\"2164\",\"count\":1,\"chance\":\"5581\"},{\"id\":\"7365\",\"count\":\"8\",\"chance\":\"4186\"},{\"id\":\"2200\",\"count\":1,\"chance\":\"4186\"},{\"id\":\"2182\",\"count\":1,\"chance\":\"4186\"},{\"id\":\"2436\",\"count\":1,\"chance\":\"3256\"},{\"id\":\"2192\",\"count\":1,\"chance\":\"2791\"},{\"id\":\"2178\",\"count\":1,\"chance\":\"2791\"},{\"id\":\"2186\",\"count\":1,\"chance\":\"2791\"},{\"id\":\"2195\",\"count\":1,\"chance\":\"2326\"},{\"id\":\"2155\",\"count\":1,\"chance\":\"2326\"},{\"id\":\"2188\",\"count\":1,\"chance\":\"2326\"},{\"id\":\"2158\",\"count\":1,\"chance\":\"1395\"},{\"id\":\"2185\",\"count\":1,\"chance\":\"1395\"},{\"id\":\"2470\",\"count\":1,\"chance\":\"930\"},{\"id\":\"2418\",\"count\":1,\"chance\":\"930\"},{\"id\":\"2514\",\"count\":1,\"chance\":\"930\"},{\"id\":\"7368\",\"count\":1,\"chance\":\"465\"}]'),
(1815, 0, 'Lava Golem', 0, 6200, 9000, 100, 1, '[\"Grrrrunt\"]', '[\"fire\",\"earth\",\"paralyze\",\"invisible\"]', 0, 0, 'fire', '[{\"id\":\"2148\",\"count\":\"200\",\"chance\":\"100000\"},{\"id\":\"2152\",\"count\":\"11\",\"chance\":\"99981\"},{\"id\":\"7620\",\"count\":\"2\",\"chance\":\"20316\"},{\"id\":\"7588\",\"count\":\"2\",\"chance\":\"18903\"},{\"id\":\"7589\",\"count\":\"2\",\"chance\":\"17770\"},{\"id\":\"7590\",\"count\":\"2\",\"chance\":\"16171\"},{\"id\":\"18424\",\"count\":\"2\",\"chance\":\"15186\"},{\"id\":\"8473\",\"count\":1,\"chance\":\"15093\"},{\"id\":\"18425\",\"count\":1,\"chance\":\"14591\"},{\"id\":\"18416\",\"count\":\"2\",\"chance\":\"13885\"},{\"id\":\"10553\",\"count\":1,\"chance\":\"13606\"},{\"id\":\"18435\",\"count\":\"5\",\"chance\":\"12063\"},{\"id\":\"5880\",\"count\":1,\"chance\":\"11617\"},{\"id\":\"18420\",\"count\":1,\"chance\":\"10446\"},{\"id\":\"5914\",\"count\":1,\"chance\":\"7175\"},{\"id\":\"2154\",\"count\":1,\"chance\":\"6413\"},{\"id\":\"18414\",\"count\":1,\"chance\":\"6041\"},{\"id\":\"5909\",\"count\":1,\"chance\":\"4907\"},{\"id\":\"5911\",\"count\":1,\"chance\":\"3569\"},{\"id\":\"7890\",\"count\":1,\"chance\":\"3197\"},{\"id\":\"2187\",\"count\":1,\"chance\":\"3160\"},{\"id\":\"7891\",\"count\":1,\"chance\":\"2602\"},{\"id\":\"2392\",\"count\":1,\"chance\":\"1784\"},{\"id\":\"2432\",\"count\":1,\"chance\":\"1413\"},{\"id\":\"18409\",\"count\":1,\"chance\":\"1338\"},{\"id\":\"2519\",\"count\":1,\"chance\":\"1227\"},{\"id\":\"2156\",\"count\":1,\"chance\":\"1171\"},{\"id\":\"8902\",\"count\":1,\"chance\":\"613\"},{\"id\":\"7899\",\"count\":1,\"chance\":\"428\"}]'),
(1816, 0, 'Lavahole', 0, 0, 1, 1, 0, '[]', '[\"physical\",\"energy\",\"fire\",\"earth\",\"drown\",\"ice\",\"holy\",\"death\",\"lifedrain\",\"manadrain\",\"paralyze\",\"drunk\",\"outfit\",\"invisible\"]', 0, 0, 'undead', '[]'),
(1817, 0, 'Leaf Golem', 390, 45, 90, 1, 0, '[\"*crackle*\",\"*swwwwishhhh*\"]', '[]', 0, 0, 'undead', '[{\"id\":2148,\"count\":\"27\",\"chance\":\"86830\"},{\"id\":2149,\"count\":1,\"chance\":\"1230\"},{\"id\":2787,\"count\":\"3\",\"chance\":\"4940\"},{\"id\":20104,\"count\":1,\"chance\":\"4940\"},{\"id\":21427,\"count\":1,\"chance\":\"15230\"},{\"id\":21428,\"count\":1,\"chance\":\"14350\"}]'),
(1818, 0, 'Lesser Swarmer', 0, 0, 230, 1, 0, '[]', '[\"earth\"]', 0, 0, 'venom', '[]'),
(1819, 0, 'Lethal Lissy', 0, 500, 1450, 10, 0, '[]', '[\"invisible\"]', 0, 0, 'blood', '[{\"id\":2145,\"count\":1,\"chance\":\"100000\"},{\"id\":2148,\"count\":\"40\",\"chance\":\"100000\"},{\"id\":2320,\"count\":1,\"chance\":\"100000\"},{\"id\":2387,\"count\":1,\"chance\":\"1500\"},{\"id\":2463,\"count\":1,\"chance\":\"4000\"},{\"id\":2476,\"count\":1,\"chance\":\"1200\"},{\"id\":\"6100\",\"count\":1,\"chance\":\"100000\"}]'),
(1820, 0, 'Leviathan', 0, 5000, 6000, 269, 0, '[\"CHHHRRRR\",\"HISSSS\"]', '[\"ice\",\"paralyze\",\"invisible\",\"drown\"]', 0, 0, 'blood', '[{\"id\":2146,\"count\":\"3\",\"chance\":\"10000\"},{\"id\":2148,\"count\":\"80\",\"chance\":\"40000\"},{\"id\":2148,\"count\":\"80\",\"chance\":\"40000\"},{\"id\":2152,\"count\":\"6\",\"chance\":\"40000\"}]'),
(1821, 0, 'Lich', 0, 900, 880, 1, 0, '[\"Doomed be the living!\",\"Death awaits all!\",\"Thy living flesh offends me!\",\"Death and Decay!\",\"You will endure agony beyond thy death!\",\"Pain sweet pain!\",\"Come to me my children!\"]', '[\"death\",\"earth\",\"lifedrain\",\"paralyze\",\"invisible\"]', 0, 0, 'undead', '[{\"id\":\"2148\",\"count\":\"139\",\"chance\":\"100000\"},{\"id\":\"2152\",\"count\":1,\"chance\":\"19628\"},{\"id\":\"2175\",\"count\":1,\"chance\":\"10351\"},{\"id\":\"7589\",\"count\":1,\"chance\":\"7810\"},{\"id\":\"2144\",\"count\":\"3\",\"chance\":\"5252\"},{\"id\":\"2143\",\"count\":1,\"chance\":\"4886\"},{\"id\":\"9970\",\"count\":\"3\",\"chance\":\"2439\"},{\"id\":\"2149\",\"count\":\"3\",\"chance\":\"2370\"},{\"id\":\"2532\",\"count\":1,\"chance\":\"2072\"},{\"id\":\"2214\",\"count\":1,\"chance\":\"1637\"},{\"id\":\"2154\",\"count\":1,\"chance\":\"759\"},{\"id\":\"2479\",\"count\":1,\"chance\":\"716\"},{\"id\":\"2178\",\"count\":1,\"chance\":\"418\"},{\"id\":\"2171\",\"count\":1,\"chance\":\"401\"},{\"id\":\"7893\",\"count\":1,\"chance\":\"281\"},{\"id\":\"2436\",\"count\":1,\"chance\":\"273\"},{\"id\":\"2535\",\"count\":1,\"chance\":\"264\"},{\"id\":\"2656\",\"count\":1,\"chance\":\"205\"},{\"id\":\"13291\",\"count\":1,\"chance\":\"43\"}]'),
(1822, 0, 'Lion', 320, 30, 80, 1, 0, '[\"Groarrr!\"]', '[]', 1, 1, 'blood', '[{\"id\":\"2666\",\"count\":1,\"chance\":\"45327\"},{\"id\":\"2671\",\"count\":1,\"chance\":\"19265\"},{\"id\":\"10608\",\"count\":1,\"chance\":\"1148\"}]'),
(1823, 0, 'Little Corym Charlatan', 0, 40, 90, 1, 0, '[\"Squeeeeeeak!\",\"Must have it! Must have it!\",\"Gimme! Gimme!\"]', '[]', 0, 0, 'blood', '[]'),
(1824, 0, 'Lizard Abomination', 0, 1350, 20000, 1, 0, '[\"NOOOO! NOW YOU HERETICS WILL FACE MY GODLY WRATH!\",\"RAAARRRR! I WILL DEVOL YOU!\",\"I WILL MAKE YOU ZHEE!\"]', '[\"earth\",\"invisible\"]', 0, 0, 'blood', '[]'),
(1825, 0, 'Lizard Chosen', 0, 2200, 3050, 26, 0, '[\"Grzzzzzzz!\",\"Garrrblarrrrzzzz!\",\"Kzzzzzz!\"]', '[\"earth\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2148\",\"count\":\"236\",\"chance\":\"97523\"},{\"id\":\"11325\",\"count\":1,\"chance\":\"10048\"},{\"id\":\"7591\",\"count\":\"3\",\"chance\":\"6895\"},{\"id\":\"11327\",\"count\":1,\"chance\":\"5939\"},{\"id\":\"2152\",\"count\":\"5\",\"chance\":\"2997\"},{\"id\":\"12629\",\"count\":1,\"chance\":\"2995\"},{\"id\":\"11326\",\"count\":1,\"chance\":\"2971\"},{\"id\":\"2145\",\"count\":\"5\",\"chance\":\"2537\"},{\"id\":\"5876\",\"count\":1,\"chance\":\"2003\"},{\"id\":\"2528\",\"count\":1,\"chance\":\"1118\"},{\"id\":\"5881\",\"count\":1,\"chance\":\"1035\"},{\"id\":\"11301\",\"count\":1,\"chance\":\"992\"},{\"id\":\"11304\",\"count\":1,\"chance\":\"889\"},{\"id\":\"11303\",\"count\":1,\"chance\":\"809\"},{\"id\":\"11302\",\"count\":1,\"chance\":\"130\"}]'),
(1826, 0, 'Lizard Dragon Priest', 0, 1320, 1450, 1, 0, '[\"I ssssmell warm blood!\"]', '[\"earth\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":2148,\"count\":\"100\",\"chance\":\"5000\"},{\"id\":2148,\"count\":\"88\",\"chance\":\"4400\"},{\"id\":2150,\"count\":\"3\",\"chance\":\"4900\"},{\"id\":2152,\"count\":\"2\",\"chance\":\"4090\"},{\"id\":2154,\"count\":1,\"chance\":\"1000\"},{\"id\":2168,\"count\":1,\"chance\":\"770\"},{\"id\":2181,\"count\":1,\"chance\":\"1001\"},{\"id\":2187,\"count\":1,\"chance\":\"1480\"},{\"id\":5876,\"count\":1,\"chance\":\"980\"},{\"id\":5881,\"count\":1,\"chance\":\"1130\"},{\"id\":7589,\"count\":1,\"chance\":\"12110\"},{\"id\":7590,\"count\":1,\"chance\":\"7940\"},{\"id\":8871,\"count\":1,\"chance\":\"660\"},{\"id\":11245,\"count\":1,\"chance\":\"960\"},{\"id\":11303,\"count\":1,\"chance\":\"450\"},{\"id\":11356,\"count\":1,\"chance\":\"300\"},{\"id\":11361,\"count\":1,\"chance\":\"9910\"}]'),
(1827, 0, 'Lizard High Guard', 0, 1450, 1800, 9, 0, '[\"Hizzzzzzz!\",\"To armzzzz!\",\"Engage zze aggrezzor!\"]', '[\"earth\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2148\",\"count\":\"281\",\"chance\":\"96078\"},{\"id\":\"7588\",\"count\":1,\"chance\":\"11938\"},{\"id\":\"11333\",\"count\":1,\"chance\":\"8091\"},{\"id\":\"7591\",\"count\":1,\"chance\":\"7075\"},{\"id\":\"11325\",\"count\":1,\"chance\":\"6970\"},{\"id\":\"11245\",\"count\":1,\"chance\":\"4932\"},{\"id\":\"2152\",\"count\":\"2\",\"chance\":\"4910\"},{\"id\":\"11332\",\"count\":1,\"chance\":\"3006\"},{\"id\":\"2149\",\"count\":\"4\",\"chance\":\"2487\"},{\"id\":\"11206\",\"count\":1,\"chance\":\"1209\"},{\"id\":\"2528\",\"count\":1,\"chance\":\"1032\"},{\"id\":\"5876\",\"count\":1,\"chance\":\"997\"},{\"id\":\"5881\",\"count\":1,\"chance\":\"957\"},{\"id\":\"11304\",\"count\":1,\"chance\":\"734\"},{\"id\":\"11303\",\"count\":1,\"chance\":\"688\"},{\"id\":\"11301\",\"count\":1,\"chance\":\"76\"}]'),
(1828, 0, 'Lizard Legionnaire', 0, 1100, 1400, 5, 0, '[\"Tssss!\"]', '[\"earth\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":2145,\"count\":\"2\",\"chance\":\"1001\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"44000\"},{\"id\":2148,\"count\":\"65\",\"chance\":\"54000\"},{\"id\":5876,\"count\":1,\"chance\":\"970\"},{\"id\":5881,\"count\":\"3\",\"chance\":\"980\"},{\"id\":7588,\"count\":1,\"chance\":\"3880\"},{\"id\":11206,\"count\":1,\"chance\":\"530\"},{\"id\":11245,\"count\":1,\"chance\":\"1950\"},{\"id\":11301,\"count\":1,\"chance\":\"70\"},{\"id\":11303,\"count\":1,\"chance\":\"460\"},{\"id\":11305,\"count\":1,\"chance\":\"710\"},{\"id\":11323,\"count\":1,\"chance\":\"960\"},{\"id\":11334,\"count\":1,\"chance\":\"1940\"},{\"id\":11335,\"count\":1,\"chance\":\"14940\"},{\"id\":11336,\"count\":1,\"chance\":\"20\"}]');
INSERT INTO `myaac_monsters` (`id`, `hidden`, `name`, `mana`, `exp`, `health`, `speed_lvl`, `use_haste`, `voices`, `immunities`, `summonable`, `convinceable`, `race`, `loot`) VALUES
(1829, 0, 'Lizard Magistratus', 0, 2000, 8000, 1, 0, '[\"Shhhhhhhh\"]', '[\"invisible\"]', 0, 0, 'blood', '[{\"id\":2147,\"count\":\"5\",\"chance\":\"8970\"},{\"id\":2148,\"count\":\"50\",\"chance\":\"77230\"},{\"id\":2152,\"count\":\"19\",\"chance\":\"13400\"},{\"id\":5876,\"count\":1,\"chance\":\"220\"},{\"id\":5881,\"count\":1,\"chance\":\"450\"},{\"id\":7589,\"count\":1,\"chance\":\"6280\"},{\"id\":7590,\"count\":1,\"chance\":\"4480\"}]'),
(1830, 0, 'Lizard Noble', 0, 2000, 7000, 1, 0, '[\"Where are zhe guardz when you need zhem!\"]', '[\"invisible\",\"earth\"]', 0, 0, 'blood', '[{\"id\":2147,\"count\":\"5\",\"chance\":\"7100\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"91300\"},{\"id\":2152,\"count\":\"20\",\"chance\":\"10000\"},{\"id\":5876,\"count\":1,\"chance\":\"220\"},{\"id\":5881,\"count\":1,\"chance\":\"650\"},{\"id\":7588,\"count\":1,\"chance\":\"2550\"},{\"id\":7591,\"count\":1,\"chance\":\"2900\"}]'),
(1831, 0, 'Lizard Sentinel', 560, 110, 265, 1, 0, '[\"Tssss!\"]', '[\"invisible\",\"earth\"]', 0, 1, 'blood', '[{\"id\":\"2148\",\"count\":\"54\",\"chance\":\"86497\"},{\"id\":\"2389\",\"count\":\"3\",\"chance\":\"10100\"},{\"id\":\"2464\",\"count\":1,\"chance\":\"9189\"},{\"id\":\"2483\",\"count\":1,\"chance\":\"8069\"},{\"id\":\"3965\",\"count\":1,\"chance\":\"4424\"},{\"id\":\"5876\",\"count\":1,\"chance\":\"2207\"},{\"id\":\"5881\",\"count\":1,\"chance\":\"2031\"},{\"id\":\"2381\",\"count\":1,\"chance\":\"1504\"},{\"id\":\"2425\",\"count\":1,\"chance\":\"1317\"},{\"id\":\"7618\",\"count\":1,\"chance\":\"1219\"},{\"id\":\"3974\",\"count\":1,\"chance\":\"373\"},{\"id\":\"2145\",\"count\":1,\"chance\":\"88\"}]'),
(1832, 0, 'Lizard Snakecharmer', 0, 210, 325, 1, 0, '[\"I ssssmell warm blood!\",\"Shhhhhhhh\"]', '[\"invisible\",\"earth\"]', 0, 0, 'blood', '[{\"id\":2148,\"count\":\"55\",\"chance\":\"83740\"},{\"id\":\"3077\",\"count\":1,\"chance\":\"45000\"},{\"id\":2654,\"count\":1,\"chance\":\"8640\"},{\"id\":2177,\"count\":1,\"chance\":\"1430\"},{\"id\":5876,\"count\":1,\"chance\":\"1320\"},{\"id\":5881,\"count\":1,\"chance\":\"1000\"},{\"id\":2181,\"count\":1,\"chance\":\"980\"},{\"id\":7620,\"count\":1,\"chance\":\"700\"},{\"id\":2150,\"count\":1,\"chance\":\"370\"},{\"id\":2168,\"count\":1,\"chance\":\"190\"},{\"id\":2182,\"count\":1,\"chance\":\"120\"},{\"id\":3971,\"count\":1,\"chance\":\"100\"},{\"id\":2154,\"count\":1,\"chance\":\"30\"}]'),
(1833, 0, 'Lizard Templar', 0, 155, 410, 1, 0, '[\"Hissss!\"]', '[\"earth\"]', 0, 0, 'blood', '[{\"id\":2148,\"count\":\"60\",\"chance\":\"84000\"},{\"id\":2406,\"count\":1,\"chance\":\"9500\"},{\"id\":\"2376\",\"count\":1,\"chance\":\"4800\"},{\"id\":2457,\"count\":1,\"chance\":\"2000\"},{\"id\":2394,\"count\":1,\"chance\":\"1990\"},{\"id\":2463,\"count\":1,\"chance\":\"1000\"},{\"id\":5881,\"count\":1,\"chance\":\"990\"},{\"id\":5876,\"count\":1,\"chance\":\"880\"},{\"id\":7618,\"count\":1,\"chance\":\"820\"},{\"id\":3963,\"count\":1,\"chance\":\"550\"},{\"id\":2149,\"count\":1,\"chance\":\"260\"},{\"id\":3975,\"count\":1,\"chance\":\"110\"}]'),
(1834, 0, 'Lizard Zaogun', 0, 1700, 2955, 28, 0, '[]', '[\"earth\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2148\",\"count\":\"268\",\"chance\":\"94142\"},{\"id\":\"2152\",\"count\":\"2\",\"chance\":\"49665\"},{\"id\":\"11331\",\"count\":1,\"chance\":\"14974\"},{\"id\":\"5876\",\"count\":1,\"chance\":\"14674\"},{\"id\":\"5881\",\"count\":1,\"chance\":\"12054\"},{\"id\":\"11330\",\"count\":1,\"chance\":\"8381\"},{\"id\":\"7591\",\"count\":\"3\",\"chance\":\"7211\"},{\"id\":\"2149\",\"count\":\"5\",\"chance\":\"4993\"},{\"id\":\"11206\",\"count\":1,\"chance\":\"2087\"},{\"id\":\"7588\",\"count\":1,\"chance\":\"1951\"},{\"id\":\"11303\",\"count\":1,\"chance\":\"1118\"},{\"id\":\"2528\",\"count\":1,\"chance\":\"1020\"},{\"id\":\"11304\",\"count\":1,\"chance\":\"912\"},{\"id\":\"11301\",\"count\":1,\"chance\":\"519\"}]'),
(1835, 0, 'Lord of the Elements', 0, 8000, 8000, 75, 0, '[\"WHO DARES CALLING ME?\",\"I\'LL FREEZE YOU THEN I CRUSH YOU!\"]', '[\"holy\",\"death\",\"drown\",\"invisible\"]', 0, 0, 'undead', '[{\"id\":2146,\"count\":\"4\",\"chance\":\"7142\"},{\"id\":2147,\"count\":\"4\",\"chance\":\"11111\"},{\"id\":2149,\"count\":\"4\",\"chance\":\"11111\"},{\"id\":2150,\"count\":\"3\",\"chance\":\"11111\"},{\"id\":2152,\"count\":\"9\",\"chance\":\"50000\"},{\"id\":8882,\"count\":1,\"chance\":\"2063\"},{\"id\":9971,\"count\":1,\"chance\":\"25000\"}]'),
(1836, 0, 'Lost Basher', 0, 1800, 2600, 15, 0, '[\"Yhouuuu!\"]', '[\"earth\",\"paralyze\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":2114,\"count\":1,\"chance\":\"4450\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"60000\"},{\"id\":2152,\"count\":\"2\",\"chance\":\"70000\"},{\"id\":2213,\"count\":1,\"chance\":\"2560\"},{\"id\":2432,\"count\":1,\"chance\":\"310\"},{\"id\":2454,\"count\":1,\"chance\":\"120\"},{\"id\":2477,\"count\":1,\"chance\":\"310\"},{\"id\":2529,\"count\":1,\"chance\":\"3710\"},{\"id\":2789,\"count\":\"2\",\"chance\":\"15170\"},{\"id\":5880,\"count\":1,\"chance\":\"5280\"},{\"id\":7427,\"count\":1,\"chance\":\"160\"},{\"id\":7452,\"count\":1,\"chance\":\"420\"},{\"id\":7590,\"count\":1,\"chance\":\"11240\"},{\"id\":7750,\"count\":1,\"chance\":\"1200\"},{\"id\":7886,\"count\":1,\"chance\":\"780\"},{\"id\":8473,\"count\":1,\"chance\":\"10250\"},{\"id\":9970,\"count\":1,\"chance\":\"10200\"},{\"id\":\"13757\",\"count\":1,\"chance\":\"21130\"},{\"id\":18413,\"count\":1,\"chance\":\"840\"},{\"id\":20106,\"count\":1,\"chance\":\"17260\"},{\"id\":20106,\"count\":1,\"chance\":\"14380\"},{\"id\":20107,\"count\":1,\"chance\":\"1730\"},{\"id\":20108,\"count\":1,\"chance\":\"1410\"},{\"id\":20109,\"count\":1,\"chance\":\"10930\"},{\"id\":20110,\"count\":1,\"chance\":\"7320\"},{\"id\":20126,\"count\":1,\"chance\":\"12500\"},{\"id\":20134,\"count\":1,\"chance\":\"11870\"},{\"id\":20136,\"count\":1,\"chance\":\"8800\"},{\"id\":20137,\"count\":1,\"chance\":\"9470\"}]'),
(1837, 0, 'Lost Berserker', 0, 4400, 5900, 40, 0, '[\"Kill! Kill! Kill!\",\"Death! Death! Death!\"]', '[\"earth\",\"paralyze\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2148\",\"count\":\"200\",\"chance\":\"100000\"},{\"id\":\"2152\",\"count\":\"9\",\"chance\":\"99965\"},{\"id\":\"2789\",\"count\":\"2\",\"chance\":\"15482\"},{\"id\":\"7590\",\"count\":1,\"chance\":\"14232\"},{\"id\":\"7591\",\"count\":1,\"chance\":\"13497\"},{\"id\":\"5880\",\"count\":1,\"chance\":\"8663\"},{\"id\":\"9970\",\"count\":\"2\",\"chance\":\"8033\"},{\"id\":\"18436\",\"count\":\"10\",\"chance\":\"7974\"},{\"id\":\"18417\",\"count\":\"2\",\"chance\":\"7542\"},{\"id\":\"18421\",\"count\":1,\"chance\":\"6667\"},{\"id\":\"18418\",\"count\":1,\"chance\":\"4752\"},{\"id\":\"2114\",\"count\":1,\"chance\":\"3783\"},{\"id\":\"18414\",\"count\":1,\"chance\":\"3596\"},{\"id\":\"2213\",\"count\":1,\"chance\":\"2347\"},{\"id\":\"2430\",\"count\":1,\"chance\":\"2113\"},{\"id\":\"13757\",\"count\":1,\"chance\":\"1880\"},{\"id\":\"2515\",\"count\":1,\"chance\":\"1296\"},{\"id\":\"11339\",\"count\":1,\"chance\":\"992\"},{\"id\":\"2528\",\"count\":1,\"chance\":\"899\"},{\"id\":\"7452\",\"count\":1,\"chance\":\"794\"},{\"id\":\"5904\",\"count\":1,\"chance\":\"724\"},{\"id\":\"2529\",\"count\":1,\"chance\":\"630\"},{\"id\":\"7886\",\"count\":1,\"chance\":\"619\"},{\"id\":\"7427\",\"count\":1,\"chance\":\"479\"},{\"id\":\"2432\",\"count\":1,\"chance\":\"409\"},{\"id\":\"2498\",\"count\":1,\"chance\":\"198\"}]'),
(1838, 0, 'Lost Husher', 0, 1800, 1600, 15, 0, '[\"Arr far zwar!\"]', '[\"earth\",\"paralyze\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2148\",\"count\":\"100\",\"chance\":\"100000\"},{\"id\":\"2152\",\"count\":\"2\",\"chance\":\"59669\"},{\"id\":\"20135\",\"count\":1,\"chance\":\"15336\"},{\"id\":\"2789\",\"count\":\"2\",\"chance\":\"15105\"},{\"id\":\"20127\",\"count\":1,\"chance\":\"12042\"},{\"id\":\"13757\",\"count\":1,\"chance\":\"11812\"},{\"id\":\"20130\",\"count\":1,\"chance\":\"11608\"},{\"id\":\"7588\",\"count\":\"3\",\"chance\":\"10466\"},{\"id\":\"7590\",\"count\":\"2\",\"chance\":\"10377\"},{\"id\":\"9970\",\"count\":1,\"chance\":\"9695\"},{\"id\":\"20128\",\"count\":1,\"chance\":\"9217\"},{\"id\":\"20129\",\"count\":1,\"chance\":\"8996\"},{\"id\":\"20110\",\"count\":1,\"chance\":\"8465\"},{\"id\":\"20137\",\"count\":1,\"chance\":\"7739\"},{\"id\":\"20111\",\"count\":1,\"chance\":\"7677\"},{\"id\":\"20136\",\"count\":1,\"chance\":\"5932\"},{\"id\":\"2213\",\"count\":1,\"chance\":\"2656\"},{\"id\":\"2515\",\"count\":1,\"chance\":\"965\"},{\"id\":\"11339\",\"count\":1,\"chance\":\"885\"},{\"id\":\"2430\",\"count\":1,\"chance\":\"744\"},{\"id\":\"20109\",\"count\":1,\"chance\":\"726\"},{\"id\":\"7886\",\"count\":1,\"chance\":\"620\"},{\"id\":\"2436\",\"count\":1,\"chance\":\"469\"},{\"id\":\"7452\",\"count\":1,\"chance\":\"283\"},{\"id\":\"2432\",\"count\":1,\"chance\":\"266\"},{\"id\":\"7885\",\"count\":1,\"chance\":\"221\"},{\"id\":\"2528\",\"count\":1,\"chance\":\"195\"}]'),
(1839, 0, 'Lost Soul', 0, 4000, 5800, 80, 0, '[\"Forgive Meeeee!\",\"Mouuuurn meeee!\",\"Help meeee!\"]', '[\"fire\",\"earth\",\"death\",\"lifedrain\",\"paralyze\",\"invisible\"]', 0, 0, 'undead', '[{\"id\":\"2148\",\"count\":\"196\",\"chance\":\"100000\"},{\"id\":\"2152\",\"count\":\"7\",\"chance\":\"100000\"},{\"id\":\"2260\",\"count\":\"3\",\"chance\":\"36842\"},{\"id\":\"11233\",\"count\":1,\"chance\":\"33684\"},{\"id\":\"7590\",\"count\":\"2\",\"chance\":\"17193\"},{\"id\":\"2144\",\"count\":\"3\",\"chance\":\"15439\"},{\"id\":\"5944\",\"count\":1,\"chance\":\"15439\"},{\"id\":\"2143\",\"count\":\"3\",\"chance\":\"14035\"},{\"id\":\"7591\",\"count\":\"2\",\"chance\":\"8421\"},{\"id\":\"6500\",\"count\":1,\"chance\":\"5614\"},{\"id\":\"5806\",\"count\":1,\"chance\":\"3860\"},{\"id\":\"9810\",\"count\":1,\"chance\":\"3158\"},{\"id\":\"2197\",\"count\":1,\"chance\":\"2807\"},{\"id\":\"6300\",\"count\":1,\"chance\":\"2456\"},{\"id\":\"2133\",\"count\":1,\"chance\":\"1404\"},{\"id\":\"6526\",\"count\":1,\"chance\":\"1404\"},{\"id\":\"2156\",\"count\":1,\"chance\":\"1053\"},{\"id\":\"7407\",\"count\":1,\"chance\":\"702\"},{\"id\":\"2436\",\"count\":1,\"chance\":\"702\"},{\"id\":\"7413\",\"count\":1,\"chance\":\"351\"}]'),
(1840, 0, 'Lost Thrower', 0, 1200, 1700, 1, 0, '[]', '[\"earth\",\"paralyze\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":2148,\"count\":\"100\",\"chance\":\"50000\"},{\"id\":2148,\"count\":\"37\",\"chance\":\"50000\"},{\"id\":2152,\"count\":\"2\",\"chance\":\"70000\"},{\"id\":2789,\"count\":\"2\",\"chance\":\"14500\"},{\"id\":5880,\"count\":1,\"chance\":\"9470\"},{\"id\":7590,\"count\":1,\"chance\":\"13470\"},{\"id\":7591,\"count\":1,\"chance\":\"14730\"},{\"id\":\"13757\",\"count\":1,\"chance\":\"12180\"},{\"id\":20106,\"count\":1,\"chance\":\"11410\"},{\"id\":20109,\"count\":1,\"chance\":\"850\"},{\"id\":20130,\"count\":1,\"chance\":\"15670\"},{\"id\":20131,\"count\":1,\"chance\":\"1390\"},{\"id\":20132,\"count\":1,\"chance\":\"13560\"},{\"id\":20133,\"count\":1,\"chance\":\"14860\"},{\"id\":20134,\"count\":1,\"chance\":\"11810\"},{\"id\":20136,\"count\":1,\"chance\":\"6150\"},{\"id\":20137,\"count\":1,\"chance\":\"7900\"}]'),
(1841, 0, 'mad mage', 0, 1800, 2500, 10, 0, '[]', '[\"energy\",\"outfit\",\"drunk\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":2148,\"count\":\"66\",\"chance\":\"100000\"},{\"id\":2148,\"count\":\"20\",\"chance\":\"100000\"},{\"id\":2792,\"count\":\"5\",\"chance\":\"5000\"},{\"id\":5911,\"count\":1,\"chance\":\"800\"},{\"id\":7368,\"count\":\"4\",\"chance\":\"2400\"},{\"id\":7588,\"count\":\"5\",\"chance\":\"1300\"},{\"id\":7589,\"count\":\"2\",\"chance\":\"1200\"},{\"id\":7895,\"count\":1,\"chance\":\"800\"}]'),
(1842, 0, 'Mad Scientist', 0, 205, 325, 1, 0, '[\"Die in the name of Science!\",\"You will regret interrupting my studies!\",\"Let me test this!\",\"I will study your corpse!\"]', '[\"invisible\",\"drown\"]', 0, 0, 'blood', '[{\"id\":2148,\"count\":\"65\",\"chance\":\"30000\"},{\"id\":2148,\"count\":\"50\",\"chance\":\"30000\"},{\"id\":\"2162\",\"count\":1,\"chance\":\"2000\"},{\"id\":2177,\"count\":1,\"chance\":\"2000\"},{\"id\":2308,\"count\":1,\"chance\":\"6000\"},{\"id\":2687,\"count\":\"5\",\"chance\":\"1200\"},{\"id\":2787,\"count\":\"3\",\"chance\":\"8000\"},{\"id\":\"6324\",\"count\":1,\"chance\":\"820\"},{\"id\":7440,\"count\":1,\"chance\":\"130\"},{\"id\":7618,\"count\":1,\"chance\":\"19000\"},{\"id\":7620,\"count\":1,\"chance\":\"19000\"},{\"id\":7762,\"count\":1,\"chance\":\"470\"}]'),
(1843, 0, 'Mad Sheep', 0, 0, 22, 26, 1, '[\"Maeh\",\"Groar!\",\"Fchhhh\",\"Meow!\",\"Woof!\"]', '[]', 0, 0, 'blood', '[]'),
(1844, 0, 'Mad Technomancer', 0, 55, 1800, 1, 0, '[\"I\'m going to make them an offer they can\'t refuse.\",\"My masterplan cannot fail!\",\"Gentlemen, you can\'t fight here! This is the War Room!\"]', '[\"invisible\"]', 0, 0, 'blood', '[{\"id\":7699,\"count\":1,\"chance\":\"100000\"}]'),
(1845, 0, 'Madareth', 0, 10000, 75000, 55, 0, '[\"I am going to play with yourself!\",\"Feel my wrath!\",\"No one matches my battle prowess!\",\"You will all die!\"]', '[\"energy\",\"fire\",\"invisible\"]', 0, 0, 'fire', '[{\"id\":\"2148\",\"count\":\"100\",\"chance\":\"100000\"},{\"id\":\"9813\",\"count\":1,\"chance\":\"59259\"},{\"id\":\"9810\",\"count\":1,\"chance\":\"40741\"},{\"id\":\"7443\",\"count\":1,\"chance\":\"37037\"},{\"id\":\"7591\",\"count\":1,\"chance\":\"29630\"},{\"id\":\"8472\",\"count\":1,\"chance\":\"27778\"},{\"id\":\"7439\",\"count\":1,\"chance\":\"25926\"},{\"id\":\"7440\",\"count\":1,\"chance\":\"25926\"},{\"id\":\"7590\",\"count\":1,\"chance\":\"22222\"},{\"id\":\"6300\",\"count\":1,\"chance\":\"20370\"},{\"id\":\"2152\",\"count\":\"26\",\"chance\":\"20370\"},{\"id\":\"8473\",\"count\":1,\"chance\":\"20370\"},{\"id\":\"8912\",\"count\":1,\"chance\":\"18519\"},{\"id\":\"7404\",\"count\":1,\"chance\":\"16667\"},{\"id\":\"2072\",\"count\":1,\"chance\":\"16667\"},{\"id\":\"2377\",\"count\":1,\"chance\":\"16667\"},{\"id\":\"2208\",\"count\":1,\"chance\":\"14815\"},{\"id\":\"2183\",\"count\":1,\"chance\":\"14815\"},{\"id\":\"7418\",\"count\":1,\"chance\":\"14815\"},{\"id\":\"8910\",\"count\":1,\"chance\":\"14815\"},{\"id\":\"2187\",\"count\":1,\"chance\":\"14815\"},{\"id\":\"7416\",\"count\":1,\"chance\":\"12963\"},{\"id\":\"2209\",\"count\":1,\"chance\":\"12963\"},{\"id\":\"7407\",\"count\":1,\"chance\":\"12963\"},{\"id\":\"2071\",\"count\":1,\"chance\":\"12963\"},{\"id\":\"2214\",\"count\":1,\"chance\":\"12963\"},{\"id\":\"8922\",\"count\":1,\"chance\":\"12963\"},{\"id\":\"6500\",\"count\":1,\"chance\":\"11111\"},{\"id\":\"3953\",\"count\":1,\"chance\":\"11111\"},{\"id\":\"2079\",\"count\":1,\"chance\":\"11111\"},{\"id\":\"7449\",\"count\":1,\"chance\":\"9259\"},{\"id\":\"2168\",\"count\":1,\"chance\":\"9259\"},{\"id\":\"2169\",\"count\":1,\"chance\":\"9259\"},{\"id\":\"5954\",\"count\":\"2\",\"chance\":\"7407\"},{\"id\":\"3952\",\"count\":1,\"chance\":\"7407\"},{\"id\":\"7383\",\"count\":1,\"chance\":\"7407\"},{\"id\":\"8920\",\"count\":1,\"chance\":\"7407\"},{\"id\":\"7386\",\"count\":1,\"chance\":\"5556\"},{\"id\":\"2070\",\"count\":1,\"chance\":\"5556\"},{\"id\":\"2213\",\"count\":1,\"chance\":\"3704\"},{\"id\":\"2396\",\"count\":1,\"chance\":\"3704\"},{\"id\":\"2207\",\"count\":1,\"chance\":\"3704\"}]'),
(1846, 0, 'Magic Pillar', 0, 0, 1, 1, 0, '[]', '[\"physical\",\"energy\",\"fire\",\"earth\",\"drown\",\"ice\",\"holy\",\"death\",\"lifedrain\",\"manadrain\",\"paralyze\",\"drunk\",\"outfit\",\"invisible\"]', 0, 0, 'undead', '[]'),
(1847, 0, 'Magicthrower', 0, 0, 1, 1, 0, '[]', '[\"physical\",\"energy\",\"fire\",\"earth\",\"drown\",\"ice\",\"holy\",\"death\",\"lifedrain\",\"manadrain\",\"paralyze\",\"drunk\",\"outfit\",\"invisible\"]', 0, 0, 'undead', '[]'),
(1848, 0, 'Magma Crawler', 0, 2700, 4800, 1, 0, '[\"Crrroak!\"]', '[\"fire\",\"earth\",\"paralyze\",\"invisible\"]', 0, 0, 'fire', '[{\"id\":2145,\"count\":\"3\",\"chance\":\"8800\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"50000\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"50000\"},{\"id\":2152,\"count\":\"5\",\"chance\":\"95000\"},{\"id\":2154,\"count\":1,\"chance\":\"1030\"},{\"id\":2167,\"count\":1,\"chance\":\"1650\"},{\"id\":2392,\"count\":1,\"chance\":\"1680\"},{\"id\":2529,\"count\":1,\"chance\":\"1550\"},{\"id\":5880,\"count\":1,\"chance\":\"4280\"},{\"id\":5909,\"count\":1,\"chance\":\"2310\"},{\"id\":5911,\"count\":1,\"chance\":\"930\"},{\"id\":5914,\"count\":1,\"chance\":\"2980\"},{\"id\":7590,\"count\":1,\"chance\":\"6500\"},{\"id\":7591,\"count\":1,\"chance\":\"7270\"},{\"id\":7890,\"count\":1,\"chance\":\"3120\"},{\"id\":7891,\"count\":1,\"chance\":\"1820\"},{\"id\":8921,\"count\":1,\"chance\":\"4280\"},{\"id\":10553,\"count\":1,\"chance\":\"7810\"},{\"id\":\"13757\",\"count\":1,\"chance\":\"1675\"},{\"id\":18304,\"count\":\"10\",\"chance\":\"5950\"},{\"id\":18409,\"count\":1,\"chance\":\"690\"},{\"id\":18413,\"count\":\"2\",\"chance\":\"3930\"},{\"id\":18417,\"count\":\"2\",\"chance\":\"8500\"},{\"id\":18418,\"count\":\"2\",\"chance\":\"8500\"},{\"id\":18421,\"count\":1,\"chance\":\"7000\"},{\"id\":18424,\"count\":1,\"chance\":\"11600\"},{\"id\":18425,\"count\":1,\"chance\":\"11500\"}]'),
(1849, 0, 'Mahrdis', 0, 3050, 3900, 60, 0, '[\"Ashes to ashes!\",\"Fire, Fire!\",\"The eternal flame demands its due!\",\"Burnnnnnnnnn!\",\"May my flames engulf you!\",\"This is why I\'m hot.\"]', '[\"fire\",\"death\",\"invisible\"]', 0, 0, 'undead', '[{\"id\":\"2353\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2148\",\"count\":\"230\",\"chance\":\"88738\"},{\"id\":\"2147\",\"count\":\"3\",\"chance\":\"12255\"},{\"id\":\"7591\",\"count\":1,\"chance\":\"10213\"},{\"id\":\"2168\",\"count\":1,\"chance\":\"6752\"},{\"id\":\"2432\",\"count\":1,\"chance\":\"936\"},{\"id\":\"2156\",\"count\":1,\"chance\":\"624\"},{\"id\":\"2141\",\"count\":1,\"chance\":\"142\"},{\"id\":\"11207\",\"count\":1,\"chance\":\"113\"},{\"id\":\"2539\",\"count\":1,\"chance\":\"113\"}]'),
(1850, 0, 'Mammoth', 500, 160, 320, 1, 0, '[\"Troooooot!\",\"Hooooot-Toooooot!\",\"Tooooot.\"]', '[]', 0, 1, 'blood', '[{\"id\":\"2148\",\"count\":\"40\",\"chance\":\"89882\"},{\"id\":\"2666\",\"count\":1,\"chance\":\"40278\"},{\"id\":\"2671\",\"count\":1,\"chance\":\"29949\"},{\"id\":\"11224\",\"count\":1,\"chance\":\"7669\"},{\"id\":\"11238\",\"count\":\"2\",\"chance\":\"7462\"},{\"id\":\"7381\",\"count\":1,\"chance\":\"2507\"},{\"id\":\"7432\",\"count\":1,\"chance\":\"526\"},{\"id\":\"3973\",\"count\":1,\"chance\":\"494\"}]'),
(1851, 0, 'Man in the Cave', 0, 777, 485, 1, 0, '[\"THE MONKS ARE MINE\",\"I will rope you up! All of you!\",\"You have been roped up!\",\"A MIC to rule them all!\"]', '[\"fire\",\"lifedrain\",\"outfit\",\"drunk\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2120\",\"count\":1,\"chance\":\"20000\"},{\"id\":\"2120\",\"count\":1,\"chance\":\"6666\"},{\"id\":\"2120\",\"count\":1,\"chance\":\"3333\"},{\"id\":2148,\"count\":\"27\",\"chance\":\"100000\"},{\"id\":2173,\"count\":1,\"chance\":\"500\"},{\"id\":2691,\"count\":1,\"chance\":\"4000\"},{\"id\":5913,\"count\":1,\"chance\":\"2000\"},{\"id\":7290,\"count\":1,\"chance\":\"4000\"},{\"id\":7386,\"count\":1,\"chance\":\"6666\"},{\"id\":7458,\"count\":1,\"chance\":\"1000\"},{\"id\":7463,\"count\":1,\"chance\":\"6666\"}]'),
(1852, 0, 'Manta Ray', 0, 125, 680, 1, 0, '[\"Flap flap flap!\"]', '[\"earth\",\"fire\",\"invisible\",\"drown\"]', 0, 0, 'blood', '[{\"id\":2148,\"count\":\"38\",\"chance\":\"50000\"}]'),
(1853, 0, 'Marid', 0, 410, 550, 7, 0, '[\"Simsalabim\",\"Feel the power of my magic, tiny mortal!\",\"Wishes can come true.\",\"Djinns will soon again be the greatest!\",\"Be careful what you wish.\"]', '[\"paralyze\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":2148,\"count\":\"100\",\"chance\":\"49000\"},{\"id\":2148,\"count\":\"29\",\"chance\":\"49000\"},{\"id\":2677,\"count\":\"25\",\"chance\":\"25000\"},{\"id\":7378,\"count\":\"3\",\"chance\":\"15500\"},{\"id\":7589,\"count\":1,\"chance\":\"9800\"},{\"id\":12426,\"count\":1,\"chance\":\"8000\"},{\"id\":2146,\"count\":1,\"chance\":\"6200\"},{\"id\":2442,\"count\":1,\"chance\":\"4700\"},{\"id\":5912,\"count\":1,\"chance\":\"3750\"},{\"id\":\"1872\",\"count\":1,\"chance\":\"2560\"},{\"id\":7732,\"count\":1,\"chance\":\"2400\"},{\"id\":2183,\"count\":1,\"chance\":\"770\"},{\"id\":12442,\"count\":1,\"chance\":\"530\"},{\"id\":2663,\"count\":1,\"chance\":\"290\"},{\"id\":7900,\"count\":1,\"chance\":\"260\"},{\"id\":\"2374\",\"count\":1,\"chance\":\"260\"},{\"id\":2063,\"count\":1,\"chance\":\"130\"},{\"id\":2158,\"count\":1,\"chance\":\"80\"}]'),
(1854, 0, 'Marsh Stalker', 0, 50, 100, 1, 0, '[\"Rrrawk! Rrrrawk!\"]', '[]', 0, 0, 'blood', '[{\"id\":\"2120\",\"count\":1,\"chance\":\"4530\"},{\"id\":2148,\"count\":\"23\",\"chance\":\"65000\"},{\"id\":2397,\"count\":1,\"chance\":\"7180\"},{\"id\":2666,\"count\":\"2\",\"chance\":\"20360\"},{\"id\":\"2667\",\"count\":\"2\",\"chance\":\"20290\"},{\"id\":3976,\"count\":\"2\",\"chance\":\"15000\"},{\"id\":7732,\"count\":1,\"chance\":\"120\"},{\"id\":\"19741\",\"count\":1,\"chance\":\"7180\"},{\"id\":19741,\"count\":1,\"chance\":\"9300\"}]'),
(1855, 0, 'Massacre', 0, 20000, 32000, 85, 1, '[]', '[\"energy\",\"fire\",\"earth\",\"lifedrain\",\"paralyze\",\"outfit\",\"drunk\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":6540,\"count\":1,\"chance\":\"100000\"}]'),
(1856, 0, 'Massive Earth Elemental', 0, 950, 1330, 10, 0, '[]', '[\"paralyze\",\"invisible\",\"earth\",\"ice\"]', 0, 0, 'undead', '[{\"id\":1294,\"count\":\"10\",\"chance\":\"25280\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"32000\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"32000\"},{\"id\":2148,\"count\":\"41\",\"chance\":\"32000\"},{\"id\":2197,\"count\":1,\"chance\":\"980\"},{\"id\":2200,\"count\":1,\"chance\":\"1580\"},{\"id\":2213,\"count\":1,\"chance\":\"2790\"},{\"id\":7387,\"count\":1,\"chance\":\"150\"},{\"id\":7887,\"count\":1,\"chance\":\"500\"},{\"id\":\"9809\",\"count\":1,\"chance\":\"3300\"},{\"id\":9970,\"count\":\"2\",\"chance\":\"5280\"},{\"id\":11222,\"count\":1,\"chance\":\"40680\"},{\"id\":11339,\"count\":1,\"chance\":\"480\"},{\"id\":\"13757\",\"count\":1,\"chance\":\"430\"}]'),
(1857, 0, 'Massive Energy Elemental', 0, 950, 1100, 1, 0, '[]', '[\"ice\",\"energy\",\"fire\",\"invisible\",\"paralyze\"]', 0, 0, 'energy', '[{\"id\":2148,\"count\":\"100\",\"chance\":\"50000\"},{\"id\":2148,\"count\":\"91\",\"chance\":\"50000\"},{\"id\":2150,\"count\":\"3\",\"chance\":\"3270\"},{\"id\":7589,\"count\":1,\"chance\":\"17450\"},{\"id\":7590,\"count\":1,\"chance\":\"5450\"},{\"id\":7838,\"count\":\"15\",\"chance\":\"6550\"},{\"id\":7869,\"count\":1,\"chance\":\"500\"},{\"id\":7889,\"count\":1,\"chance\":\"730\"},{\"id\":7895,\"count\":1,\"chance\":\"150\"},{\"id\":8901,\"count\":1,\"chance\":\"360\"},{\"id\":8920,\"count\":1,\"chance\":\"730\"},{\"id\":\"9809\",\"count\":1,\"chance\":\"730\"},{\"id\":10221,\"count\":1,\"chance\":\"500\"}]'),
(1858, 0, 'Massive Fire Elemental', 0, 1400, 1200, 1, 0, '[]', '[\"fire\",\"paralyze\",\"invisible\"]', 0, 0, 'fire', '[{\"id\":2147,\"count\":\"2\",\"chance\":\"6100\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"50000\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"25000\"},{\"id\":2148,\"count\":\"12\",\"chance\":\"25000\"},{\"id\":2172,\"count\":1,\"chance\":\"15000\"},{\"id\":2187,\"count\":1,\"chance\":\"2240\"},{\"id\":2392,\"count\":1,\"chance\":\"530\"},{\"id\":7890,\"count\":1,\"chance\":\"1300\"},{\"id\":7891,\"count\":1,\"chance\":\"560\"},{\"id\":7894,\"count\":1,\"chance\":\"210\"},{\"id\":\"9809\",\"count\":1,\"chance\":\"1330\"}]'),
(1859, 0, 'Massive Water Elemental', 0, 1100, 1250, 30, 0, '[]', '[\"paralyze\",\"invisible\",\"drown\",\"fire\",\"ice\",\"earth\",\"lifedrain\"]', 0, 0, 'undead', '[{\"id\":2145,\"count\":\"2\",\"chance\":\"1900\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"50000\"},{\"id\":2149,\"count\":\"2\",\"chance\":\"1000\"},{\"id\":2152,\"count\":\"2\",\"chance\":\"20000\"},{\"id\":2167,\"count\":1,\"chance\":\"910\"},{\"id\":2168,\"count\":1,\"chance\":\"1000\"},{\"id\":\"2667\",\"count\":\"2\",\"chance\":\"40000\"},{\"id\":7158,\"count\":1,\"chance\":\"1340\"},{\"id\":7159,\"count\":1,\"chance\":\"1590\"},{\"id\":7590,\"count\":1,\"chance\":\"10400\"},{\"id\":7591,\"count\":1,\"chance\":\"10000\"}]'),
(1860, 0, 'Mawhawk', 0, 14000, 45000, 25, 0, '[\"Knorrrr!\"]', '[\"earth\",\"energy\",\"lifedrain\",\"paralyze\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":2148,\"count\":\"100\",\"chance\":\"10000\"},{\"id\":2152,\"count\":\"25\",\"chance\":\"10000\"},{\"id\":2392,\"count\":1,\"chance\":\"10000\"},{\"id\":5880,\"count\":1,\"chance\":\"10000\"},{\"id\":5895,\"count\":1,\"chance\":\"10000\"},{\"id\":5911,\"count\":1,\"chance\":\"10000\"},{\"id\":5925,\"count\":1,\"chance\":\"10000\"},{\"id\":7404,\"count\":1,\"chance\":\"10000\"},{\"id\":7407,\"count\":1,\"chance\":\"10000\"},{\"id\":7418,\"count\":1,\"chance\":\"10000\"},{\"id\":18414,\"count\":\"3\",\"chance\":\"10000\"},{\"id\":18415,\"count\":\"3\",\"chance\":\"10000\"},{\"id\":18416,\"count\":\"5\",\"chance\":\"10000\"},{\"id\":18418,\"count\":\"5\",\"chance\":\"10000\"},{\"id\":22396,\"count\":\"2\",\"chance\":\"30000\"},{\"id\":22532,\"count\":1,\"chance\":\"30000\"},{\"id\":22598,\"count\":\"2\",\"chance\":\"30000\"}]'),
(1861, 0, 'Mazoran', 0, 50000, 290000, 90, 1, '[\"ASHES TO ASHES, TASTE MY FIRE!\",\"BUUURN!\",\"UNLEASH THE FIRE!\"]', '[\"fire\",\"invisible\",\"drunk\",\"paralyze\"]', 0, 0, 'fire', '[{\"id\":\"25172\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"18419\",\"count\":\"5\",\"chance\":\"23000\"},{\"id\":\"18420\",\"count\":\"5\",\"chance\":\"23000\"},{\"id\":\"18421\",\"count\":\"5\",\"chance\":\"23000\"},{\"id\":\"2143\",\"count\":\"8\",\"chance\":\"12000\"},{\"id\":\"2146\",\"count\":\"9\",\"chance\":\"12000\"},{\"id\":\"2148\",\"count\":\"100\",\"chance\":\"49000\"},{\"id\":\"2148\",\"count\":\"100\",\"chance\":\"49000\"},{\"id\":\"2150\",\"count\":\"5\",\"chance\":\"10000\"},{\"id\":\"2152\",\"count\":\"58\",\"chance\":\"8000\"},{\"id\":\"2155\",\"count\":1,\"chance\":\"1000\"},{\"id\":\"2158\",\"count\":1,\"chance\":\"1000\"},{\"id\":\"2167\",\"count\":1,\"chance\":\"4000\"},{\"id\":\"2432\",\"count\":1,\"chance\":\"3000\"},{\"id\":\"25416\",\"count\":1,\"chance\":\"500\"},{\"id\":\"2542\",\"count\":1,\"chance\":\"500\"},{\"id\":\"25522\",\"count\":1,\"chance\":\"500\"},{\"id\":\"25523\",\"count\":1,\"chance\":\"500\"},{\"id\":\"6500\",\"count\":1,\"chance\":\"11000\"},{\"id\":\"7382\",\"count\":1,\"chance\":\"1000\"},{\"id\":\"7590\",\"count\":\"5\",\"chance\":\"23000\"},{\"id\":\"7632\",\"count\":\"5\",\"chance\":\"14000\"},{\"id\":\"7633\",\"count\":\"5\",\"chance\":\"14000\"},{\"id\":\"7890\",\"count\":1,\"chance\":\"1000\"},{\"id\":\"7894\",\"count\":1,\"chance\":\"1000\"},{\"id\":\"7899\",\"count\":1,\"chance\":\"1000\"},{\"id\":\"8472\",\"count\":\"5\",\"chance\":\"46100\"},{\"id\":\"8473\",\"count\":\"5\",\"chance\":\"23000\"},{\"id\":\"9970\",\"count\":\"8\",\"chance\":\"10000\"},{\"id\":\"9971\",\"count\":1,\"chance\":\"3000\"}]'),
(1862, 0, 'Mechanical Fighter', 0, 255, 420, 1, 0, '[]', '[\"holy\",\"earth\",\"invisible\"]', 0, 0, 'undead', '[]'),
(1863, 0, 'Medusa', 0, 4050, 4500, 30, 0, '[\"You will make ssuch a fine ssstatue!\",\"There isss no chhhanccce of esscape\",\"Jusssst look at me!\",\"Are you tired or why are you moving thhat sslow<chuckle>\"]', '[\"earth\",\"paralyze\",\"invisible\",\"lifedrain\",\"drown\"]', 0, 0, 'blood', '[{\"id\":2148,\"count\":\"100\",\"chance\":\"50000\"},{\"id\":2148,\"count\":\"90\",\"chance\":\"50000\"},{\"id\":2149,\"count\":\"4\",\"chance\":\"3770\"},{\"id\":2152,\"count\":\"6\",\"chance\":\"74810\"},{\"id\":2476,\"count\":1,\"chance\":\"1840\"},{\"id\":2536,\"count\":1,\"chance\":\"3040\"},{\"id\":7413,\"count\":1,\"chance\":\"1160\"},{\"id\":7590,\"count\":\"2\",\"chance\":\"10000\"},{\"id\":7884,\"count\":1,\"chance\":\"870\"},{\"id\":7885,\"count\":1,\"chance\":\"420\"},{\"id\":7887,\"count\":1,\"chance\":\"4060\"},{\"id\":8473,\"count\":\"2\",\"chance\":\"9290\"},{\"id\":\"9810\",\"count\":1,\"chance\":\"500\"},{\"id\":10219,\"count\":1,\"chance\":\"850\"},{\"id\":11226,\"count\":1,\"chance\":\"9900\"}]'),
(1864, 0, 'Menace', 0, 3250, 6000, 1, 0, '[]', '[\"earth\",\"invisible\"]', 0, 0, 'blood', '[]'),
(1865, 0, 'Mephiles', 0, 415, 415, 40, 1, '[\"I have a contract here which you should sign!\",\"I sence so much potential in you. It\'s almost a shame I have to kill you.\",\"Yes, slay me for the loot I might have. Give in to your greed.\",\"Wealth, Power, it is all at your fingertips. All you have to do is a bit blackmailing and bullying.\",\"Come on. being a bit evil won\'t hurt you.\"]', '[\"fire\",\"lifedrain\",\"drunk\",\"invisible\"]', 0, 0, 'blood', '[]'),
(1866, 0, 'Mercury Blob', 0, 180, 150, 1, 0, '[\"Crackle\"]', '[\"death\"]', 0, 0, 'undead', '[{\"id\":9966,\"count\":1,\"chance\":\"17966\"}]'),
(1867, 0, 'Merlkin', 0, 145, 235, 1, 0, '[\"Ugh! Ugh! Ugh!\",\"Holy banana!\",\"Chakka! Chakka!\"]', '[\"outfit\",\"drunk\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2148\",\"count\":\"45\",\"chance\":\"82947\"},{\"id\":\"2676\",\"count\":\"12\",\"chance\":\"30430\"},{\"id\":\"2162\",\"count\":1,\"chance\":\"3020\"},{\"id\":\"12467\",\"count\":1,\"chance\":\"1918\"},{\"id\":\"5883\",\"count\":1,\"chance\":\"1014\"},{\"id\":\"2675\",\"count\":\"5\",\"chance\":\"1010\"},{\"id\":\"2188\",\"count\":1,\"chance\":\"980\"},{\"id\":\"7620\",\"count\":1,\"chance\":\"693\"},{\"id\":\"2150\",\"count\":1,\"chance\":\"310\"},{\"id\":\"3966\",\"count\":1,\"chance\":\"102\"}]'),
(1868, 0, 'Metal Gargoyle', 0, 1400, 2100, 1, 0, '[\"*click*\",\"*clonk*\",\"*stomp*\"]', '[\"invisible\",\"earth\",\"paralyze\",\"lifedrain\"]', 0, 0, 'energy', '[{\"id\":\"2148\",\"count\":\"100\",\"chance\":\"100000\"},{\"id\":\"2148\",\"count\":\"100\",\"chance\":\"60000\"},{\"id\":\"24124\",\"count\":1,\"chance\":\"1490\"},{\"id\":\"23564\",\"count\":1,\"chance\":\"17160\"},{\"id\":\"2152\",\"count\":\"2\",\"chance\":\"43280\"},{\"id\":\"7588\",\"count\":\"2\",\"chance\":\"9700\"},{\"id\":\"7589\",\"count\":\"2\",\"chance\":\"9700\"},{\"id\":\"23542\",\"count\":1,\"chance\":\"1490\"},{\"id\":\"2167\",\"count\":1,\"chance\":\"2240\"},{\"id\":\"2168\",\"count\":1,\"chance\":\"750\"},{\"id\":\"11227\",\"count\":1,\"chance\":\"2240\"},{\"id\":\"23540\",\"count\":1,\"chance\":\"1490\"},{\"id\":\"23539\",\"count\":1,\"chance\":\"1490\"},{\"id\":\"9810\",\"count\":1,\"chance\":\"2990\"}]'),
(1869, 0, 'Midnight Asura', 0, 4100, 3100, 1, 1, '[\"Ah, the sweet music of a beating heart!\",\"Death and Darkness\",\"Embrace the night!\",\"May night fall upon you!\"]', '[\"death\",\"paralyze\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2148\",\"count\":\"100\",\"chance\":\"100000\"},{\"id\":\"2148\",\"count\":\"100\",\"chance\":\"80000\"},{\"id\":\"2148\",\"count\":\"42\",\"chance\":\"60000\"},{\"id\":\"2152\",\"count\":\"6\",\"chance\":\"18200\"},{\"id\":\"7368\",\"count\":\"2\",\"chance\":\"2000\"},{\"id\":\"2144\",\"count\":1,\"chance\":\"2000\"},{\"id\":\"6558\",\"count\":1,\"chance\":\"2000\"},{\"id\":\"6500\",\"count\":1,\"chance\":\"2210\"},{\"id\":\"2145\",\"count\":\"3\",\"chance\":\"800\"},{\"id\":\"2149\",\"count\":\"3\",\"chance\":\"900\"},{\"id\":\"2147\",\"count\":\"3\",\"chance\":\"650\"},{\"id\":\"2146\",\"count\":\"3\",\"chance\":\"580\"},{\"id\":\"9970\",\"count\":\"3\",\"chance\":\"580\"},{\"id\":\"7591\",\"count\":1,\"chance\":\"700\"},{\"id\":\"2143\",\"count\":1,\"chance\":\"560\"},{\"id\":\"7404\",\"count\":1,\"chance\":\"130\"},{\"id\":\"2158\",\"count\":1,\"chance\":\"320\"},{\"id\":\"2656\",\"count\":1,\"chance\":\"300\"},{\"id\":\"9971\",\"count\":1,\"chance\":\"300\"},{\"id\":\"24630\",\"count\":1,\"chance\":\"300\"},{\"id\":\"2186\",\"count\":1,\"chance\":\"300\"},{\"id\":\"2185\",\"count\":1,\"chance\":\"90\"},{\"id\":\"24637\",\"count\":1,\"chance\":\"80\"},{\"id\":\"24631\",\"count\":1,\"chance\":\"200\"},{\"id\":\"8889\",\"count\":1,\"chance\":\"90\"},{\"id\":\"2134\",\"count\":1,\"chance\":\"100\"},{\"id\":\"2170\",\"count\":1,\"chance\":\"100\"},{\"id\":\"5944\",\"count\":1,\"chance\":\"100\"},{\"id\":\"8902\",\"count\":1,\"chance\":\"100\"},{\"id\":\"3967\",\"count\":1,\"chance\":\"100\"},{\"id\":\"8910\",\"count\":1,\"chance\":\"70\"},{\"id\":\"2154\",\"count\":1,\"chance\":\"100\"}]'),
(1870, 0, 'Midnight Panther', 0, 900, 1200, 15, 1, '[]', '[\"paralyze\",\"invisible\",\"energy\"]', 0, 0, 'blood', '[{\"id\":2148,\"count\":\"57\",\"chance\":\"100000\"},{\"id\":2168,\"count\":1,\"chance\":\"12500\"},{\"id\":2666,\"count\":\"4\",\"chance\":\"25000\"},{\"id\":13026,\"count\":1,\"chance\":\"12500\"},{\"id\":13027,\"count\":1,\"chance\":\"100000\"}]'),
(1871, 0, 'Midnight Spawn', 0, 900, 1000, 5, 0, '[]', '[\"paralyze\",\"invisible\"]', 0, 0, 'undead', '[{\"id\":10531,\"count\":1,\"chance\":\"8333\"}]'),
(1872, 0, 'Mimic', 0, 0, 30, 1, 0, '[]', '[]', 0, 0, 'blood', '[]'),
(1873, 0, 'Minion Of Gaz\'haragoth', 0, 0, 5500, 38, 0, '[]', '[\"earth\",\"lifedrain\",\"paralyze\",\"invisible\"]', 0, 0, 'fire', '[]'),
(1874, 0, 'Minishabaal', 0, 4000, 6000, 240, 1, '[\"I had Princess Lumelia as breakfast!\",\"Naaa-Nana-Naaa-Naaa!\",\"My brother will come and get you for this!\",\"Get them Fluffy!\",\"He He He!\",\"Pftt, Ferumbras such an upstart!\",\"My dragon is not that old, it\'s just second hand!\",\"My other dragon is a red one!\",\"When I am big I want to become the ruthless eighth!\",\"WHERE\'S FLUFFY?\",\"Muahaha!\"]', '[\"fire\",\"lifedrain\",\"paralyze\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2136\",\"count\":1,\"chance\":\"909\"},{\"id\":2148,\"count\":\"40\",\"chance\":\"100000\"},{\"id\":2150,\"count\":\"2\",\"chance\":\"1428\"},{\"id\":2432,\"count\":1,\"chance\":\"666\"},{\"id\":2470,\"count\":1,\"chance\":\"180\"},{\"id\":\"2488\",\"count\":1,\"chance\":\"800\"},{\"id\":2515,\"count\":1,\"chance\":\"1333\"},{\"id\":2520,\"count\":1,\"chance\":\"200\"},{\"id\":2542,\"count\":1,\"chance\":\"100\"},{\"id\":2493,\"count\":1,\"chance\":\"100\"},{\"id\":2548,\"count\":1,\"chance\":\"2857\"},{\"id\":5944,\"count\":\"2\",\"chance\":\"909\"},{\"id\":6500,\"count\":\"2\",\"chance\":\"1000\"}]'),
(1875, 0, 'Minotaur Amazon', 0, 2200, 2600, 15, 0, '[\"I\'ll protect the herd!\",\"Never surrender!\",\"You won\'t hurt us!\",\"I will not allow your evil to continue!\"]', '[\"paralyze\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2148\",\"count\":\"199\",\"chance\":\"100000\"},{\"id\":\"2152\",\"count\":\"3\",\"chance\":\"65302\"},{\"id\":\"2671\",\"count\":1,\"chance\":\"59419\"},{\"id\":\"23575\",\"count\":1,\"chance\":\"19739\"},{\"id\":\"5878\",\"count\":1,\"chance\":\"16261\"},{\"id\":\"7590\",\"count\":1,\"chance\":\"7272\"},{\"id\":\"2666\",\"count\":1,\"chance\":\"6756\"},{\"id\":\"7591\",\"count\":1,\"chance\":\"6670\"},{\"id\":\"12428\",\"count\":\"2\",\"chance\":\"5110\"},{\"id\":\"9970\",\"count\":\"2\",\"chance\":\"5082\"},{\"id\":\"2147\",\"count\":\"2\",\"chance\":\"5024\"},{\"id\":\"2150\",\"count\":\"2\",\"chance\":\"4924\"},{\"id\":\"2149\",\"count\":\"2\",\"chance\":\"4395\"},{\"id\":\"23546\",\"count\":1,\"chance\":\"3851\"},{\"id\":\"7368\",\"count\":\"5\",\"chance\":\"3092\"},{\"id\":\"2214\",\"count\":1,\"chance\":\"2376\"},{\"id\":\"23545\",\"count\":1,\"chance\":\"1646\"},{\"id\":\"2197\",\"count\":1,\"chance\":\"859\"},{\"id\":\"7443\",\"count\":1,\"chance\":\"845\"},{\"id\":\"2475\",\"count\":1,\"chance\":\"701\"},{\"id\":\"9971\",\"count\":1,\"chance\":\"601\"},{\"id\":\"5911\",\"count\":1,\"chance\":\"558\"},{\"id\":\"2154\",\"count\":1,\"chance\":\"558\"},{\"id\":\"2156\",\"count\":1,\"chance\":\"415\"},{\"id\":\"7401\",\"count\":1,\"chance\":\"243\"}]'),
(1876, 0, 'Minotaur Archer', 390, 65, 100, 1, 0, '[\"Ruan Wihmpy!\",\"Kaplar!\"]', '[]', 1, 1, 'blood', '[{\"id\":\"2543\",\"count\":\"20\",\"chance\":\"90124\"},{\"id\":\"2148\",\"count\":\"30\",\"chance\":\"75036\"},{\"id\":\"12407\",\"count\":1,\"chance\":\"15323\"},{\"id\":\"7363\",\"count\":\"4\",\"chance\":\"12190\"},{\"id\":\"12439\",\"count\":1,\"chance\":\"8034\"},{\"id\":\"2666\",\"count\":1,\"chance\":\"4952\"},{\"id\":\"12428\",\"count\":\"2\",\"chance\":\"1973\"},{\"id\":\"5878\",\"count\":1,\"chance\":\"1925\"},{\"id\":\"2455\",\"count\":1,\"chance\":\"877\"},{\"id\":\"2483\",\"count\":1,\"chance\":\"539\"},{\"id\":\"2465\",\"count\":1,\"chance\":\"519\"}]'),
(1877, 0, 'Minotaur Guard', 550, 160, 185, 1, 0, '[\"Kirrl Karrrl!\",\"Kaplar\"]', '[]', 1, 1, 'blood', '[{\"id\":\"2148\",\"count\":\"20\",\"chance\":\"59686\"},{\"id\":\"12428\",\"count\":\"2\",\"chance\":\"8195\"},{\"id\":\"12438\",\"count\":1,\"chance\":\"4980\"},{\"id\":\"2465\",\"count\":1,\"chance\":\"4125\"},{\"id\":\"2464\",\"count\":1,\"chance\":\"2983\"},{\"id\":\"2513\",\"count\":1,\"chance\":\"2093\"},{\"id\":\"5878\",\"count\":1,\"chance\":\"945\"},{\"id\":\"2580\",\"count\":1,\"chance\":\"481\"},{\"id\":\"2387\",\"count\":1,\"chance\":\"434\"},{\"id\":\"7618\",\"count\":1,\"chance\":\"413\"},{\"id\":\"7401\",\"count\":1,\"chance\":\"94\"}]'),
(1878, 0, 'Minotaur Hunter', 0, 1700, 1400, 5, 1, '[\"You are marked for death!\",\"This time the prey is you!\",\"You are hunted!\",\"Bullseye!\",\"You\'ll make a fine trophy!\"]', '[\"paralyze\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2148\",\"count\":\"200\",\"chance\":\"99464\"},{\"id\":\"2152\",\"count\":\"3\",\"chance\":\"35026\"},{\"id\":\"3965\",\"count\":\"5\",\"chance\":\"15007\"},{\"id\":\"2260\",\"count\":\"2\",\"chance\":\"14990\"},{\"id\":\"7378\",\"count\":\"5\",\"chance\":\"11751\"},{\"id\":\"7589\",\"count\":\"2\",\"chance\":\"10135\"},{\"id\":\"7588\",\"count\":\"2\",\"chance\":\"9908\"},{\"id\":\"5944\",\"count\":1,\"chance\":\"7011\"},{\"id\":\"12428\",\"count\":\"2\",\"chance\":\"5046\"},{\"id\":\"5878\",\"count\":1,\"chance\":\"4850\"},{\"id\":\"2147\",\"count\":\"3\",\"chance\":\"2550\"},{\"id\":\"2150\",\"count\":\"3\",\"chance\":\"2454\"},{\"id\":\"2165\",\"count\":1,\"chance\":\"2400\"},{\"id\":\"5910\",\"count\":1,\"chance\":\"1537\"},{\"id\":\"5912\",\"count\":1,\"chance\":\"1506\"},{\"id\":\"5911\",\"count\":1,\"chance\":\"1484\"},{\"id\":\"23546\",\"count\":1,\"chance\":\"746\"},{\"id\":\"2154\",\"count\":1,\"chance\":\"556\"},{\"id\":\"2156\",\"count\":1,\"chance\":\"535\"},{\"id\":\"7401\",\"count\":1,\"chance\":\"162\"},{\"id\":\"23537\",\"count\":1,\"chance\":\"104\"}]'),
(1879, 0, 'Minotaur Mage', 0, 150, 155, 1, 0, '[\"Learrn tha secrret uf deathhh!\",\"Kaplar!\"]', '[\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2148\",\"count\":\"35\",\"chance\":\"85291\"},{\"id\":\"2684\",\"count\":\"8\",\"chance\":\"14690\"},{\"id\":\"12429\",\"count\":1,\"chance\":\"6068\"},{\"id\":\"2050\",\"count\":1,\"chance\":\"5008\"},{\"id\":\"2649\",\"count\":1,\"chance\":\"4908\"},{\"id\":\"2461\",\"count\":1,\"chance\":\"3197\"},{\"id\":\"12428\",\"count\":\"2\",\"chance\":\"3096\"},{\"id\":\"5878\",\"count\":1,\"chance\":\"2090\"},{\"id\":\"7425\",\"count\":1,\"chance\":\"959\"},{\"id\":\"2189\",\"count\":1,\"chance\":\"556\"},{\"id\":\"7620\",\"count\":1,\"chance\":\"470\"}]'),
(1880, 0, 'Minotaur', 330, 50, 100, 1, 0, '[\"Kaplar!\",\"Hurr\"]', '[]', 1, 1, 'blood', '[{\"id\":2148,\"count\":\"25\",\"chance\":\"67500\"},{\"id\":2510,\"count\":1,\"chance\":\"20020\"},{\"id\":2398,\"count\":1,\"chance\":\"12840\"},{\"id\":2464,\"count\":1,\"chance\":\"10000\"},{\"id\":2460,\"count\":1,\"chance\":\"7700\"},{\"id\":\"2376\",\"count\":1,\"chance\":\"5000\"},{\"id\":2666,\"count\":1,\"chance\":\"5000\"},{\"id\":2386,\"count\":1,\"chance\":\"4000\"},{\"id\":12428,\"count\":\"2\",\"chance\":\"2090\"},{\"id\":5878,\"count\":1,\"chance\":\"990\"},{\"id\":\"2554\",\"count\":1,\"chance\":\"310\"},{\"id\":2172,\"count\":1,\"chance\":\"110\"}]'),
(1881, 0, 'Modified Gnarlhound', 0, 0, 1500, 115, 0, '[]', '[\"death\",\"holy\",\"invisible\",\"earth\"]', 0, 0, 'blood', '[]'),
(1882, 0, 'Monk', 600, 200, 240, 10, 1, '[\"Repent Heretic!\",\"A prayer to the almighty one!\",\"I will punish the sinners!\"]', '[\"invisible\"]', 1, 0, 'blood', '[{\"id\":2689,\"count\":1,\"chance\":\"20000\"},{\"id\":2148,\"count\":\"18\",\"chance\":\"15000\"},{\"id\":10563,\"count\":1,\"chance\":\"4930\"},{\"id\":12448,\"count\":1,\"chance\":\"3150\"},{\"id\":2193,\"count\":1,\"chance\":\"2240\"},{\"id\":\"1949\",\"count\":1,\"chance\":\"1700\"},{\"id\":2177,\"count\":1,\"chance\":\"1002\"},{\"id\":12449,\"count\":1,\"chance\":\"1001\"},{\"id\":2015,\"count\":1,\"chance\":\"890\"},{\"id\":\"2044\",\"count\":1,\"chance\":\"840\"},{\"id\":2642,\"count\":1,\"chance\":\"660\"},{\"id\":\"2401\",\"count\":1,\"chance\":\"440\"},{\"id\":2166,\"count\":1,\"chance\":\"100\"}]'),
(1883, 0, 'Monstor', 0, 575, 960, 65, 0, '[\"NO ARMY ME STOPPING! GRARR!\",\"ME DESTROY CITY! GROAR!\",\"WHARR! MUST ... KIDNAP WOMEN!\"]', '[\"lifedrain\",\"invisible\"]', 0, 0, 'blood', '[]'),
(1884, 0, 'Mooh\'Tah Warrior', 0, 900, 1200, 1, 1, '[\"Feel the power of the Mooh\'Tah!\",\"Ommm!\",\"I am at peace and you are dead!\",\"There is no rage, there is only control!\",\"You will not disrupt my inner balance!\"]', '[\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2148\",\"count\":\"100\",\"chance\":\"100000\"},{\"id\":\"2148\",\"count\":\"20\",\"chance\":\"60000\"},{\"id\":\"2152\",\"count\":\"3\",\"chance\":\"39860\"},{\"id\":\"23573\",\"count\":1,\"chance\":\"15030\"},{\"id\":\"7589\",\"count\":1,\"chance\":\"7110\"},{\"id\":\"7588\",\"count\":1,\"chance\":\"6390\"},{\"id\":\"5878\",\"count\":1,\"chance\":\"5530\"},{\"id\":\"2147\",\"count\":1,\"chance\":\"5470\"},{\"id\":\"2149\",\"count\":1,\"chance\":\"5280\"},{\"id\":\"2150\",\"count\":1,\"chance\":\"5200\"},{\"id\":\"9970\",\"count\":1,\"chance\":\"4760\"},{\"id\":\"12428\",\"count\":\"2\",\"chance\":\"4710\"},{\"id\":\"23548\",\"count\":1,\"chance\":\"1380\"},{\"id\":\"2207\",\"count\":1,\"chance\":\"1110\"},{\"id\":\"23537\",\"count\":1,\"chance\":\"1090\"},{\"id\":\"2515\",\"count\":1,\"chance\":\"1020\"},{\"id\":\"2477\",\"count\":1,\"chance\":\"710\"},{\"id\":\"5911\",\"count\":1,\"chance\":\"650\"},{\"id\":\"2476\",\"count\":1,\"chance\":\"490\"},{\"id\":\"7401\",\"count\":1,\"chance\":\"150\"}]'),
(1885, 0, 'Moohtant', 0, 2600, 3200, 20, 0, '[\"MOOOOH!\",\"Grrrr.\",\"Raaaargh!\"]', '[\"earth\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2148\",\"count\":\"100\",\"chance\":\"100000\"},{\"id\":\"2148\",\"count\":\"95\",\"chance\":\"60000\"},{\"id\":\"2152\",\"count\":\"2\",\"chance\":\"58160\"},{\"id\":\"23554\",\"count\":\"2\",\"chance\":\"15740\"},{\"id\":\"23570\",\"count\":1,\"chance\":\"11770\"},{\"id\":\"7591\",\"count\":\"3\",\"chance\":\"7380\"},{\"id\":\"7590\",\"count\":\"3\",\"chance\":\"7230\"},{\"id\":\"2666\",\"count\":1,\"chance\":\"6520\"},{\"id\":\"2147\",\"count\":\"2\",\"chance\":\"4680\"},{\"id\":\"5878\",\"count\":1,\"chance\":\"4110\"},{\"id\":\"2145\",\"count\":\"2\",\"chance\":\"4400\"},{\"id\":\"2214\",\"count\":1,\"chance\":\"2410\"},{\"id\":\"5911\",\"count\":1,\"chance\":\"1700\"},{\"id\":\"23544\",\"count\":1,\"chance\":\"1560\"},{\"id\":\"2156\",\"count\":1,\"chance\":\"850\"},{\"id\":\"2154\",\"count\":1,\"chance\":\"710\"},{\"id\":\"7452\",\"count\":1,\"chance\":\"430\"},{\"id\":\"7427\",\"count\":1,\"chance\":\"280\"},{\"id\":\"9971\",\"count\":1,\"chance\":\"280\"},{\"id\":\"7401\",\"count\":1,\"chance\":\"280\"}]'),
(1886, 0, 'Morgaroth', 0, 15000, 55000, 90, 1, '[\"I AM MORGAROTH, LORD OF THE TRIANGLE... AND YOU ARE LOST!\",\"MY SEED IS FEAR AND MY HARVEST ARE YOUR SOULS!\",\"ZATHROTH! LOOK AT THE DESTRUCTION I AM CAUSING IN YOUR NAME!\",\"THE TRIANGLE OF TERROR WILL RISE!\"]', '[\"fire\",\"earth\",\"paralyze\",\"invisible\"]', 0, 0, 'fire', '[{\"id\":\"6500\",\"count\":1,\"chance\":\"95455\"},{\"id\":\"2152\",\"count\":\"74\",\"chance\":\"95455\"},{\"id\":\"2155\",\"count\":1,\"chance\":\"50000\"},{\"id\":\"7590\",\"count\":1,\"chance\":\"45455\"},{\"id\":\"2150\",\"count\":\"18\",\"chance\":\"36364\"},{\"id\":\"8852\",\"count\":1,\"chance\":\"36364\"},{\"id\":\"1986\",\"count\":1,\"chance\":\"27273\"},{\"id\":\"2149\",\"count\":\"6\",\"chance\":\"27273\"},{\"id\":\"2146\",\"count\":\"8\",\"chance\":\"27273\"},{\"id\":\"8473\",\"count\":1,\"chance\":\"27273\"},{\"id\":\"8850\",\"count\":1,\"chance\":\"22727\"},{\"id\":\"8865\",\"count\":1,\"chance\":\"22727\"},{\"id\":\"6300\",\"count\":1,\"chance\":\"22727\"},{\"id\":\"5954\",\"count\":\"2\",\"chance\":\"22727\"},{\"id\":\"2214\",\"count\":1,\"chance\":\"22727\"},{\"id\":\"2151\",\"count\":\"7\",\"chance\":\"22727\"},{\"id\":\"8853\",\"count\":1,\"chance\":\"22727\"},{\"id\":\"2387\",\"count\":1,\"chance\":\"18182\"},{\"id\":\"8881\",\"count\":1,\"chance\":\"18182\"},{\"id\":\"8472\",\"count\":1,\"chance\":\"18182\"},{\"id\":\"2472\",\"count\":1,\"chance\":\"18182\"},{\"id\":\"2164\",\"count\":1,\"chance\":\"18182\"},{\"id\":\"2178\",\"count\":1,\"chance\":\"18182\"},{\"id\":\"8851\",\"count\":1,\"chance\":\"18182\"},{\"id\":\"2165\",\"count\":1,\"chance\":\"18182\"},{\"id\":\"2112\",\"count\":1,\"chance\":\"18182\"},{\"id\":\"7368\",\"count\":\"28\",\"chance\":\"13636\"},{\"id\":\"2144\",\"count\":\"15\",\"chance\":\"13636\"},{\"id\":\"7431\",\"count\":1,\"chance\":\"13636\"},{\"id\":\"2033\",\"count\":1,\"chance\":\"13636\"},{\"id\":\"5943\",\"count\":1,\"chance\":\"13636\"},{\"id\":\"8928\",\"count\":1,\"chance\":\"13636\"},{\"id\":\"8929\",\"count\":1,\"chance\":\"13636\"},{\"id\":\"2143\",\"count\":\"13\",\"chance\":\"13636\"},{\"id\":\"2158\",\"count\":1,\"chance\":\"9091\"},{\"id\":\"2520\",\"count\":1,\"chance\":\"9091\"},{\"id\":\"2167\",\"count\":1,\"chance\":\"9091\"},{\"id\":\"2393\",\"count\":1,\"chance\":\"9091\"},{\"id\":\"2179\",\"count\":1,\"chance\":\"9091\"},{\"id\":\"2470\",\"count\":1,\"chance\":\"9091\"},{\"id\":\"2177\",\"count\":1,\"chance\":\"9091\"},{\"id\":\"2162\",\"count\":1,\"chance\":\"9091\"},{\"id\":\"2176\",\"count\":1,\"chance\":\"9091\"},{\"id\":\"2645\",\"count\":1,\"chance\":\"9091\"},{\"id\":\"2174\",\"count\":1,\"chance\":\"9091\"},{\"id\":\"2421\",\"count\":1,\"chance\":\"9091\"},{\"id\":\"2124\",\"count\":1,\"chance\":\"4545\"},{\"id\":\"8867\",\"count\":1,\"chance\":\"4545\"},{\"id\":\"2432\",\"count\":1,\"chance\":\"4545\"},{\"id\":\"7591\",\"count\":1,\"chance\":\"4545\"},{\"id\":\"2514\",\"count\":1,\"chance\":\"4545\"},{\"id\":\"8886\",\"count\":1,\"chance\":\"4545\"},{\"id\":\"2145\",\"count\":\"5\",\"chance\":\"4545\"}]'),
(1887, 0, 'Morguthis', 0, 3000, 4800, 50, 1, '[\"Vengeance!\",\"You will make a fine trophy.\",\"Come and fight me, cowards!\",\"I am the supreme warrior!\",\"Let me hear the music of battle.\",\"Anotherone to bite the dust!\"]', '[\"death\",\"paralyze\",\"invisible\"]', 0, 0, 'undead', '[{\"id\":2350,\"count\":1,\"chance\":\"100000\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"30000\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"30000\"},{\"id\":2148,\"count\":\"21\",\"chance\":\"30000\"},{\"id\":2144,\"count\":1,\"chance\":\"10000\"},{\"id\":7368,\"count\":\"3\",\"chance\":\"9700\"},{\"id\":7591,\"count\":1,\"chance\":\"9500\"},{\"id\":2430,\"count\":1,\"chance\":\"6000\"},{\"id\":2197,\"count\":1,\"chance\":\"5000\"},{\"id\":11207,\"count\":1,\"chance\":\"140\"},{\"id\":2443,\"count\":1,\"chance\":\"150\"},{\"id\":2645,\"count\":1,\"chance\":\"150\"},{\"id\":\"2136\",\"count\":1,\"chance\":\"140\"}]'),
(1888, 0, 'Morik The Gladiator', 0, 160, 1235, 1, 1, '[\"To be the one you\'ll have to beat the one!\",\"Where did I put my ultimate health potion again?\",\"I am the best!\",\"I\'ll take your ears as a trophy!\"]', '[\"invisible\"]', 0, 0, 'blood', '[{\"id\":9735,\"count\":1,\"chance\":\"100000\"}]'),
(1889, 0, 'Mornenion', 0, 115, 190, 1, 0, '[\"Let us leave safely and maybe we\'ll give you a few coins.\"]', '[\"invisible\"]', 0, 0, 'blood', '[{\"id\":14903,\"count\":1,\"chance\":\"100000\"},{\"id\":2152,\"count\":\"88\",\"chance\":\"100000\"}]'),
(1890, 0, 'Mr. Punish', 0, 9000, 22000, 125, 0, '[]', '[\"energy\",\"fire\",\"earth\",\"invisible\"]', 0, 0, 'undead', '[{\"id\":6537,\"count\":1,\"chance\":\"100000\"}]'),
(1891, 0, 'Muddy Earth Elemental', 0, 450, 650, 20, 0, '[]', '[\"paralyze\",\"invisible\",\"earth\"]', 0, 0, 'undead', '[{\"id\":1294,\"count\":\"3\",\"chance\":\"40000\"},{\"id\":2148,\"count\":\"80\",\"chance\":\"24500\"},{\"id\":2148,\"count\":\"47\",\"chance\":\"24500\"},{\"id\":\"2244\",\"count\":1,\"chance\":\"22000\"},{\"id\":8298,\"count\":1,\"chance\":\"3750\"}]'),
(1892, 0, 'Mummy', 0, 150, 240, 1, 0, '[\"I will ssswallow your sssoul!\",\"Mort ulhegh dakh visss.\",\"Flesssh to dussst!\",\"I will tassste life again!\",\"Ahkahra exura belil mort!\",\"Yohag Sssetham!\"]', '[\"death\",\"earth\",\"drown\",\"lifedrain\",\"paralyze\",\"invisible\"]', 0, 0, 'undead', '[{\"id\":\"2124\",\"count\":1,\"chance\":\"1500\"},{\"id\":2134,\"count\":1,\"chance\":\"4000\"},{\"id\":2144,\"count\":1,\"chance\":\"1000\"},{\"id\":2148,\"count\":\"80\",\"chance\":\"38000\"},{\"id\":2161,\"count\":1,\"chance\":\"5000\"},{\"id\":\"2162\",\"count\":1,\"chance\":\"5800\"},{\"id\":2170,\"count\":1,\"chance\":\"100\"},{\"id\":2411,\"count\":1,\"chance\":\"450\"},{\"id\":2529,\"count\":1,\"chance\":\"170\"},{\"id\":3976,\"count\":\"3\",\"chance\":\"19000\"},{\"id\":5914,\"count\":1,\"chance\":\"900\"},{\"id\":10566,\"count\":1,\"chance\":\"10000\"},{\"id\":11207,\"count\":1,\"chance\":\"10\"},{\"id\":12422,\"count\":1,\"chance\":\"11690\"}]'),
(1893, 0, 'Munster', 250, 35, 58, 1, 0, '[\"Meeeeep!\"]', '[]', 1, 1, 'blood', '[{\"id\":2148,\"count\":\"16\",\"chance\":\"100000\"},{\"id\":2449,\"count\":1,\"chance\":\"5000\"},{\"id\":2650,\"count\":1,\"chance\":\"50000\"},{\"id\":2687,\"count\":1,\"chance\":\"5000\"},{\"id\":\"2696\",\"count\":1,\"chance\":\"50000\"}]'),
(1894, 0, 'Mushroom Sniffer', 0, 0, 250, 1, 0, '[\"Sniff\",\"Oink\",\"Oink oink\"]', '[]', 0, 0, 'blood', '[]');
INSERT INTO `myaac_monsters` (`id`, `hidden`, `name`, `mana`, `exp`, `health`, `speed_lvl`, `use_haste`, `voices`, `immunities`, `summonable`, `convinceable`, `race`, `loot`) VALUES
(1895, 0, 'Mutated Bat', 0, 615, 900, 1, 0, '[\"Shriiiiiek\"]', '[\"death\",\"earth\",\"drown\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2148\",\"count\":\"130\",\"chance\":\"92495\"},{\"id\":\"9808\",\"count\":1,\"chance\":\"12568\"},{\"id\":\"2513\",\"count\":1,\"chance\":\"8554\"},{\"id\":\"2425\",\"count\":1,\"chance\":\"6597\"},{\"id\":\"10579\",\"count\":1,\"chance\":\"5205\"},{\"id\":\"2800\",\"count\":1,\"chance\":\"4862\"},{\"id\":\"5894\",\"count\":\"2\",\"chance\":\"4761\"},{\"id\":\"2167\",\"count\":1,\"chance\":\"1029\"},{\"id\":\"2144\",\"count\":\"3\",\"chance\":\"908\"},{\"id\":\"9809\",\"count\":1,\"chance\":\"726\"},{\"id\":\"2150\",\"count\":\"2\",\"chance\":\"625\"},{\"id\":\"10016\",\"count\":1,\"chance\":\"141\"},{\"id\":\"2529\",\"count\":1,\"chance\":\"121\"},{\"id\":\"7386\",\"count\":1,\"chance\":\"121\"}]'),
(1896, 0, 'Mutated Human', 0, 150, 240, 1, 1, '[\"Take that creature off my back!! I can fell it!\",\"HEEEEEEEELP!\",\"You will be the next infected one... GRAAAAAAAAARRR!\",\"Science... is a curse.\",\"Run as fast as you can.\",\"Oh by the gods! What is this... aaaaaargh!\"]', '[\"death\",\"earth\",\"paralyze\",\"lifedrain\",\"drunk\",\"drown\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2148\",\"count\":\"130\",\"chance\":\"88222\"},{\"id\":\"11225\",\"count\":1,\"chance\":\"19936\"},{\"id\":\"2226\",\"count\":1,\"chance\":\"10064\"},{\"id\":\"3607\",\"count\":1,\"chance\":\"8076\"},{\"id\":\"2483\",\"count\":1,\"chance\":\"7833\"},{\"id\":\"3976\",\"count\":\"2\",\"chance\":\"7081\"},{\"id\":\"2376\",\"count\":1,\"chance\":\"5069\"},{\"id\":\"2161\",\"count\":1,\"chance\":\"4946\"},{\"id\":\"9808\",\"count\":1,\"chance\":\"2007\"},{\"id\":\"7910\",\"count\":1,\"chance\":\"534\"},{\"id\":\"2801\",\"count\":1,\"chance\":\"421\"},{\"id\":\"2170\",\"count\":1,\"chance\":\"102\"}]'),
(1897, 0, 'Mutated Rat', 0, 450, 550, 5, 0, '[\"Grrrrrrrrrrrrrr!\",\"Fcccccchhhhhh\"]', '[\"death\",\"earth\",\"paralyze\",\"lifedrain\",\"drunk\",\"drown\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2148\",\"count\":\"130\",\"chance\":\"78725\"},{\"id\":\"2229\",\"count\":1,\"chance\":\"20298\"},{\"id\":\"2799\",\"count\":1,\"chance\":\"4874\"},{\"id\":\"10585\",\"count\":1,\"chance\":\"3852\"},{\"id\":\"2510\",\"count\":1,\"chance\":\"3777\"},{\"id\":\"2381\",\"count\":1,\"chance\":\"2957\"},{\"id\":\"2796\",\"count\":1,\"chance\":\"1370\"},{\"id\":\"2235\",\"count\":1,\"chance\":\"950\"},{\"id\":\"2165\",\"count\":1,\"chance\":\"562\"},{\"id\":\"7618\",\"count\":1,\"chance\":\"507\"},{\"id\":\"8900\",\"count\":1,\"chance\":\"297\"},{\"id\":\"2528\",\"count\":1,\"chance\":\"50\"}]'),
(1898, 0, 'Mutated Tiger', 0, 750, 1100, 10, 0, '[\"GRAAARRRRRR\",\"CHHHHHHHHHHH\"]', '[\"paralyze\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":2148,\"count\":\"100\",\"chance\":\"50000\"},{\"id\":2148,\"count\":\"5\",\"chance\":\"50000\"},{\"id\":2168,\"count\":1,\"chance\":\"5580\"},{\"id\":2515,\"count\":1,\"chance\":\"380\"},{\"id\":2666,\"count\":\"2\",\"chance\":\"29500\"},{\"id\":7436,\"count\":1,\"chance\":\"440\"},{\"id\":7454,\"count\":1,\"chance\":\"870\"},{\"id\":7588,\"count\":1,\"chance\":\"6000\"},{\"id\":9959,\"count\":1,\"chance\":\"730\"},{\"id\":11210,\"count\":1,\"chance\":\"20130\"},{\"id\":11228,\"count\":1,\"chance\":\"10600\"}]'),
(1899, 0, 'Necromancer Servant', 390, 590, 600, 1, 0, '[\"Blib!\",\"Blub!\"]', '[]', 1, 1, 'blood', '[]'),
(1900, 0, 'Necromancer', 0, 580, 580, 1, 0, '[\"Your corpse will be mine!\",\"Taste the sweetness of death!\"]', '[\"invisible\",\"earth\",\"drown\"]', 0, 0, 'blood', '[{\"id\":2148,\"count\":\"90\",\"chance\":\"30050\"},{\"id\":2545,\"count\":\"5\",\"chance\":\"15000\"},{\"id\":11237,\"count\":1,\"chance\":\"10130\"},{\"id\":2796,\"count\":1,\"chance\":\"1470\"},{\"id\":12431,\"count\":1,\"chance\":\"1001\"},{\"id\":2663,\"count\":1,\"chance\":\"500\"},{\"id\":2423,\"count\":1,\"chance\":\"390\"},{\"id\":7589,\"count\":1,\"chance\":\"300\"},{\"id\":2195,\"count\":1,\"chance\":\"210\"},{\"id\":8901,\"count\":1,\"chance\":\"130\"},{\"id\":2436,\"count\":1,\"chance\":\"100\"},{\"id\":7456,\"count\":1,\"chance\":\"10\"}]'),
(1901, 0, 'Necropharus', 0, 1050, 750, 10, 0, '[\"You will rise as my servant!\",\"Praise to my master Urgith!\"]', '[\"earth\",\"lifedrain\",\"outfit\",\"drunk\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":2148,\"count\":\"100\",\"chance\":\"100000\"},{\"id\":11237,\"count\":1,\"chance\":\"100000\"},{\"id\":12431,\"count\":1,\"chance\":\"100000\"},{\"id\":5809,\"count\":1,\"chance\":\"100000\"},{\"id\":2423,\"count\":1,\"chance\":\"55000\"},{\"id\":2436,\"count\":1,\"chance\":\"44000\"},{\"id\":2449,\"count\":1,\"chance\":\"36000\"},{\"id\":2796,\"count\":1,\"chance\":\"25000\"},{\"id\":\"2229\",\"count\":1,\"chance\":\"13000\"},{\"id\":2663,\"count\":1,\"chance\":\"11000\"},{\"id\":2186,\"count\":1,\"chance\":\"8300\"},{\"id\":\"2231\",\"count\":1,\"chance\":\"5500\"},{\"id\":2541,\"count\":1,\"chance\":\"5500\"},{\"id\":2195,\"count\":1,\"chance\":\"2700\"},{\"id\":7589,\"count\":1,\"chance\":\"2700\"}]'),
(1902, 0, 'Nightfiend', 0, 2100, 2700, 1, 0, '[]', '[\"death\",\"earth\",\"paralyze\",\"invisible\"]', 0, 0, 'blood', '[]'),
(1903, 0, 'Nightmare Of Gaz\'haragoth', 0, 0, 5500, 70, 0, '[]', '[\"earth\",\"energy\",\"lifedrain\",\"paralyze\",\"invisible\"]', 0, 0, 'venom', '[]'),
(1904, 0, 'Nightmare Scion', 0, 1350, 1400, 110, 0, '[\"Weeeheeheee!\",\"Pffffrrrrrrrrrrrr.\",\"Peak a boo, I killed you!\"]', '[\"earth\",\"death\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2148\",\"count\":\"155\",\"chance\":\"97006\"},{\"id\":\"2666\",\"count\":1,\"chance\":\"50392\"},{\"id\":\"11223\",\"count\":1,\"chance\":\"8074\"},{\"id\":\"11229\",\"count\":1,\"chance\":\"4977\"},{\"id\":\"2152\",\"count\":\"3\",\"chance\":\"1074\"},{\"id\":\"2491\",\"count\":1,\"chance\":\"728\"},{\"id\":\"7387\",\"count\":1,\"chance\":\"367\"},{\"id\":\"8871\",\"count\":1,\"chance\":\"330\"},{\"id\":\"6300\",\"count\":1,\"chance\":\"284\"},{\"id\":\"6574\",\"count\":1,\"chance\":\"248\"},{\"id\":\"7451\",\"count\":1,\"chance\":\"248\"},{\"id\":\"9941\",\"count\":1,\"chance\":\"114\"}]'),
(1905, 0, 'Nightmare', 0, 1666, 2700, 122, 1, '[\"Close your eyes... I want to show you something.\",\"I will haunt you forever!\",\"Pffffrrrrrrrrrrrr.\",\"I will make you scream.\",\"Take a ride with me.\",\"Weeeheeheeeheee!\"]', '[\"invisible\",\"death\",\"earth\",\"lifedrain\"]', 0, 0, 'blood', '[{\"id\":\"2148\",\"count\":\"155\",\"chance\":\"97147\"},{\"id\":\"2671\",\"count\":1,\"chance\":\"29615\"},{\"id\":\"6558\",\"count\":1,\"chance\":\"20577\"},{\"id\":\"5944\",\"count\":1,\"chance\":\"20224\"},{\"id\":\"11223\",\"count\":1,\"chance\":\"15577\"},{\"id\":\"11229\",\"count\":1,\"chance\":\"10224\"},{\"id\":\"6500\",\"count\":1,\"chance\":\"9583\"},{\"id\":\"2152\",\"count\":\"3\",\"chance\":\"2660\"},{\"id\":\"2532\",\"count\":1,\"chance\":\"1122\"},{\"id\":\"6300\",\"count\":1,\"chance\":\"1058\"},{\"id\":\"2547\",\"count\":\"4\",\"chance\":\"1026\"},{\"id\":\"2477\",\"count\":1,\"chance\":\"833\"},{\"id\":\"6526\",\"count\":1,\"chance\":\"545\"},{\"id\":\"2195\",\"count\":1,\"chance\":\"288\"},{\"id\":\"5669\",\"count\":1,\"chance\":\"160\"},{\"id\":\"2454\",\"count\":1,\"chance\":\"96\"}]'),
(1906, 0, 'Nightstalker', 0, 500, 700, 20, 1, '[\"The sunlight is so depressing.\",\"Come with me, my child.\",\"I\'ve been in the shadow under your bed last night.\",\"You never know what hides in the night.\",\"I remember your face - and I know where you sleep.\",\"Only the sweetest and cruelest dreams for you, my love.\"]', '[\"paralyze\",\"invisible\"]', 0, 0, 'undead', '[{\"id\":\"2124\",\"count\":1,\"chance\":\"1030\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"50000\"},{\"id\":2148,\"count\":\"10\",\"chance\":\"50000\"},{\"id\":2171,\"count\":1,\"chance\":\"121\"},{\"id\":2195,\"count\":1,\"chance\":\"121\"},{\"id\":2200,\"count\":1,\"chance\":\"847\"},{\"id\":2804,\"count\":1,\"chance\":\"4761\"},{\"id\":7407,\"count\":1,\"chance\":\"318\"},{\"id\":7427,\"count\":1,\"chance\":\"121\"},{\"id\":7589,\"count\":1,\"chance\":\"1612\"},{\"id\":8870,\"count\":1,\"chance\":\"520\"},{\"id\":9942,\"count\":1,\"chance\":\"127\"}]'),
(1907, 0, 'Noble Lion', 0, 400, 1000, 5, 1, '[\"Groarrrr! Rwarrrr!\"]', '[\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2148\",\"count\":\"74\",\"chance\":\"100000\"},{\"id\":\"2666\",\"count\":1,\"chance\":\"25278\"},{\"id\":\"2671\",\"count\":1,\"chance\":\"23609\"},{\"id\":\"10608\",\"count\":1,\"chance\":\"20581\"}]'),
(1908, 0, 'Nomad', 420, 60, 160, 1, 0, '[\"We are the true sons of the desert!\",\"I will leave your remains to the vultures!\",\"We are swift as the wind of the desert!\",\"Your riches will be mine!\"]', '[]', 0, 1, 'blood', '[{\"id\":\"2148\",\"count\":\"40\",\"chance\":\"56210\"},{\"id\":\"8838\",\"count\":\"3\",\"chance\":\"4870\"},{\"id\":\"12412\",\"count\":1,\"chance\":\"2140\"},{\"id\":\"2386\",\"count\":1,\"chance\":\"2730\"},{\"id\":\"2398\",\"count\":1,\"chance\":\"2120\"},{\"id\":\"12448\",\"count\":1,\"chance\":\"6420\"},{\"id\":\"2465\",\"count\":1,\"chance\":\"2350\"},{\"id\":\"2509\",\"count\":1,\"chance\":\"920\"},{\"id\":\"2459\",\"count\":1,\"chance\":\"650\"},{\"id\":\"8267\",\"count\":1,\"chance\":\"210\"}]'),
(1909, 0, 'Norgle Glacierbeard', 0, 2100, 4280, 1, 0, '[\"I\'ll extinguish you warmbloods.\",\"REVENGE!\",\"Far too hot.\",\"DISGUSTING WARMBLOODS!\",\"Revenge is sweetest when served cold.\"]', '[\"ice\",\"outfit\",\"drunk\",\"invisible\"]', 0, 0, 'blood', '[]'),
(1910, 0, 'Northern Pike', 0, 0, 95, 1, 0, '[\"Blub!\"]', '[\"earth\",\"fire\",\"invisible\",\"drown\"]', 0, 0, 'blood', '[]'),
(1911, 0, 'Novice of the Cult', 0, 100, 285, 1, 0, '[\"Fear us!\",\"You will not tell anyone what you have seen!\",\"Your curiosity will be punished!\"]', '[]', 0, 0, 'blood', '[{\"id\":\"1962\",\"count\":1,\"chance\":\"700\"},{\"id\":2145,\"count\":1,\"chance\":\"210\"},{\"id\":2148,\"count\":\"40\",\"chance\":\"43380\"},{\"id\":2190,\"count\":1,\"chance\":\"450\"},{\"id\":2199,\"count\":1,\"chance\":\"420\"},{\"id\":2213,\"count\":1,\"chance\":\"500\"},{\"id\":2661,\"count\":1,\"chance\":\"2900\"},{\"id\":5810,\"count\":1,\"chance\":\"520\"},{\"id\":\"6087\",\"count\":1,\"chance\":\"970\"},{\"id\":10556,\"count\":1,\"chance\":\"1030\"},{\"id\":12448,\"count\":1,\"chance\":\"5910\"}]'),
(1912, 0, 'Obujos', 0, 20000, 35000, 170, 0, '[\"JN OBU!!\",\"QJELL KEJH!!\"]', '[\"ice\",\"paralyze\",\"drown\",\"fire\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":15404,\"count\":1,\"chance\":\"14285\"},{\"id\":15411,\"count\":1,\"chance\":\"100000\"},{\"id\":15412,\"count\":1,\"chance\":\"14285\"}]'),
(1913, 0, 'Ogre Brute', 0, 800, 1000, 1, 0, '[\"You so juicy!\",\"Smash you face in!!!\",\"You stop! You lunch!\"]', '[\"invisible\",\"poison\"]', 0, 0, 'blood', '[{\"id\":2148,\"count\":\"100\",\"chance\":\"100000\"},{\"id\":2148,\"count\":\"25\",\"chance\":\"50000\"},{\"id\":24844,\"count\":1,\"chance\":\"18740\"},{\"id\":2666,\"count\":\"2\",\"chance\":\"14920\"},{\"id\":24845,\"count\":1,\"chance\":\"14660\"},{\"id\":7588,\"count\":1,\"chance\":\"12580\"},{\"id\":12403,\"count\":1,\"chance\":\"4980\"},{\"id\":1294,\"count\":\"5\",\"chance\":\"4980\"},{\"id\":2687,\"count\":\"5\",\"chance\":\"3900\"},{\"id\":24847,\"count\":1,\"chance\":\"3350\"},{\"id\":2147,\"count\":\"2\",\"chance\":\"2460\"},{\"id\":2209,\"count\":1,\"chance\":\"2340\"},{\"id\":2143,\"count\":1,\"chance\":\"2240\"},{\"id\":24849,\"count\":\"2\",\"chance\":\"2150\"},{\"id\":2166,\"count\":1,\"chance\":\"1630\"},{\"id\":24850,\"count\":\"2\",\"chance\":\"1560\"},{\"id\":24827,\"count\":1,\"chance\":\"1040\"},{\"id\":2562,\"count\":1,\"chance\":\"310\"},{\"id\":\"9821\",\"count\":1,\"chance\":\"260\"},{\"id\":10549,\"count\":1,\"chance\":\"1900\"},{\"id\":7428,\"count\":1,\"chance\":\"140\"},{\"id\":24848,\"count\":1,\"chance\":\"140\"},{\"id\":7412,\"count\":1,\"chance\":\"20\"}]'),
(1914, 0, 'Ogre Savage', 0, 625, 800, 1, 1, '[\"You tasty!\",\"Must! Chop! Food! Raahh!\",\"UGGA UGGA!!\"]', '[\"invisible\",\"poison\"]', 0, 0, 'blood', '[{\"id\":2148,\"count\":\"100\",\"chance\":\"100000\"},{\"id\":2148,\"count\":\"54\",\"chance\":\"50000\"},{\"id\":24844,\"count\":1,\"chance\":\"19720\"},{\"id\":24845,\"count\":1,\"chance\":\"17360\"},{\"id\":7588,\"count\":1,\"chance\":\"15330\"},{\"id\":24847,\"count\":1,\"chance\":\"9300\"},{\"id\":2687,\"count\":\"5\",\"chance\":\"8350\"},{\"id\":2194,\"count\":1,\"chance\":\"6120\"},{\"id\":8844,\"count\":\"2\",\"chance\":\"4130\"},{\"id\":24849,\"count\":\"2\",\"chance\":\"3060\"},{\"id\":2147,\"count\":\"2\",\"chance\":\"2840\"},{\"id\":9970,\"count\":\"2\",\"chance\":\"2500\"},{\"id\":24850,\"count\":\"2\",\"chance\":\"2240\"},{\"id\":2391,\"count\":1,\"chance\":\"1510\"},{\"id\":24828,\"count\":1,\"chance\":\"1160\"},{\"id\":7439,\"count\":1,\"chance\":\"520\"},{\"id\":24848,\"count\":1,\"chance\":\"340\"},{\"id\":7419,\"count\":1,\"chance\":\"40\"}]'),
(1915, 0, 'Ogre Shaman', 0, 625, 800, 1, 0, '[\"Stay here, soul food!\",\"You more delicate than clomp!\",\"The spirits hunger!\",\"A sacrifice for Great Hunger!\"]', '[\"invisible\",\"poison\",\"death\"]', 0, 0, 'blood', '[{\"id\":2148,\"count\":\"90\",\"chance\":\"100000\"},{\"id\":7589,\"count\":1,\"chance\":\"15650\"},{\"id\":24844,\"count\":1,\"chance\":\"14010\"},{\"id\":24847,\"count\":1,\"chance\":\"10920\"},{\"id\":24840,\"count\":1,\"chance\":\"10350\"},{\"id\":24845,\"count\":1,\"chance\":\"10040\"},{\"id\":\"2229\",\"count\":1,\"chance\":\"9700\"},{\"id\":24841,\"count\":\"2\",\"chance\":\"9240\"},{\"id\":12408,\"count\":1,\"chance\":\"6680\"},{\"id\":20111,\"count\":1,\"chance\":\"5080\"},{\"id\":2147,\"count\":1,\"chance\":\"3130\"},{\"id\":2144,\"count\":1,\"chance\":\"2600\"},{\"id\":2185,\"count\":1,\"chance\":\"2600\"},{\"id\":2188,\"count\":1,\"chance\":\"2330\"},{\"id\":2031,\"count\":1,\"chance\":\"2060\"},{\"id\":24850,\"count\":\"2\",\"chance\":\"1640\"},{\"id\":24849,\"count\":\"2\",\"chance\":\"1340\"},{\"id\":24848,\"count\":1,\"chance\":\"880\"},{\"id\":24839,\"count\":1,\"chance\":\"500\"},{\"id\":3952,\"count\":1,\"chance\":\"460\"},{\"id\":\"3955\",\"count\":1,\"chance\":\"40\"}]'),
(1916, 0, 'Omruc', 0, 2950, 4300, 75, 0, '[\"Now chhhou shhhee me ... Now chhhou don\'t.\",\"Chhhhou are marked ashhh my prey.\",\"Psssst, I am over chhhere.\",\"Catchhhh me if chhhou can.\",\"Die!\"]', '[\"death\",\"paralyze\",\"invisible\"]', 0, 0, 'undead', '[{\"id\":\"2352\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2148\",\"count\":\"211\",\"chance\":\"85417\"},{\"id\":\"2674\",\"count\":\"2\",\"chance\":\"78125\"},{\"id\":\"2545\",\"count\":\"19\",\"chance\":\"57292\"},{\"id\":\"2546\",\"count\":\"15\",\"chance\":\"47917\"},{\"id\":\"7365\",\"count\":\"6\",\"chance\":\"33333\"},{\"id\":\"2544\",\"count\":\"25\",\"chance\":\"22917\"},{\"id\":\"2547\",\"count\":\"5\",\"chance\":\"17708\"},{\"id\":\"7591\",\"count\":1,\"chance\":\"11458\"},{\"id\":\"2145\",\"count\":\"3\",\"chance\":\"9375\"},{\"id\":\"2165\",\"count\":1,\"chance\":\"3125\"},{\"id\":\"11207\",\"count\":1,\"chance\":\"2083\"},{\"id\":\"2195\",\"count\":1,\"chance\":\"1042\"}]'),
(1917, 0, 'Orc Berserker', 590, 195, 210, 15, 1, '[\"KRAK ORRRRRRK!\"]', '[]', 1, 1, 'blood', '[{\"id\":\"2148\",\"count\":\"25\",\"chance\":\"54944\"},{\"id\":\"12433\",\"count\":1,\"chance\":\"10397\"},{\"id\":\"2671\",\"count\":1,\"chance\":\"9754\"},{\"id\":\"2381\",\"count\":1,\"chance\":\"6943\"},{\"id\":\"2378\",\"count\":1,\"chance\":\"5740\"},{\"id\":\"3965\",\"count\":1,\"chance\":\"4968\"},{\"id\":\"12435\",\"count\":1,\"chance\":\"4144\"},{\"id\":\"11113\",\"count\":1,\"chance\":\"2763\"},{\"id\":\"2464\",\"count\":1,\"chance\":\"982\"},{\"id\":\"2044\",\"count\":1,\"chance\":\"840\"}]'),
(1918, 0, 'Orc Leader', 640, 270, 450, 5, 0, '[\"Ulderek futgyr human!\"]', '[\"invisible\",\"fire\"]', 1, 1, 'blood', '[{\"id\":\"2667\",\"count\":1,\"chance\":\"30075\"},{\"id\":\"2148\",\"count\":\"35\",\"chance\":\"28207\"},{\"id\":\"12435\",\"count\":1,\"chance\":\"19721\"},{\"id\":\"2510\",\"count\":1,\"chance\":\"10140\"},{\"id\":\"2410\",\"count\":\"4\",\"chance\":\"10007\"},{\"id\":\"2789\",\"count\":1,\"chance\":\"9833\"},{\"id\":\"2207\",\"count\":1,\"chance\":\"3778\"},{\"id\":\"2397\",\"count\":1,\"chance\":\"2970\"},{\"id\":\"7378\",\"count\":1,\"chance\":\"2647\"},{\"id\":\"2478\",\"count\":1,\"chance\":\"2435\"},{\"id\":\"2419\",\"count\":1,\"chance\":\"2191\"},{\"id\":\"12436\",\"count\":1,\"chance\":\"2115\"},{\"id\":\"2463\",\"count\":1,\"chance\":\"1597\"},{\"id\":\"11113\",\"count\":1,\"chance\":\"1022\"},{\"id\":\"2413\",\"count\":1,\"chance\":\"748\"},{\"id\":\"7618\",\"count\":1,\"chance\":\"583\"},{\"id\":\"2647\",\"count\":1,\"chance\":\"396\"},{\"id\":\"2475\",\"count\":1,\"chance\":\"114\"}]'),
(1919, 0, 'Orc Marauder', 0, 205, 235, 1, 1, '[\"Grrrrrr\"]', '[\"invisible\"]', 0, 1, 'blood', '[{\"id\":2148,\"count\":\"90\",\"chance\":\"55000\"},{\"id\":2425,\"count\":1,\"chance\":\"1110\"},{\"id\":2428,\"count\":1,\"chance\":\"1320\"},{\"id\":2455,\"count\":1,\"chance\":\"440\"},{\"id\":2456,\"count\":1,\"chance\":\"5210\"},{\"id\":2666,\"count\":1,\"chance\":\"24600\"},{\"id\":8857,\"count\":1,\"chance\":\"70\"},{\"id\":11113,\"count\":1,\"chance\":\"3890\"},{\"id\":11324,\"count\":1,\"chance\":\"10090\"},{\"id\":12407,\"count\":1,\"chance\":\"4830\"},{\"id\":12435,\"count\":1,\"chance\":\"3800\"}]'),
(1920, 0, 'Orc Rider', 490, 110, 180, 20, 1, '[\"Grrrrrrr\",\"Orc arga Huummmak!\"]', '[]', 0, 1, 'blood', '[{\"id\":\"2148\",\"count\":\"81\",\"chance\":\"48261\"},{\"id\":\"2666\",\"count\":1,\"chance\":\"24151\"},{\"id\":\"2129\",\"count\":1,\"chance\":\"10159\"},{\"id\":\"12435\",\"count\":1,\"chance\":\"9984\"},{\"id\":\"11235\",\"count\":1,\"chance\":\"9718\"},{\"id\":\"2428\",\"count\":\"2\",\"chance\":\"6969\"},{\"id\":\"11113\",\"count\":1,\"chance\":\"2110\"},{\"id\":\"2050\",\"count\":1,\"chance\":\"1049\"},{\"id\":\"2513\",\"count\":1,\"chance\":\"1019\"},{\"id\":\"2425\",\"count\":1,\"chance\":\"1007\"},{\"id\":\"2483\",\"count\":1,\"chance\":\"615\"}]'),
(1921, 0, 'Orc Shaman', 0, 110, 115, 1, 0, '[\"Huumans stinkk!\",\"Grak brrretz gulu.\"]', '[\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2148\",\"count\":\"5\",\"chance\":\"89750\"},{\"id\":\"2686\",\"count\":\"2\",\"chance\":\"10877\"},{\"id\":\"12408\",\"count\":1,\"chance\":\"10161\"},{\"id\":\"2464\",\"count\":1,\"chance\":\"8658\"},{\"id\":\"12434\",\"count\":1,\"chance\":\"7513\"},{\"id\":\"2389\",\"count\":1,\"chance\":\"5170\"},{\"id\":\"12435\",\"count\":1,\"chance\":\"3792\"},{\"id\":\"11113\",\"count\":1,\"chance\":\"2182\"},{\"id\":\"2188\",\"count\":1,\"chance\":\"966\"},{\"id\":\"1958\",\"count\":1,\"chance\":\"465\"}]'),
(1922, 0, 'Orc Spearman', 310, 38, 105, 1, 0, '[\"Ugaar!\"]', '[]', 1, 1, 'blood', '[{\"id\":\"2666\",\"count\":1,\"chance\":\"30387\"},{\"id\":\"2148\",\"count\":\"11\",\"chance\":\"24846\"},{\"id\":\"2389\",\"count\":1,\"chance\":\"17907\"},{\"id\":\"2468\",\"count\":1,\"chance\":\"9210\"},{\"id\":\"2482\",\"count\":1,\"chance\":\"8239\"},{\"id\":\"2420\",\"count\":1,\"chance\":\"3027\"},{\"id\":\"12435\",\"count\":1,\"chance\":\"2013\"},{\"id\":\"11113\",\"count\":1,\"chance\":\"100\"}]'),
(1923, 0, 'Orc Warlord', 0, 670, 950, 7, 0, '[\"Ranat Ulderek!\",\"Orc buta bana!\",\"Ikem rambo zambo!\",\"Futchi maruk buta!\"]', '[\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"12409\",\"count\":1,\"chance\":\"25259\"},{\"id\":\"12435\",\"count\":1,\"chance\":\"20351\"},{\"id\":\"2148\",\"count\":\"45\",\"chance\":\"18998\"},{\"id\":\"2399\",\"count\":\"18\",\"chance\":\"14658\"},{\"id\":\"2667\",\"count\":\"2\",\"chance\":\"10484\"},{\"id\":\"11113\",\"count\":1,\"chance\":\"10033\"},{\"id\":\"2463\",\"count\":1,\"chance\":\"5526\"},{\"id\":\"2428\",\"count\":1,\"chance\":\"5426\"},{\"id\":\"12436\",\"count\":1,\"chance\":\"4958\"},{\"id\":\"3965\",\"count\":1,\"chance\":\"4825\"},{\"id\":\"2647\",\"count\":1,\"chance\":\"3907\"},{\"id\":\"2419\",\"count\":1,\"chance\":\"2972\"},{\"id\":\"2377\",\"count\":1,\"chance\":\"1953\"},{\"id\":\"2200\",\"count\":1,\"chance\":\"1853\"},{\"id\":\"2490\",\"count\":1,\"chance\":\"1285\"},{\"id\":\"2465\",\"count\":1,\"chance\":\"935\"},{\"id\":\"7618\",\"count\":1,\"chance\":\"384\"},{\"id\":\"2497\",\"count\":1,\"chance\":\"301\"},{\"id\":\"2434\",\"count\":1,\"chance\":\"234\"},{\"id\":\"7891\",\"count\":1,\"chance\":\"184\"},{\"id\":\"7395\",\"count\":1,\"chance\":\"134\"},{\"id\":\"2165\",\"count\":1,\"chance\":\"117\"}]'),
(1924, 0, 'Orc Warrior', 360, 50, 125, 1, 0, '[\"Grow truk grrrr.\",\"Trak grrrr brik.\",\"Alk!\"]', '[]', 1, 1, 'blood', '[{\"id\":\"2148\",\"count\":\"15\",\"chance\":\"64165\"},{\"id\":\"2666\",\"count\":1,\"chance\":\"15373\"},{\"id\":\"12409\",\"count\":1,\"chance\":\"9694\"},{\"id\":\"2464\",\"count\":1,\"chance\":\"7516\"},{\"id\":\"12435\",\"count\":1,\"chance\":\"3696\"},{\"id\":\"12436\",\"count\":1,\"chance\":\"1001\"},{\"id\":\"11113\",\"count\":1,\"chance\":\"681\"},{\"id\":\"2530\",\"count\":1,\"chance\":\"506\"},{\"id\":\"2411\",\"count\":1,\"chance\":\"41\"}]'),
(1925, 0, 'Orc', 300, 25, 70, 1, 0, '[\"Grak brrretz!\",\"Grow truk grrrrr.\",\"Prek tars, dekklep zurk.\"]', '[]', 1, 1, 'blood', '[{\"id\":\"2148\",\"count\":\"14\",\"chance\":\"84724\"},{\"id\":\"2666\",\"count\":1,\"chance\":\"9613\"},{\"id\":\"2484\",\"count\":1,\"chance\":\"8232\"},{\"id\":\"2526\",\"count\":1,\"chance\":\"6685\"},{\"id\":\"2385\",\"count\":1,\"chance\":\"5580\"},{\"id\":\"2386\",\"count\":1,\"chance\":\"5442\"},{\"id\":\"2482\",\"count\":1,\"chance\":\"2873\"},{\"id\":\"12435\",\"count\":1,\"chance\":\"359\"},{\"id\":\"11113\",\"count\":1,\"chance\":\"55\"}]'),
(1926, 0, 'Orchid Frog', 305, 20, 60, 1, 0, '[\"Ribbit!\",\"Ribbit! Ribbit!\"]', '[]', 0, 1, 'blood', '[{\"id\":2148,\"count\":\"10\",\"chance\":\"73230\"},{\"id\":3976,\"count\":1,\"chance\":\"8000\"}]'),
(1927, 0, 'Orcus the Cruel', 0, 280, 480, 5, 0, '[]', '[\"fire\",\"outfit\",\"drunk\",\"invisible\"]', 0, 0, 'blood', '[]'),
(1928, 0, 'Orewalker', 0, 4800, 7200, 80, 0, '[\"Sizzle!\",\"CLONK!\"]', '[\"earth\",\"paralyze\",\"invisible\"]', 0, 0, 'undead', '[{\"id\":\"2148\",\"count\":\"198\",\"chance\":\"100000\"},{\"id\":\"2152\",\"count\":\"10\",\"chance\":\"100000\"},{\"id\":\"11232\",\"count\":1,\"chance\":\"20887\"},{\"id\":\"18427\",\"count\":1,\"chance\":\"20088\"},{\"id\":\"5880\",\"count\":1,\"chance\":\"16134\"},{\"id\":\"7588\",\"count\":\"2\",\"chance\":\"15615\"},{\"id\":\"9970\",\"count\":\"3\",\"chance\":\"15136\"},{\"id\":\"7620\",\"count\":\"4\",\"chance\":\"15056\"},{\"id\":\"18435\",\"count\":\"5\",\"chance\":\"14936\"},{\"id\":\"7590\",\"count\":\"2\",\"chance\":\"14337\"},{\"id\":\"18429\",\"count\":1,\"chance\":\"14297\"},{\"id\":\"7589\",\"count\":\"2\",\"chance\":\"14257\"},{\"id\":\"18418\",\"count\":\"2\",\"chance\":\"13898\"},{\"id\":\"18419\",\"count\":1,\"chance\":\"13099\"},{\"id\":\"11227\",\"count\":1,\"chance\":\"12660\"},{\"id\":\"8473\",\"count\":\"2\",\"chance\":\"9265\"},{\"id\":\"18415\",\"count\":1,\"chance\":\"8107\"},{\"id\":\"2213\",\"count\":1,\"chance\":\"4273\"},{\"id\":\"7413\",\"count\":1,\"chance\":\"2756\"},{\"id\":\"7454\",\"count\":1,\"chance\":\"2716\"},{\"id\":\"5904\",\"count\":1,\"chance\":\"2716\"},{\"id\":\"2477\",\"count\":1,\"chance\":\"1877\"},{\"id\":\"18390\",\"count\":1,\"chance\":\"1398\"},{\"id\":\"2154\",\"count\":1,\"chance\":\"998\"},{\"id\":\"2491\",\"count\":1,\"chance\":\"958\"},{\"id\":\"2487\",\"count\":1,\"chance\":\"359\"},{\"id\":\"8878\",\"count\":1,\"chance\":\"359\"},{\"id\":\"18453\",\"count\":1,\"chance\":\"240\"}]'),
(1929, 0, 'Orshabaal', 0, 10000, 22500, 80, 1, '[\"PRAISED BE MY MASTERS, THE RUTHLESS SEVEN!\",\"YOU ARE DOOMED!\",\"ORSHABAAL IS BACK!\",\"Be prepared for the day my masters will come for you!\",\"SOULS FOR ORSHABAAL!\"]', '[\"fire\",\"earth\",\"lifedrain\",\"paralyze\",\"invisible\"]', 0, 0, 'fire', '[{\"id\":\"2152\",\"count\":\"72\",\"chance\":\"100000\"},{\"id\":\"6500\",\"count\":1,\"chance\":\"94444\"},{\"id\":\"6300\",\"count\":1,\"chance\":\"55556\"},{\"id\":\"5954\",\"count\":\"2\",\"chance\":\"50000\"},{\"id\":\"7590\",\"count\":1,\"chance\":\"33333\"},{\"id\":\"2146\",\"count\":\"8\",\"chance\":\"33333\"},{\"id\":\"2143\",\"count\":\"15\",\"chance\":\"33333\"},{\"id\":\"2144\",\"count\":\"15\",\"chance\":\"27778\"},{\"id\":\"2462\",\"count\":1,\"chance\":\"27778\"},{\"id\":\"7591\",\"count\":\"5\",\"chance\":\"27778\"},{\"id\":\"2214\",\"count\":1,\"chance\":\"27778\"},{\"id\":\"8473\",\"count\":1,\"chance\":\"27778\"},{\"id\":\"2158\",\"count\":1,\"chance\":\"22222\"},{\"id\":\"2520\",\"count\":1,\"chance\":\"22222\"},{\"id\":\"2393\",\"count\":1,\"chance\":\"22222\"},{\"id\":\"2178\",\"count\":1,\"chance\":\"22222\"},{\"id\":\"2145\",\"count\":\"5\",\"chance\":\"22222\"},{\"id\":\"2149\",\"count\":\"7\",\"chance\":\"22222\"},{\"id\":\"7368\",\"count\":\"42\",\"chance\":\"16667\"},{\"id\":\"2195\",\"count\":1,\"chance\":\"16667\"},{\"id\":\"2125\",\"count\":1,\"chance\":\"16667\"},{\"id\":\"2200\",\"count\":1,\"chance\":\"16667\"},{\"id\":\"1982\",\"count\":1,\"chance\":\"16667\"},{\"id\":\"2170\",\"count\":1,\"chance\":\"16667\"},{\"id\":\"2150\",\"count\":\"17\",\"chance\":\"16667\"},{\"id\":\"2174\",\"count\":1,\"chance\":\"16667\"},{\"id\":\"2151\",\"count\":\"3\",\"chance\":\"16667\"},{\"id\":\"2377\",\"count\":1,\"chance\":\"16667\"},{\"id\":\"2432\",\"count\":1,\"chance\":\"11111\"},{\"id\":\"2470\",\"count\":1,\"chance\":\"11111\"},{\"id\":\"2033\",\"count\":1,\"chance\":\"11111\"},{\"id\":\"8472\",\"count\":1,\"chance\":\"11111\"},{\"id\":\"2177\",\"count\":1,\"chance\":\"11111\"},{\"id\":\"2514\",\"count\":1,\"chance\":\"11111\"},{\"id\":\"2176\",\"count\":1,\"chance\":\"11111\"},{\"id\":\"2171\",\"count\":1,\"chance\":\"11111\"},{\"id\":\"2197\",\"count\":1,\"chance\":\"11111\"},{\"id\":\"2142\",\"count\":1,\"chance\":\"5556\"},{\"id\":\"2434\",\"count\":1,\"chance\":\"5556\"},{\"id\":\"9971\",\"count\":1,\"chance\":\"5556\"},{\"id\":\"2418\",\"count\":1,\"chance\":\"5556\"},{\"id\":\"2155\",\"count\":1,\"chance\":\"5556\"},{\"id\":\"2162\",\"count\":1,\"chance\":\"5556\"},{\"id\":\"2472\",\"count\":1,\"chance\":\"5556\"},{\"id\":\"2164\",\"count\":1,\"chance\":\"5556\"},{\"id\":\"7365\",\"count\":\"50\",\"chance\":\"5556\"},{\"id\":\"5808\",\"count\":1,\"chance\":\"5556\"},{\"id\":\"2402\",\"count\":1,\"chance\":\"5556\"},{\"id\":\"2112\",\"count\":1,\"chance\":\"5556\"},{\"id\":\"2421\",\"count\":1,\"chance\":\"5556\"},{\"id\":\"3955\",\"count\":1,\"chance\":\"5556\"}]'),
(1930, 0, 'Overcharged Energy Element', 0, 1300, 1700, 40, 0, '[\"BZZZZZZZZZZ\"]', '[\"ice\",\"energy\",\"fire\"]', 0, 0, 'energy', '[{\"id\":2148,\"count\":\"100\",\"chance\":\"50000\"},{\"id\":2148,\"count\":\"56\",\"chance\":\"50000\"},{\"id\":2150,\"count\":\"2\",\"chance\":\"10000\"},{\"id\":7439,\"count\":1,\"chance\":\"2173\"},{\"id\":7591,\"count\":1,\"chance\":\"10000\"},{\"id\":8303,\"count\":1,\"chance\":\"14285\"}]'),
(1931, 0, 'Panda', 300, 23, 80, 1, 0, '[\"Grrrr\",\"Groar\"]', '[\"earth\"]', 1, 1, 'blood', '[{\"id\":\"2666\",\"count\":1,\"chance\":\"69144\"},{\"id\":\"2671\",\"count\":1,\"chance\":\"36695\"},{\"id\":\"12401\",\"count\":1,\"chance\":\"9423\"}]'),
(1932, 0, 'Parasite', 0, 0, 550, 1, 0, '[]', '[\"paralyze\",\"invisible\",\"fire\"]', 0, 0, 'venom', '[]'),
(1933, 0, 'Parrot', 250, 0, 25, 50, 0, '[\"You advanshed, you advanshed!\",\"Neeewbiiieee!\",\"Screeech!\",\"Hunterrr ish PK!\",\"BR? PL? SWE?\",\"Hope you die and loooosh it!\",\"You powerrrrrrabuserrrrr!\",\"You are corrrrupt! Corrrrupt!\",\"Tarrrrp?\",\"Blesshhh my stake! Screeech!\",\"Leeave orrr hunted!!\",\"Shhtop whining! Rraaah!\",\"I\'m heeerrre! Screeeech!\"]', '[]', 1, 1, 'blood', '[]'),
(1934, 0, 'Party Skeleton', 0, 0, 40, 1, 0, '[]', '[\"death\"]', 0, 0, 'undead', '[]'),
(1935, 0, 'Penguin', 300, 1, 33, 1, 0, '[]', '[]', 1, 1, 'blood', '[{\"id\":\"2667\",\"count\":\"2\",\"chance\":\"7500\"},{\"id\":7158,\"count\":1,\"chance\":\"60\"},{\"id\":7159,\"count\":1,\"chance\":\"140\"}]'),
(1936, 0, 'Phantasm', 0, 1, 65, 60, 1, '[\"Oh my, you forgot to put your pants on!\",\"Weeheeheeheehee!\",\"Its nothing but a dream!\",\"Give in!\"]', '[\"paralyze\",\"invisible\",\"death\",\"lifedrain\",\"physical\"]', 0, 0, 'undead', '[]'),
(1937, 0, 'Pig', 255, 0, 25, 1, 0, '[\"Oink oink\",\"Oink\"]', '[]', 1, 1, 'blood', '[{\"id\":2666,\"count\":\"4\",\"chance\":\"65000\"},{\"id\":10610,\"count\":1,\"chance\":\"1200\"}]'),
(1938, 0, 'Pigeon', 0, 0, 30, 20, 0, '[\"Coooo! Cooo!\",\"Coo! Coooo! Coo! Cooo!\",\"Coo! Coo! Coooo!\"]', '[]', 0, 0, 'blood', '[]'),
(1939, 0, 'Pillar', 0, 0, 100, 1, 0, '[]', '[\"physical\",\"energy\",\"fire\",\"poison\",\"ice\",\"holy\",\"death\",\"lifedrain\",\"paralyze\",\"drown\",\"invisible\"]', 0, 0, 'undead', '[]'),
(1940, 0, 'Pirate Buccaneer', 595, 250, 425, 1, 0, '[\"Give up!\",\"Hiyaa\",\"Plundeeeeer!\"]', '[\"invisible\"]', 0, 1, 'blood', '[{\"id\":\"2050\",\"count\":1,\"chance\":\"10190\"},{\"id\":2148,\"count\":\"59\",\"chance\":\"67740\"},{\"id\":\"2238\",\"count\":1,\"chance\":\"9900\"},{\"id\":2385,\"count\":1,\"chance\":\"10100\"},{\"id\":2410,\"count\":\"5\",\"chance\":\"9000\"},{\"id\":2463,\"count\":1,\"chance\":\"1130\"},{\"id\":2513,\"count\":1,\"chance\":\"3850\"},{\"id\":\"5091\",\"count\":1,\"chance\":\"1000\"},{\"id\":5553,\"count\":1,\"chance\":\"120\"},{\"id\":\"5792\",\"count\":1,\"chance\":\"40\"},{\"id\":5926,\"count\":1,\"chance\":\"430\"},{\"id\":6095,\"count\":1,\"chance\":\"1200\"},{\"id\":6097,\"count\":1,\"chance\":\"450\"},{\"id\":6098,\"count\":1,\"chance\":\"420\"},{\"id\":6126,\"count\":1,\"chance\":\"510\"},{\"id\":7588,\"count\":1,\"chance\":\"670\"},{\"id\":11219,\"count\":1,\"chance\":\"9780\"}]'),
(1941, 0, 'Pirate Corsair', 775, 350, 675, 9, 0, '[\"Give up!\",\"Hiyaa!\",\"Plundeeeeer!\"]', '[\"invisible\"]', 0, 1, 'blood', '[{\"id\":\"2148\",\"count\":\"86\",\"chance\":\"55352\"},{\"id\":\"11219\",\"count\":1,\"chance\":\"10163\"},{\"id\":\"2385\",\"count\":1,\"chance\":\"9816\"},{\"id\":\"2399\",\"count\":\"12\",\"chance\":\"8104\"},{\"id\":\"2489\",\"count\":1,\"chance\":\"1874\"},{\"id\":\"2521\",\"count\":1,\"chance\":\"1105\"},{\"id\":\"6096\",\"count\":1,\"chance\":\"1094\"},{\"id\":\"5926\",\"count\":1,\"chance\":\"1029\"},{\"id\":\"7588\",\"count\":1,\"chance\":\"802\"},{\"id\":\"6097\",\"count\":1,\"chance\":\"574\"},{\"id\":\"6126\",\"count\":1,\"chance\":\"553\"},{\"id\":\"6098\",\"count\":1,\"chance\":\"488\"},{\"id\":\"5462\",\"count\":1,\"chance\":\"325\"},{\"id\":\"5813\",\"count\":1,\"chance\":\"119\"},{\"id\":\"5553\",\"count\":1,\"chance\":\"98\"},{\"id\":\"2114\",\"count\":1,\"chance\":\"87\"}]'),
(1942, 0, 'Pirate Cutthroat', 495, 175, 325, 1, 0, '[\"Give up!\",\"Hiyaa!\",\"Plundeeeeer!\"]', '[\"invisible\"]', 0, 1, 'blood', '[{\"id\":\"2148\",\"count\":\"50\",\"chance\":\"77548\"},{\"id\":\"11219\",\"count\":1,\"chance\":\"10074\"},{\"id\":\"2483\",\"count\":1,\"chance\":\"3070\"},{\"id\":\"2509\",\"count\":1,\"chance\":\"2884\"},{\"id\":\"5710\",\"count\":1,\"chance\":\"1960\"},{\"id\":\"14337\",\"count\":1,\"chance\":\"1092\"},{\"id\":\"5918\",\"count\":1,\"chance\":\"1019\"},{\"id\":\"5927\",\"count\":1,\"chance\":\"987\"},{\"id\":\"6097\",\"count\":1,\"chance\":\"534\"},{\"id\":\"6126\",\"count\":1,\"chance\":\"514\"},{\"id\":\"6098\",\"count\":1,\"chance\":\"468\"},{\"id\":\"5792\",\"count\":1,\"chance\":\"93\"},{\"id\":\"5553\",\"count\":1,\"chance\":\"89\"}]'),
(1943, 0, 'Pirate Ghost', 0, 250, 275, 1, 0, '[\"Yooh Ho Hooh Ho!\",\"Hell is waiting for You!\",\"It\'s alive!\",\"The curse! Aww the curse!\",\"You will not get my treasure!\"]', '[\"paralyze\",\"lifedrain\",\"physical\",\"death\",\"earth\"]', 0, 0, 'undead', '[{\"id\":\"1951\",\"count\":1,\"chance\":\"910\"},{\"id\":2148,\"count\":\"67\",\"chance\":\"48000\"},{\"id\":2165,\"count\":1,\"chance\":\"650\"},{\"id\":2383,\"count\":1,\"chance\":\"130\"},{\"id\":2655,\"count\":1,\"chance\":\"130\"},{\"id\":10601,\"count\":1,\"chance\":\"4300\"}]'),
(1944, 0, 'Pirate Marauder', 490, 125, 210, 1, 0, '[\"Plundeeeeer!\",\"Give up!\",\"Hiyaa!\"]', '[\"invisible\"]', 0, 1, 'blood', '[{\"id\":\"2050\",\"count\":1,\"chance\":\"9880\"},{\"id\":2148,\"count\":\"40\",\"chance\":\"77670\"},{\"id\":2389,\"count\":\"2\",\"chance\":\"5140\"},{\"id\":2464,\"count\":1,\"chance\":\"3000\"},{\"id\":2510,\"count\":1,\"chance\":\"5000\"},{\"id\":\"5091\",\"count\":1,\"chance\":\"910\"},{\"id\":5553,\"count\":1,\"chance\":\"110\"},{\"id\":\"5792\",\"count\":1,\"chance\":\"90\"},{\"id\":5917,\"count\":1,\"chance\":\"880\"},{\"id\":5927,\"count\":1,\"chance\":\"430\"},{\"id\":5928,\"count\":1,\"chance\":\"80\"},{\"id\":6097,\"count\":1,\"chance\":\"520\"},{\"id\":6098,\"count\":1,\"chance\":\"530\"},{\"id\":6126,\"count\":1,\"chance\":\"520\"},{\"id\":11219,\"count\":1,\"chance\":\"9720\"}]'),
(1945, 0, 'Pirate Skeleton', 0, 85, 190, 1, 0, '[]', '[\"death\"]', 0, 0, 'undead', '[{\"id\":2148,\"count\":\"25\",\"chance\":\"48000\"},{\"id\":\"2229\",\"count\":1,\"chance\":\"4460\"},{\"id\":\"2230\",\"count\":1,\"chance\":\"4250\"},{\"id\":\"2231\",\"count\":1,\"chance\":\"5140\"},{\"id\":\"2376\",\"count\":1,\"chance\":\"550\"},{\"id\":2406,\"count\":1,\"chance\":\"1003\"},{\"id\":2449,\"count\":1,\"chance\":\"960\"},{\"id\":10559,\"count\":1,\"chance\":\"4730\"}]'),
(1946, 0, 'Plagirath', 0, 50000, 290000, 50, 1, '[\"BOOOOOOOMMM!!!!!\",\"WITHER AND DIE!\",\"DEATH AND DECAY!\",\"I CAN SENSE YOUR BODIES ROOTING!\"]', '[\"earth\",\"paralyze\",\"invisible\"]', 0, 0, 'venom', '[{\"id\":\"25172\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"11306\",\"count\":1,\"chance\":\"3000\"},{\"id\":\"18411\",\"count\":1,\"chance\":\"1820\"},{\"id\":\"18419\",\"count\":\"6\",\"chance\":\"23000\"},{\"id\":\"18420\",\"count\":\"6\",\"chance\":\"23000\"},{\"id\":\"18421\",\"count\":\"6\",\"chance\":\"23000\"},{\"id\":\"2143\",\"count\":\"8\",\"chance\":\"12000\"},{\"id\":\"2146\",\"count\":\"9\",\"chance\":\"12000\"},{\"id\":\"2148\",\"count\":\"100\",\"chance\":\"49000\"},{\"id\":\"2148\",\"count\":\"100\",\"chance\":\"49000\"},{\"id\":\"2150\",\"count\":\"5\",\"chance\":\"10000\"},{\"id\":\"2152\",\"count\":\"58\",\"chance\":\"8000\"},{\"id\":\"25383\",\"count\":1,\"chance\":\"800\"},{\"id\":\"25415\",\"count\":1,\"chance\":\"500\"},{\"id\":\"25522\",\"count\":1,\"chance\":\"800\"},{\"id\":\"25523\",\"count\":1,\"chance\":\"800\"},{\"id\":\"6500\",\"count\":1,\"chance\":\"11000\"},{\"id\":\"7386\",\"count\":1,\"chance\":\"5000\"},{\"id\":\"7632\",\"count\":\"5\",\"chance\":\"14000\"},{\"id\":\"7633\",\"count\":\"5\",\"chance\":\"14000\"},{\"id\":\"7887\",\"count\":1,\"chance\":\"5000\"},{\"id\":\"8473\",\"count\":\"15\",\"chance\":\"23000\"},{\"id\":\"8901\",\"count\":1,\"chance\":\"4000\"},{\"id\":\"9970\",\"count\":\"8\",\"chance\":\"10000\"}]'),
(1947, 0, 'Plaguesmith', 0, 4500, 8250, 10, 1, '[\"You are looking a bit feverish!\",\"You don\'t look that good!\",\"Hachoo!\",\"Cough Cough\"]', '[\"earth\",\"paralyze\",\"invisible\"]', 0, 0, 'venom', '[{\"id\":2127,\"count\":1,\"chance\":\"341\"},{\"id\":2134,\"count\":1,\"chance\":\"2000\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"50000\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"40000\"},{\"id\":2148,\"count\":\"65\",\"chance\":\"50000\"},{\"id\":2150,\"count\":\"3\",\"chance\":\"5000\"},{\"id\":2152,\"count\":\"2\",\"chance\":\"7142\"},{\"id\":2208,\"count\":1,\"chance\":\"4347\"},{\"id\":2209,\"count\":1,\"chance\":\"4761\"},{\"id\":2225,\"count\":1,\"chance\":\"20000\"},{\"id\":2235,\"count\":1,\"chance\":\"50000\"},{\"id\":\"2237\",\"count\":1,\"chance\":\"60000\"},{\"id\":2377,\"count\":1,\"chance\":\"20000\"},{\"id\":2391,\"count\":1,\"chance\":\"2127\"},{\"id\":2394,\"count\":1,\"chance\":\"29000\"},{\"id\":2417,\"count\":1,\"chance\":\"20000\"},{\"id\":2444,\"count\":1,\"chance\":\"952\"},{\"id\":2477,\"count\":1,\"chance\":\"6250\"},{\"id\":2509,\"count\":1,\"chance\":\"20000\"},{\"id\":2645,\"count\":1,\"chance\":\"1123\"},{\"id\":\"2079\",\"count\":1,\"chance\":\"100\"},{\"id\":5887,\"count\":1,\"chance\":\"1234\"},{\"id\":5888,\"count\":1,\"chance\":\"1010\"},{\"id\":5889,\"count\":1,\"chance\":\"1030\"},{\"id\":5944,\"count\":1,\"chance\":\"11111\"},{\"id\":6500,\"count\":1,\"chance\":\"9033\"},{\"id\":7365,\"count\":\"4\",\"chance\":\"7692\"},{\"id\":7591,\"count\":1,\"chance\":\"10000\"},{\"id\":\"9810\",\"count\":1,\"chance\":\"540\"}]'),
(1948, 0, 'Plaguethrower', 0, 0, 1, 1, 0, '[]', '[\"physical\",\"energy\",\"fire\",\"earth\",\"drown\",\"ice\",\"holy\",\"death\",\"lifedrain\",\"manadrain\",\"paralyze\",\"drunk\",\"outfit\",\"invisible\"]', 0, 0, 'undead', '[]'),
(1949, 0, 'Poacher', 530, 70, 90, 1, 0, '[\"You will not live to tell anyone!\",\"You are my game today!\",\"Look what has stepped into my trap!\"]', '[]', 0, 1, 'blood', '[{\"id\":\"2544\",\"count\":\"18\",\"chance\":\"47154\"},{\"id\":\"2461\",\"count\":1,\"chance\":\"30758\"},{\"id\":\"2649\",\"count\":1,\"chance\":\"27912\"},{\"id\":\"2456\",\"count\":1,\"chance\":\"14901\"},{\"id\":\"2690\",\"count\":\"2\",\"chance\":\"11049\"},{\"id\":\"2050\",\"count\":1,\"chance\":\"5082\"},{\"id\":\"2545\",\"count\":\"3\",\"chance\":\"2521\"},{\"id\":\"2578\",\"count\":1,\"chance\":\"1006\"}]'),
(1950, 0, 'Poison Spider', 270, 22, 26, 1, 0, '[]', '[\"earth\"]', 1, 0, 'venom', '[{\"id\":2148,\"count\":\"4\",\"chance\":\"75000\"},{\"id\":12441,\"count\":1,\"chance\":\"1140\"}]'),
(1951, 0, 'Polar Bear', 315, 28, 85, 1, 0, '[\"GROARRR!\"]', '[]', 1, 1, 'blood', '[{\"id\":\"2666\",\"count\":1,\"chance\":\"50363\"},{\"id\":\"2671\",\"count\":1,\"chance\":\"50166\"},{\"id\":\"10567\",\"count\":1,\"chance\":\"1013\"}]'),
(1952, 0, 'Poodle', 220, 0, 20, 1, 0, '[\"Wuff wuff\"]', '[]', 1, 1, 'blood', '[]'),
(1953, 0, 'Priestess', 0, 420, 390, 1, 0, '[\"Your energy is mine.\",\"Now your life is come to the end, hahahaha!\",\"Throw the soul on the altar!\"]', '[\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2802\",\"count\":1,\"chance\":\"13494\"},{\"id\":\"2760\",\"count\":1,\"chance\":\"12093\"},{\"id\":\"11220\",\"count\":1,\"chance\":\"9795\"},{\"id\":\"2674\",\"count\":\"2\",\"chance\":\"7403\"},{\"id\":\"2803\",\"count\":1,\"chance\":\"6183\"},{\"id\":\"10562\",\"count\":1,\"chance\":\"5036\"},{\"id\":\"2791\",\"count\":1,\"chance\":\"3343\"},{\"id\":\"10556\",\"count\":1,\"chance\":\"1796\"},{\"id\":\"2423\",\"count\":1,\"chance\":\"1484\"},{\"id\":\"2070\",\"count\":1,\"chance\":\"1425\"},{\"id\":\"2192\",\"count\":1,\"chance\":\"1132\"},{\"id\":\"2183\",\"count\":1,\"chance\":\"1069\"},{\"id\":\"1962\",\"count\":1,\"chance\":\"932\"},{\"id\":\"7620\",\"count\":1,\"chance\":\"932\"},{\"id\":\"2151\",\"count\":1,\"chance\":\"717\"},{\"id\":\"2125\",\"count\":1,\"chance\":\"615\"},{\"id\":\"2529\",\"count\":1,\"chance\":\"210\"},{\"id\":\"2114\",\"count\":1,\"chance\":\"68\"}]'),
(1954, 0, 'Primitive', 0, 45, 200, 40, 0, '[\"We don\'t need a future!\",\"I\'ll rook you all!\",\"They thought they\'d beaten us!\",\"You are history!\",\"There can only be one world!\",\"Valor who?\",\"Die noob!\",\"There are no dragons!\",\"I\'ll quit forever! Again...\",\"You all are noobs!\",\"Beware of the cyclops!\",\"Just had a disconnect.\",\"Magic is only good for girls!\",\"We\'ll be back!\"]', '[\"energy\",\"fire\",\"drunk\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":2148,\"count\":\"10\",\"chance\":\"12500\"},{\"id\":2385,\"count\":1,\"chance\":\"10250\"},{\"id\":2386,\"count\":1,\"chance\":\"12250\"},{\"id\":2482,\"count\":1,\"chance\":\"9500\"},{\"id\":\"2484\",\"count\":1,\"chance\":\"7000\"},{\"id\":\"2526\",\"count\":1,\"chance\":\"1200\"},{\"id\":\"6570\",\"count\":1,\"chance\":\"500\"},{\"id\":\"6571\",\"count\":1,\"chance\":\"500\"}]'),
(1955, 0, 'Prince Drazzak', 0, 210000, 330000, 130, 0, '[\"EVEN WITH ALL THAT TIME IN THE PRISON THAT WEAKENED ME, YOU ARE NO MATCH TO ME!\",\"DIE!\",\"SORCERERS MUST DIE!\",\"DRUIDS MUST DIE!\",\"PALADINS MUST DIE!\",\"KNIGHTS MUST DIE!\",\"GET OVER HERE!\",\"CRUSH THEM ALL!\",\"VARIPHOR WILL RULE!\",\"THEY WILL ALL PAY!\",\"NOT EVEN AEONS OF IMPRISONMENT WILL STOP ME!\",\"They used you fools to escape and they left ME behind!!??\"]', '[\"paralyze\",\"outfit\",\"drunk\",\"lifedrain\",\"invisible\"]', 0, 0, 'fire', '[{\"id\":\"22396\",\"count\":\"5\",\"chance\":\"100000\"},{\"id\":\"22598\",\"count\":\"3\",\"chance\":\"1000\"},{\"id\":\"6500\",\"count\":\"2\",\"chance\":\"100000\"},{\"id\":\"5954\",\"count\":1,\"chance\":\"50000\"},{\"id\":\"2152\",\"count\":\"50\",\"chance\":\"100000\"},{\"id\":\"8473\",\"count\":\"100\",\"chance\":\"100000\"},{\"id\":\"8472\",\"count\":\"100\",\"chance\":\"100000\"},{\"id\":\"7590\",\"count\":\"100\",\"chance\":\"100000\"},{\"id\":\"22613\",\"count\":1,\"chance\":\"25000\"},{\"id\":\"22608\",\"count\":1,\"chance\":\"2500\"},{\"id\":\"22611\",\"count\":1,\"chance\":\"25000\"},{\"id\":\"22612\",\"count\":1,\"chance\":\"25000\"},{\"id\":\"5741\",\"count\":1,\"chance\":\"2500\"},{\"id\":\"7417\",\"count\":1,\"chance\":\"2500\"},{\"id\":\"22610\",\"count\":1,\"chance\":\"7000\"},{\"id\":\"7418\",\"count\":1,\"chance\":\"1000\"},{\"id\":\"7893\",\"count\":1,\"chance\":\"1000\"},{\"id\":\"7632\",\"count\":1,\"chance\":\"5000\"},{\"id\":\"7633\",\"count\":1,\"chance\":\"5000\"}]'),
(1956, 0, 'Pythius The Rotten', 0, 7000, 9500, 65, 0, '[\"YOU\'LL NEVER GET MY TREASURE!\",\"MINIONS, MEET YOUR NEW BROTHER!\",\"YOU WILL REGRET THAT YOU ARE BORN!\",\"YOU MADE A HUGE WASTE!\",\"I SENSE LIFE\"]', '[\"death\",\"earth\",\"energy\",\"paralyze\",\"invisible\"]', 0, 0, 'undead', '[]'),
(1957, 0, 'Quara Constrictor Scout', 670, 200, 450, 1, 0, '[\"Gaaahhh!\",\"Gluh! Gluh!\",\"Tssss!\",\"Boohaa!\"]', '[\"lifedrain\",\"fire\",\"paralyze\",\"ice\"]', 0, 0, 'blood', '[{\"id\":\"2148\",\"count\":\"50\",\"chance\":\"99953\"},{\"id\":\"12443\",\"count\":1,\"chance\":\"15123\"},{\"id\":\"2670\",\"count\":1,\"chance\":\"10015\"},{\"id\":\"2397\",\"count\":1,\"chance\":\"8090\"},{\"id\":\"2465\",\"count\":1,\"chance\":\"5076\"},{\"id\":\"2150\",\"count\":1,\"chance\":\"4015\"},{\"id\":\"5895\",\"count\":1,\"chance\":\"507\"}]'),
(1958, 0, 'Quara Constrictor', 670, 250, 450, 80, 0, '[\"Gaaahhh!\",\"Gluh! Gluh!\",\"Tssss!\",\"Boohaa!\"]', '[\"lifedrain\",\"paralyze\",\"drown\",\"fire\",\"ice\"]', 0, 1, 'blood', '[{\"id\":\"2148\",\"count\":\"100\",\"chance\":\"87662\"},{\"id\":\"12443\",\"count\":1,\"chance\":\"14598\"},{\"id\":\"2397\",\"count\":1,\"chance\":\"6951\"},{\"id\":\"2670\",\"count\":1,\"chance\":\"5169\"},{\"id\":\"2465\",\"count\":1,\"chance\":\"4804\"},{\"id\":\"2150\",\"count\":1,\"chance\":\"3042\"},{\"id\":\"5895\",\"count\":1,\"chance\":\"484\"}]'),
(1959, 0, 'Quara Hydromancer Scout', 0, 800, 1100, 1, 0, '[\"Qua hah tsh!\",\"Teech tsha tshul!\",\"Quara tsha Fach!\",\"Tssssha Quara!\",\"Blubber.\",\"Blup.\"]', '[\"ice\",\"fire\",\"lifedrain\",\"paralyze\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2148\",\"count\":\"140\",\"chance\":\"89950\"},{\"id\":\"2667\",\"count\":\"3\",\"chance\":\"20252\"},{\"id\":\"12444\",\"count\":1,\"chance\":\"12007\"},{\"id\":\"2670\",\"count\":1,\"chance\":\"9993\"},{\"id\":\"2149\",\"count\":\"2\",\"chance\":\"4980\"},{\"id\":\"2143\",\"count\":1,\"chance\":\"2880\"},{\"id\":\"2144\",\"count\":1,\"chance\":\"2614\"},{\"id\":\"5895\",\"count\":1,\"chance\":\"2076\"},{\"id\":\"2425\",\"count\":1,\"chance\":\"1528\"},{\"id\":\"2214\",\"count\":1,\"chance\":\"971\"},{\"id\":\"2189\",\"count\":1,\"chance\":\"890\"},{\"id\":\"2476\",\"count\":1,\"chance\":\"514\"}]'),
(1960, 0, 'Quara Hydromancer', 0, 800, 1100, 135, 0, '[\"Qua hah tsh!\",\"Teech tsha tshul!\",\"Quara tsha Fach!\",\"Tssssha Quara!\",\"Blubber.\",\"Blup.\"]', '[\"lifedrain\",\"paralyze\",\"invisible\",\"drown\",\"fire\",\"ice\"]', 0, 0, 'blood', '[{\"id\":\"2148\",\"count\":\"110\",\"chance\":\"90418\"},{\"id\":\"12444\",\"count\":1,\"chance\":\"15606\"},{\"id\":\"2143\",\"count\":1,\"chance\":\"5083\"},{\"id\":\"2149\",\"count\":\"2\",\"chance\":\"4960\"},{\"id\":\"2670\",\"count\":1,\"chance\":\"4716\"},{\"id\":\"2144\",\"count\":1,\"chance\":\"3125\"},{\"id\":\"7590\",\"count\":1,\"chance\":\"2861\"},{\"id\":\"5895\",\"count\":1,\"chance\":\"1459\"},{\"id\":\"2214\",\"count\":1,\"chance\":\"1233\"},{\"id\":\"2189\",\"count\":1,\"chance\":\"979\"},{\"id\":\"2476\",\"count\":1,\"chance\":\"226\"}]'),
(1961, 0, 'Quara Mantassin Scout', 480, 100, 220, 1, 0, '[\"Zuerk Pachak!\",\"Shrrrr\"]', '[\"ice\",\"fire\",\"invisible\",\"lifedrain\"]', 0, 1, 'blood', '[{\"id\":\"2148\",\"count\":\"30\",\"chance\":\"93987\"},{\"id\":\"12445\",\"count\":1,\"chance\":\"7916\"},{\"id\":\"2464\",\"count\":1,\"chance\":\"4990\"},{\"id\":\"2146\",\"count\":1,\"chance\":\"996\"},{\"id\":\"2229\",\"count\":1,\"chance\":\"979\"},{\"id\":\"2377\",\"count\":1,\"chance\":\"802\"},{\"id\":\"2165\",\"count\":1,\"chance\":\"711\"},{\"id\":\"5895\",\"count\":1,\"chance\":\"365\"}]'),
(1962, 0, 'Quara Mantassin', 480, 400, 800, 185, 1, '[\"Zuerk Pachak!\",\"Shrrrr\"]', '[\"lifedrain\",\"drown\",\"fire\",\"ice\"]', 0, 1, 'blood', '[{\"id\":\"2148\",\"count\":\"130\",\"chance\":\"79873\"},{\"id\":\"12445\",\"count\":1,\"chance\":\"12746\"},{\"id\":\"2670\",\"count\":1,\"chance\":\"5121\"},{\"id\":\"2381\",\"count\":1,\"chance\":\"4984\"},{\"id\":\"2165\",\"count\":1,\"chance\":\"1100\"},{\"id\":\"2146\",\"count\":1,\"chance\":\"1092\"},{\"id\":\"2654\",\"count\":1,\"chance\":\"1055\"},{\"id\":\"2377\",\"count\":1,\"chance\":\"1017\"},{\"id\":\"5895\",\"count\":1,\"chance\":\"622\"},{\"id\":\"2479\",\"count\":1,\"chance\":\"91\"},{\"id\":\"2656\",\"count\":1,\"chance\":\"83\"}]'),
(1963, 0, 'Quara Pincher Scout', 0, 600, 775, 1, 0, '[\"Clank clank!\",\"Clap!\",\"Crrrk! Crrrk!\"]', '[\"ice\",\"fire\",\"lifedrain\",\"paralyze\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2148\",\"count\":\"129\",\"chance\":\"89910\"},{\"id\":\"12446\",\"count\":1,\"chance\":\"9912\"},{\"id\":\"2463\",\"count\":1,\"chance\":\"4965\"},{\"id\":\"2147\",\"count\":\"2\",\"chance\":\"3836\"},{\"id\":\"2381\",\"count\":1,\"chance\":\"2056\"},{\"id\":\"5895\",\"count\":1,\"chance\":\"808\"},{\"id\":\"2177\",\"count\":1,\"chance\":\"781\"}]'),
(1964, 0, 'Quara Pincher', 0, 1200, 1800, 88, 0, '[\"Clank clank!\",\"Clap!\",\"Crrrk! Crrrk!\"]', '[\"lifedrain\",\"invisible\",\"drown\",\"fire\",\"ice\"]', 0, 0, 'blood', '[{\"id\":\"2148\",\"count\":\"150\",\"chance\":\"100000\"},{\"id\":\"2152\",\"count\":1,\"chance\":\"40655\"},{\"id\":\"12446\",\"count\":1,\"chance\":\"14711\"},{\"id\":\"7591\",\"count\":1,\"chance\":\"10371\"},{\"id\":\"2147\",\"count\":\"2\",\"chance\":\"7539\"},{\"id\":\"2381\",\"count\":1,\"chance\":\"6979\"},{\"id\":\"2670\",\"count\":1,\"chance\":\"4919\"},{\"id\":\"5895\",\"count\":1,\"chance\":\"1616\"},{\"id\":\"2475\",\"count\":1,\"chance\":\"1481\"},{\"id\":\"2487\",\"count\":1,\"chance\":\"270\"},{\"id\":\"7897\",\"count\":1,\"chance\":\"116\"},{\"id\":\"13305\",\"count\":1,\"chance\":\"45\"}]'),
(1965, 0, 'Quara Predator Scout', 0, 400, 890, 1, 0, '[\"Gnarrr!\",\"Tcharrr!\",\"Rrrah!\",\"Rraaar!\"]', '[\"ice\",\"fire\",\"lifedrain\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2148\",\"count\":\"132\",\"chance\":\"98959\"},{\"id\":\"12447\",\"count\":1,\"chance\":\"10105\"},{\"id\":\"2483\",\"count\":1,\"chance\":\"8959\"},{\"id\":\"2387\",\"count\":1,\"chance\":\"5785\"},{\"id\":\"2670\",\"count\":1,\"chance\":\"5045\"},{\"id\":\"2145\",\"count\":\"2\",\"chance\":\"5020\"},{\"id\":\"2377\",\"count\":1,\"chance\":\"3011\"},{\"id\":\"5895\",\"count\":1,\"chance\":\"1067\"},{\"id\":\"8911\",\"count\":1,\"chance\":\"947\"}]'),
(1966, 0, 'Quara Predator', 0, 1600, 2200, 115, 1, '[\"Rrrah!\",\"Rraaar!\"]', '[\"lifedrain\",\"invisible\",\"drown\",\"fire\",\"ice\"]', 0, 0, 'blood', '[{\"id\":\"2148\",\"count\":\"154\",\"chance\":\"78107\"},{\"id\":\"12447\",\"count\":1,\"chance\":\"9797\"},{\"id\":\"7378\",\"count\":\"7\",\"chance\":\"9260\"},{\"id\":\"2145\",\"count\":\"2\",\"chance\":\"5322\"},{\"id\":\"2670\",\"count\":1,\"chance\":\"4985\"},{\"id\":\"2387\",\"count\":1,\"chance\":\"3005\"},{\"id\":\"5895\",\"count\":1,\"chance\":\"1922\"},{\"id\":\"7591\",\"count\":1,\"chance\":\"1034\"},{\"id\":\"7383\",\"count\":1,\"chance\":\"657\"},{\"id\":\"7368\",\"count\":1,\"chance\":\"528\"},{\"id\":\"7897\",\"count\":1,\"chance\":\"462\"},{\"id\":\"5741\",\"count\":1,\"chance\":\"382\"},{\"id\":\"13305\",\"count\":1,\"chance\":\"22\"}]'),
(1967, 0, 'Rabbit', 220, 0, 15, 1, 0, '[]', '[]', 1, 1, 'blood', '[{\"id\":2666,\"count\":\"2\",\"chance\":\"82000\"},{\"id\":\"2684\",\"count\":\"2\",\"chance\":\"10000\"}]');
INSERT INTO `myaac_monsters` (`id`, `hidden`, `name`, `mana`, `exp`, `health`, `speed_lvl`, `use_haste`, `voices`, `immunities`, `summonable`, `convinceable`, `race`, `loot`) VALUES
(1968, 0, 'Raging Mage', 0, 3250, 3500, 1, 0, '[\"Behold the all permeating powers I draw from this gate!!\",\"ENERGY!!\"]', '[\"energy\",\"outfit\",\"fire\",\"drunk\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2148\",\"count\":\"250\",\"chance\":\"97633\"},{\"id\":\"2152\",\"count\":\"12\",\"chance\":\"78107\"},{\"id\":\"5911\",\"count\":1,\"chance\":\"30769\"},{\"id\":\"7591\",\"count\":\"5\",\"chance\":\"27219\"},{\"id\":\"7590\",\"count\":\"5\",\"chance\":\"23077\"},{\"id\":\"2178\",\"count\":1,\"chance\":\"10651\"},{\"id\":\"7443\",\"count\":\"2\",\"chance\":\"6509\"},{\"id\":\"8871\",\"count\":1,\"chance\":\"4734\"},{\"id\":\"2165\",\"count\":1,\"chance\":\"4734\"},{\"id\":\"12410\",\"count\":1,\"chance\":\"4142\"},{\"id\":\"2792\",\"count\":\"4\",\"chance\":\"3550\"},{\"id\":\"2124\",\"count\":1,\"chance\":\"2367\"},{\"id\":\"2146\",\"count\":\"5\",\"chance\":\"2367\"},{\"id\":\"7368\",\"count\":\"10\",\"chance\":\"2367\"},{\"id\":\"2123\",\"count\":1,\"chance\":\"1775\"},{\"id\":\"13940\",\"count\":1,\"chance\":\"1183\"},{\"id\":\"2114\",\"count\":1,\"chance\":\"1183\"},{\"id\":\"9958\",\"count\":1,\"chance\":\"1183\"},{\"id\":\"2195\",\"count\":1,\"chance\":\"592\"},{\"id\":\"9980\",\"count\":1,\"chance\":\"592\"},{\"id\":\"5741\",\"count\":1,\"chance\":\"592\"},{\"id\":\"8902\",\"count\":1,\"chance\":\"592\"}]'),
(1969, 0, 'Rahemos', 0, 3100, 3700, 50, 0, '[\"It\'s a kind of magic.\",\"Abrah Kadabrah!\",\"Nothing hidden in my wrappings.\",\"It\'s not a trick, it\'s Rahemos.\",\"Meet my friend from hell!\",\"I will make you believe in magic.\"]', '[\"ice\",\"earth\",\"death\",\"paralyze\",\"invisible\"]', 0, 0, 'undead', '[{\"id\":2348,\"count\":1,\"chance\":\"100000\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"30000\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"30000\"},{\"id\":2148,\"count\":\"42\",\"chance\":\"30000\"},{\"id\":7590,\"count\":1,\"chance\":\"9000\"},{\"id\":2150,\"count\":\"3\",\"chance\":\"8000\"},{\"id\":2214,\"count\":1,\"chance\":\"4000\"},{\"id\":2662,\"count\":1,\"chance\":\"1600\"},{\"id\":2153,\"count\":1,\"chance\":\"1100\"},{\"id\":2176,\"count\":1,\"chance\":\"300\"},{\"id\":2447,\"count\":1,\"chance\":\"200\"},{\"id\":2184,\"count\":1,\"chance\":\"150\"},{\"id\":11207,\"count\":1,\"chance\":\"150\"}]'),
(1970, 0, 'Rat', 200, 5, 20, 1, 0, '[\"Meep!\"]', '[]', 1, 1, 'blood', '[{\"id\":2148,\"count\":\"4\",\"chance\":\"100000\"},{\"id\":\"2696\",\"count\":1,\"chance\":\"39410\"}]'),
(1971, 0, 'Renegade Knight', 0, 1200, 1450, 1, 0, '[\"I\'ll teach you a lesson!\",\"Feel my steel!\",\"Take this!\",\"Your abilities are no match for mine!\",\"Let\'s see how good you are!\",\"A challenge at last!\"]', '[\"paralyze\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"12406\",\"count\":1,\"chance\":\"1655\"},{\"id\":\"2148\",\"count\":\"100\",\"chance\":\"100000\"},{\"id\":\"2152\",\"count\":\"2\",\"chance\":\"25165\"},{\"id\":\"12466\",\"count\":1,\"chance\":\"4635\"},{\"id\":\"2666\",\"count\":1,\"chance\":\"7615\"},{\"id\":\"2377\",\"count\":1,\"chance\":\"5960\"},{\"id\":\"2391\",\"count\":1,\"chance\":\"993\"},{\"id\":\"5911\",\"count\":1,\"chance\":\"2317\"},{\"id\":\"2487\",\"count\":1,\"chance\":\"662\"},{\"id\":\"2491\",\"count\":1,\"chance\":\"331\"},{\"id\":\"7591\",\"count\":1,\"chance\":\"7284\"},{\"id\":\"2147\",\"count\":1,\"chance\":\"6622\"},{\"id\":\"2114\",\"count\":1,\"chance\":\"331\"},{\"id\":\"2488\",\"count\":1,\"chance\":\"331\"}]'),
(1972, 0, 'Renegade Orc', 0, 270, 450, 1, 0, '[\"Harga puchak muhmak!\"]', '[\"invisible\",\"fire\"]', 0, 0, 'blood', '[{\"id\":\"2667\",\"count\":1,\"chance\":\"30000\"},{\"id\":\"2148\",\"count\":\"35\",\"chance\":\"28000\"},{\"id\":\"12435\",\"count\":1,\"chance\":\"19000\"},{\"id\":\"2510\",\"count\":1,\"chance\":\"10000\"},{\"id\":\"2410\",\"count\":\"4\",\"chance\":\"9850\"},{\"id\":\"2789\",\"count\":1,\"chance\":\"9650\"},{\"id\":\"2207\",\"count\":1,\"chance\":\"3920\"},{\"id\":\"2397\",\"count\":1,\"chance\":\"2800\"},{\"id\":\"7378\",\"count\":1,\"chance\":\"2600\"},{\"id\":\"2419\",\"count\":1,\"chance\":\"2100\"},{\"id\":\"11113\",\"count\":1,\"chance\":\"890\"},{\"id\":\"2413\",\"count\":1,\"chance\":\"830\"},{\"id\":\"7618\",\"count\":1,\"chance\":\"550\"},{\"id\":\"2647\",\"count\":1,\"chance\":\"420\"},{\"id\":\"2475\",\"count\":1,\"chance\":\"160\"}]'),
(1973, 0, 'Retching Horror', 0, 4100, 5300, 70, 0, '[\"Wait for us, little maggot...\",\"We will devour you...\",\"My little beetles, go forth, eat, feast!\"]', '[\"fire\",\"paralyze\",\"invisible\"]', 0, 0, 'fire', '[{\"id\":\"2152\",\"count\":\"9\",\"chance\":\"82759\"},{\"id\":\"2148\",\"count\":\"100\",\"chance\":\"81103\"},{\"id\":\"22539\",\"count\":1,\"chance\":\"13379\"},{\"id\":\"2789\",\"count\":\"2\",\"chance\":\"11310\"},{\"id\":\"7590\",\"count\":1,\"chance\":\"11310\"},{\"id\":\"22541\",\"count\":1,\"chance\":\"11034\"},{\"id\":\"7591\",\"count\":1,\"chance\":\"10759\"},{\"id\":\"22363\",\"count\":1,\"chance\":\"4000\"},{\"id\":\"3962\",\"count\":1,\"chance\":\"3172\"},{\"id\":\"7386\",\"count\":1,\"chance\":\"2207\"},{\"id\":\"7452\",\"count\":1,\"chance\":\"2207\"},{\"id\":\"2392\",\"count\":1,\"chance\":\"1793\"},{\"id\":\"8910\",\"count\":1,\"chance\":\"1241\"},{\"id\":\"7421\",\"count\":1,\"chance\":\"1103\"},{\"id\":\"8920\",\"count\":1,\"chance\":\"1103\"},{\"id\":\"2519\",\"count\":1,\"chance\":\"690\"},{\"id\":\"7412\",\"count\":1,\"chance\":\"414\"},{\"id\":\"2528\",\"count\":1,\"chance\":\"414\"},{\"id\":\"22396\",\"count\":1,\"chance\":\"276\"}]'),
(1974, 0, 'Rift Brood', 0, 1600, 2950, 40, 0, '[]', '[\"ice\",\"fire\",\"invisible\"]', 0, 0, 'energy', '[]'),
(1975, 0, 'Rift Lord', 0, 0, 5, 1, 0, '[]', '[]', 0, 0, 'fire', '[]'),
(1976, 0, 'Rift Phantom', 0, 0, 100, 1, 0, '[]', '[\"physical\",\"death\",\"earth\",\"drown\",\"lifedrain\",\"paralyze\"]', 0, 0, 'undead', '[]'),
(1977, 0, 'Rift Scythe', 0, 2000, 3600, 75, 0, '[]', '[\"lifedrain\",\"paralyze\",\"invisible\"]', 0, 0, 'undead', '[]'),
(1978, 0, 'Rift Worm', 0, 1195, 2800, 1, 0, '[]', '[\"invisible\"]', 0, 0, 'blood', '[]'),
(1979, 0, 'Roaring Lion', 0, 800, 1000, 1, 0, '[\"Groarrrr! Rwarrrr!\",\"Growl!\"]', '[\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2148\",\"count\":\"115\",\"chance\":\"100000\"},{\"id\":\"2666\",\"count\":1,\"chance\":\"25326\"},{\"id\":\"2671\",\"count\":1,\"chance\":\"24811\"},{\"id\":\"10608\",\"count\":1,\"chance\":\"20073\"},{\"id\":\"2152\",\"count\":1,\"chance\":\"9973\"},{\"id\":\"2146\",\"count\":1,\"chance\":\"7149\"},{\"id\":\"9970\",\"count\":1,\"chance\":\"6926\"},{\"id\":\"2147\",\"count\":1,\"chance\":\"6842\"},{\"id\":\"2150\",\"count\":1,\"chance\":\"6700\"},{\"id\":\"2193\",\"count\":1,\"chance\":\"2857\"},{\"id\":\"2164\",\"count\":1,\"chance\":\"731\"},{\"id\":\"2491\",\"count\":1,\"chance\":\"581\"}]'),
(1980, 0, 'Roaring Water Elemental', 0, 1300, 1750, 85, 0, '[]', '[\"fire\",\"lifedrain\",\"paralyze\",\"invisible\",\"drown\"]', 0, 0, 'undead', '[{\"id\":2146,\"count\":\"2\",\"chance\":\"4125\"},{\"id\":2148,\"count\":\"90\",\"chance\":\"27000\"},{\"id\":2148,\"count\":\"87\",\"chance\":\"27000\"},{\"id\":7839,\"count\":\"2\",\"chance\":\"1000\"},{\"id\":8302,\"count\":1,\"chance\":\"9000\"},{\"id\":8911,\"count\":1,\"chance\":\"750\"}]'),
(1981, 0, 'Robby the Reckless', 0, 110, 155, 1, 0, '[]', '[]', 0, 0, 'blood', '[{\"id\":14903,\"count\":1,\"chance\":\"100000\"},{\"id\":2152,\"count\":\"93\",\"chance\":\"100000\"}]'),
(1982, 0, 'Rocko', 590, 3400, 10000, 1, 0, '[]', '[\"paralyze\",\"earth\",\"death\",\"invisible\"]', 0, 0, 'blood', '[]'),
(1983, 0, 'Rocky', 0, 190, 390, 1, 0, '[\"Another little gladiator!\",\"Come into my embrace.\"]', '[\"energy\",\"earth\",\"outfit\",\"drunk\",\"invisible\"]', 0, 0, 'undead', '[]'),
(1984, 0, 'Ron the Ripper', 0, 500, 1500, 10, 0, '[]', '[]', 0, 0, 'blood', '[{\"id\":2148,\"count\":\"50\",\"chance\":\"100000\"},{\"id\":2320,\"count\":\"2\",\"chance\":\"100000\"},{\"id\":2379,\"count\":1,\"chance\":\"8500\"},{\"id\":2387,\"count\":1,\"chance\":\"1500\"},{\"id\":2463,\"count\":1,\"chance\":\"4000\"},{\"id\":2476,\"count\":1,\"chance\":\"1200\"},{\"id\":6101,\"count\":1,\"chance\":\"100000\"}]'),
(1985, 0, 'Rorc', 0, 105, 260, 1, 1, '[\"Kroaaah!!\"]', '[]', 0, 0, 'blood', '[{\"id\":2129,\"count\":1,\"chance\":\"7410\"},{\"id\":2148,\"count\":\"25\",\"chance\":\"73640\"},{\"id\":2425,\"count\":1,\"chance\":\"930\"},{\"id\":2428,\"count\":1,\"chance\":\"2040\"},{\"id\":2510,\"count\":1,\"chance\":\"6700\"},{\"id\":21310,\"count\":1,\"chance\":\"12520\"},{\"id\":21313,\"count\":1,\"chance\":\"790\"},{\"id\":21314,\"count\":1,\"chance\":\"12670\"}]'),
(1986, 0, 'Rot Elemental', 0, 750, 850, 5, 1, '[\"*glibb*\",\"*splib*\"]', '[\"paralyze\",\"earth\",\"lifedrain\",\"invisible\"]', 0, 0, 'venom', '[{\"id\":\"2148\",\"count\":\"80\",\"chance\":\"100000\"},{\"id\":\"2152\",\"count\":1,\"chance\":\"10390\"},{\"id\":\"7588\",\"count\":1,\"chance\":\"10310\"},{\"id\":\"7589\",\"count\":1,\"chance\":\"9990\"},{\"id\":\"23553\",\"count\":1,\"chance\":\"14320\"},{\"id\":\"2168\",\"count\":1,\"chance\":\"1630\"},{\"id\":\"2146\",\"count\":1,\"chance\":\"5110\"},{\"id\":\"9970\",\"count\":\"2\",\"chance\":\"4140\"},{\"id\":\"2149\",\"count\":\"2\",\"chance\":\"5340\"},{\"id\":\"2155\",\"count\":1,\"chance\":\"80\"},{\"id\":\"23554\",\"count\":1,\"chance\":\"130\"},{\"id\":\"23551\",\"count\":1,\"chance\":\"60\"},{\"id\":\"23529\",\"count\":1,\"chance\":\"5660\"}]'),
(1987, 0, 'Rottie The Rotworm', 0, 40, 65, 1, 0, '[]', '[]', 0, 0, 'blood', '[{\"id\":\"10609\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2148\",\"count\":\"18\",\"chance\":\"84211\"},{\"id\":\"2398\",\"count\":1,\"chance\":\"63158\"},{\"id\":\"3976\",\"count\":\"5\",\"chance\":\"47368\"},{\"id\":\"2376\",\"count\":1,\"chance\":\"26316\"},{\"id\":\"2671\",\"count\":1,\"chance\":\"21053\"},{\"id\":\"2530\",\"count\":1,\"chance\":\"15789\"},{\"id\":\"2666\",\"count\":1,\"chance\":\"15789\"},{\"id\":\"2480\",\"count\":1,\"chance\":\"10526\"},{\"id\":\"2412\",\"count\":1,\"chance\":\"5263\"}]'),
(1988, 0, 'Rotworm Queen', 0, 75, 105, 1, 0, '[]', '[]', 0, 0, 'blood', '[{\"id\":2148,\"count\":\"47\",\"chance\":\"100000\"},{\"id\":3976,\"count\":\"45\",\"chance\":\"20000\"},{\"id\":8971,\"count\":1,\"chance\":\"3333\"}]'),
(1989, 0, 'Rukor Zad', 0, 380, 380, 105, 0, '[\"I can kill a man in a thousand ways. And that`s only with a spoon!\",\"You shouldn\'t have come here!\",\"Haiiii!\"]', '[\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2148\",\"count\":\"50\",\"chance\":\"93210\"},{\"id\":\"2050\",\"count\":\"2\",\"chance\":\"35000\"},{\"id\":\"2403\",\"count\":1,\"chance\":\"19750\"},{\"id\":\"2399\",\"count\":\"14\",\"chance\":\"9210\"},{\"id\":\"7366\",\"count\":\"7\",\"chance\":\"6200\"},{\"id\":\"2404\",\"count\":1,\"chance\":\"5000\"},{\"id\":\"2457\",\"count\":1,\"chance\":\"4190\"},{\"id\":\"2510\",\"count\":1,\"chance\":\"2910\"},{\"id\":\"2513\",\"count\":1,\"chance\":\"2560\"},{\"id\":\"2509\",\"count\":1,\"chance\":\"1940\"},{\"id\":\"3968\",\"count\":1,\"chance\":\"1480\"},{\"id\":\"3969\",\"count\":1,\"chance\":\"1240\"},{\"id\":\"2145\",\"count\":1,\"chance\":\"1220\"}]'),
(1990, 0, 'Rotworm', 305, 40, 65, 1, 0, '[]', '[]', 0, 1, 'blood', '[{\"id\":\"2148\",\"count\":\"17\",\"chance\":\"71834\"},{\"id\":\"2671\",\"count\":1,\"chance\":\"20104\"},{\"id\":\"2666\",\"count\":1,\"chance\":\"20006\"},{\"id\":\"10609\",\"count\":1,\"chance\":\"10004\"},{\"id\":\"2398\",\"count\":1,\"chance\":\"4441\"},{\"id\":\"3976\",\"count\":\"3\",\"chance\":\"3057\"},{\"id\":\"2376\",\"count\":1,\"chance\":\"3047\"}]'),
(1991, 0, 'Rustheap Golem', 0, 2300, 2800, 15, 1, '[\"*clatter*\",\"*krrk*\",\"*frzzp*\"]', '[\"invisible\",\"paralyze\",\"lifedrain\"]', 0, 0, 'energy', '[{\"id\":\"8309\",\"count\":1,\"chance\":\"1950\"},{\"id\":\"9930\",\"count\":1,\"chance\":\"5860\"},{\"id\":\"23567\",\"count\":1,\"chance\":\"14980\"},{\"id\":\"2148\",\"count\":\"100\",\"chance\":\"100000\"},{\"id\":\"2148\",\"count\":\"100\",\"chance\":\"80000\"},{\"id\":\"2148\",\"count\":\"90\",\"chance\":\"60000\"},{\"id\":\"5880\",\"count\":1,\"chance\":\"330\"},{\"id\":\"24124\",\"count\":1,\"chance\":\"1950\"},{\"id\":\"2152\",\"count\":\"3\",\"chance\":\"58310\"},{\"id\":\"2143\",\"count\":1,\"chance\":\"1300\"},{\"id\":\"2144\",\"count\":1,\"chance\":\"1630\"},{\"id\":\"7588\",\"count\":\"2\",\"chance\":\"10100\"},{\"id\":\"7589\",\"count\":\"2\",\"chance\":\"7170\"},{\"id\":\"2391\",\"count\":1,\"chance\":\"3580\"},{\"id\":\"7452\",\"count\":1,\"chance\":\"330\"},{\"id\":\"23542\",\"count\":1,\"chance\":\"330\"},{\"id\":\"23541\",\"count\":1,\"chance\":\"2930\"},{\"id\":\"9810\",\"count\":1,\"chance\":\"5860\"},{\"id\":\"9813\",\"count\":1,\"chance\":\"4230\"}]'),
(1992, 0, 'Sacred Spider', 485, 330, 550, 1, 0, '[]', '[\"invisible\"]', 0, 0, 'venom', '[{\"id\":2148,\"count\":\"100\",\"chance\":\"40000\"},{\"id\":2148,\"count\":\"19\",\"chance\":\"50000\"},{\"id\":2159,\"count\":\"4\",\"chance\":\"7142\"},{\"id\":2463,\"count\":1,\"chance\":\"4761\"},{\"id\":8859,\"count\":1,\"chance\":\"25000\"},{\"id\":9971,\"count\":1,\"chance\":\"95\"}]'),
(1993, 0, 'Salamander', 0, 25, 70, 1, 0, '[\"Chrrch!\",\"Chhh!\"]', '[]', 0, 0, 'blood', '[{\"id\":\"2148\",\"count\":\"15\",\"chance\":\"71933\"},{\"id\":\"19737\",\"count\":1,\"chance\":\"34928\"},{\"id\":\"2544\",\"count\":\"3\",\"chance\":\"7985\"},{\"id\":\"2120\",\"count\":1,\"chance\":\"5077\"},{\"id\":\"2398\",\"count\":1,\"chance\":\"3978\"},{\"id\":\"2460\",\"count\":1,\"chance\":\"1976\"},{\"id\":\"7618\",\"count\":1,\"chance\":\"1480\"},{\"id\":\"2456\",\"count\":1,\"chance\":\"739\"},{\"id\":\"2419\",\"count\":1,\"chance\":\"487\"}]'),
(1994, 0, 'Sandcrawler', 250, 20, 30, 1, 0, '[\"Chrk chrk!\"]', '[]', 1, 1, 'venom', '[{\"id\":2148,\"count\":\"6\",\"chance\":\"33333\"},{\"id\":11373,\"count\":1,\"chance\":\"2173\"}]'),
(1995, 0, 'Sandstone Scorpion', 0, 680, 900, 5, 0, '[\"*rattle*\",\"*tak tak*\",\"*tak tak tak*\"]', '[\"earth\",\"invisible\"]', 0, 0, 'undead', '[{\"id\":2148,\"count\":\"100\",\"chance\":\"45000\"},{\"id\":2148,\"count\":\"28\",\"chance\":\"45000\"},{\"id\":2149,\"count\":\"2\",\"chance\":\"9900\"},{\"id\":2152,\"count\":\"2\",\"chance\":\"11111\"},{\"id\":2439,\"count\":1,\"chance\":\"6250\"},{\"id\":2457,\"count\":1,\"chance\":\"5000\"},{\"id\":2529,\"count\":1,\"chance\":\"1724\"},{\"id\":13535,\"count\":1,\"chance\":\"280\"}]'),
(1996, 0, 'Scarab', 395, 120, 320, 1, 1, '[]', '[\"earth\",\"paralyze\"]', 1, 0, 'venom', '[{\"id\":2148,\"count\":\"52\",\"chance\":\"87000\"},{\"id\":2666,\"count\":\"2\",\"chance\":\"40000\"},{\"id\":10558,\"count\":1,\"chance\":\"5000\"},{\"id\":2159,\"count\":1,\"chance\":\"1100\"},{\"id\":2150,\"count\":1,\"chance\":\"540\"},{\"id\":2149,\"count\":1,\"chance\":\"400\"},{\"id\":2439,\"count\":1,\"chance\":\"300\"}]'),
(1997, 0, 'Scorn of the Emperor', 0, 4600, 7800, 95, 0, '[]', '[\"death\",\"earth\"]', 0, 0, 'undead', '[]'),
(1998, 0, 'Scorpion', 310, 45, 45, 1, 0, '[]', '[\"earth\"]', 1, 0, 'venom', '[{\"id\":10568,\"count\":1,\"chance\":\"5000\"}]'),
(1999, 0, 'Sea Serpent', 390, 2300, 1950, 65, 1, '[\"CHHHRRRR\",\"HISSSS\"]', '[\"ice\",\"paralyze\",\"invisible\",\"drown\"]', 0, 0, 'blood', '[{\"id\":2146,\"count\":\"3\",\"chance\":\"5600\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"38000\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"30000\"},{\"id\":2148,\"count\":\"36\",\"chance\":\"30000\"},{\"id\":2152,\"count\":\"3\",\"chance\":\"25000\"},{\"id\":2165,\"count\":1,\"chance\":\"400\"},{\"id\":2214,\"count\":1,\"chance\":\"1100\"},{\"id\":2409,\"count\":1,\"chance\":\"4200\"},{\"id\":2647,\"count\":1,\"chance\":\"7150\"},{\"id\":2672,\"count\":\"2\",\"chance\":\"60000\"},{\"id\":7588,\"count\":1,\"chance\":\"5500\"},{\"id\":7589,\"count\":1,\"chance\":\"3850\"},{\"id\":7590,\"count\":1,\"chance\":\"920\"},{\"id\":7888,\"count\":1,\"chance\":\"880\"},{\"id\":7896,\"count\":1,\"chance\":\"430\"},{\"id\":8870,\"count\":1,\"chance\":\"2900\"},{\"id\":8871,\"count\":1,\"chance\":\"370\"},{\"id\":8878,\"count\":1,\"chance\":\"90\"},{\"id\":8884,\"count\":1,\"chance\":\"110\"},{\"id\":8911,\"count\":1,\"chance\":\"930\"},{\"id\":10583,\"count\":1,\"chance\":\"10200\"}]'),
(2000, 0, 'Seagull', 250, 0, 25, 20, 0, '[]', '[]', 1, 0, 'blood', '[]'),
(2001, 0, 'Serpent Spawn', 0, 3050, 3000, 7, 1, '[\"Sssssouls for the one\",\"HISSSS\",\"Tsssse one will risssse again\",\"I bring your deathhh, mortalssss\"]', '[\"earth\",\"paralyze\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2148\",\"count\":\"245\",\"chance\":\"97236\"},{\"id\":\"2796\",\"count\":1,\"chance\":\"18300\"},{\"id\":\"10611\",\"count\":1,\"chance\":\"14967\"},{\"id\":\"2146\",\"count\":1,\"chance\":\"12132\"},{\"id\":\"2547\",\"count\":1,\"chance\":\"6107\"},{\"id\":\"2168\",\"count\":1,\"chance\":\"6058\"},{\"id\":\"2167\",\"count\":1,\"chance\":\"5968\"},{\"id\":\"2033\",\"count\":1,\"chance\":\"2958\"},{\"id\":\"7386\",\"count\":1,\"chance\":\"2030\"},{\"id\":\"7590\",\"count\":1,\"chance\":\"2014\"},{\"id\":\"2182\",\"count\":1,\"chance\":\"986\"},{\"id\":\"11230\",\"count\":1,\"chance\":\"941\"},{\"id\":\"2528\",\"count\":1,\"chance\":\"855\"},{\"id\":\"7456\",\"count\":1,\"chance\":\"807\"},{\"id\":\"2177\",\"count\":1,\"chance\":\"789\"},{\"id\":\"2479\",\"count\":1,\"chance\":\"633\"},{\"id\":\"5956\",\"count\":1,\"chance\":\"569\"},{\"id\":\"2475\",\"count\":1,\"chance\":\"564\"},{\"id\":\"2487\",\"count\":1,\"chance\":\"504\"},{\"id\":\"3971\",\"count\":1,\"chance\":\"184\"},{\"id\":\"2498\",\"count\":1,\"chance\":\"124\"},{\"id\":\"8902\",\"count\":1,\"chance\":\"98\"},{\"id\":\"8880\",\"count\":1,\"chance\":\"84\"}]'),
(2002, 0, 'Shaburak Demon', 0, 900, 1500, 1, 0, '[\"GREEN IS MEAN!\",\"WE RULE!\",\"POWER TO THE SHABURAK!\",\"DEATH TO THE ASKARAK!\"]', '[\"fire\",\"invisible\"]', 0, 0, 'fire', '[{\"id\":2114,\"count\":1,\"chance\":\"1030\"},{\"id\":2147,\"count\":\"5\",\"chance\":\"4761\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"50000\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"50000\"},{\"id\":2148,\"count\":\"50\",\"chance\":\"50000\"},{\"id\":2167,\"count\":1,\"chance\":\"1052\"},{\"id\":2187,\"count\":1,\"chance\":\"564\"},{\"id\":2789,\"count\":1,\"chance\":\"3846\"},{\"id\":5904,\"count\":1,\"chance\":\"81\"},{\"id\":7378,\"count\":\"6\",\"chance\":\"10000\"},{\"id\":7443,\"count\":1,\"chance\":\"628\"},{\"id\":7588,\"count\":1,\"chance\":\"4761\"},{\"id\":7589,\"count\":1,\"chance\":\"5000\"},{\"id\":7894,\"count\":1,\"chance\":\"155\"}]'),
(2003, 0, 'Shaburak Lord', 0, 1200, 2100, 5, 0, '[\"GREEN IS MEAN!\",\"WE RULE!\",\"POWER TO THE SHABURAK!\",\"DEATH TO THE ASKARAK!\",\"ONLY WE ARE TRUE DEMONS!\"]', '[\"fire\",\"invisible\"]', 0, 0, 'fire', '[{\"id\":2147,\"count\":\"5\",\"chance\":\"6120\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"50000\"},{\"id\":2148,\"count\":\"78\",\"chance\":\"50000\"},{\"id\":2152,\"count\":\"2\",\"chance\":\"33333\"},{\"id\":2167,\"count\":1,\"chance\":\"1652\"},{\"id\":2187,\"count\":1,\"chance\":\"800\"},{\"id\":2645,\"count\":1,\"chance\":\"160\"},{\"id\":2789,\"count\":1,\"chance\":\"5346\"},{\"id\":5904,\"count\":1,\"chance\":\"620\"},{\"id\":7443,\"count\":1,\"chance\":\"400\"},{\"id\":7588,\"count\":1,\"chance\":\"7000\"},{\"id\":7589,\"count\":1,\"chance\":\"7000\"},{\"id\":7899,\"count\":1,\"chance\":\"100\"}]'),
(2004, 0, 'Shaburak Prince', 0, 1700, 2600, 10, 0, '[\"GREEN IS MEAN!\",\"WE RULE!\",\"POWER TO THE SHABURAK!\",\"DEATH TO THE ASKARAK!\",\"ONLY WE ARE TRUE DEMONS!\"]', '[\"fire\"]', 0, 0, 'fire', '[{\"id\":2147,\"count\":\"5\",\"chance\":\"12500\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"50000\"},{\"id\":2148,\"count\":\"78\",\"chance\":\"50000\"},{\"id\":2152,\"count\":\"4\",\"chance\":\"33333\"},{\"id\":2165,\"count\":1,\"chance\":\"5000\"},{\"id\":2187,\"count\":1,\"chance\":\"892\"},{\"id\":2645,\"count\":1,\"chance\":\"89\"},{\"id\":2789,\"count\":1,\"chance\":\"4545\"},{\"id\":5904,\"count\":1,\"chance\":\"534\"},{\"id\":7412,\"count\":1,\"chance\":\"357\"},{\"id\":7443,\"count\":1,\"chance\":\"714\"},{\"id\":7588,\"count\":1,\"chance\":\"14285\"},{\"id\":7589,\"count\":1,\"chance\":\"14285\"},{\"id\":7899,\"count\":1,\"chance\":\"714\"},{\"id\":13530,\"count\":1,\"chance\":\"178\"}]'),
(2005, 0, 'Shadow Hound', 0, 600, 555, 70, 0, '[\"Grrrr!\"]', '[\"death\",\"earth\",\"paralyze\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":10531,\"count\":1,\"chance\":\"8333\"}]'),
(2006, 0, 'Shadow Pupil', 0, 410, 450, 1, 0, '[\"When I\'m finished with you, you\'ll be a shadow of your former self.\"]', '[\"invisible\",\"earth\",\"drown\"]', 0, 0, 'blood', '[{\"id\":2148,\"count\":\"64\",\"chance\":\"100000\"},{\"id\":2195,\"count\":1,\"chance\":\"60\"},{\"id\":2423,\"count\":1,\"chance\":\"290\"},{\"id\":2663,\"count\":1,\"chance\":\"580\"},{\"id\":2789,\"count\":1,\"chance\":\"5170\"},{\"id\":7589,\"count\":1,\"chance\":\"470\"},{\"id\":8900,\"count\":1,\"chance\":\"290\"},{\"id\":11237,\"count\":1,\"chance\":\"6920\"},{\"id\":21243,\"count\":1,\"chance\":\"15000\"},{\"id\":21246,\"count\":1,\"chance\":\"9130\"},{\"id\":21247,\"count\":1,\"chance\":\"4300\"}]'),
(2007, 0, 'Shardhead', 0, 650, 800, 1, 0, '[\"Chrr.\"]', '[\"holy\",\"death\",\"fire\",\"ice\",\"invisible\",\"paralyze\",\"drunk\"]', 0, 0, 'undead', '[{\"id\":2148,\"count\":\"87\",\"chance\":\"99700\"},{\"id\":7290,\"count\":1,\"chance\":\"40000\"},{\"id\":\"7441\",\"count\":1,\"chance\":\"80000\"},{\"id\":7449,\"count\":1,\"chance\":\"30000\"},{\"id\":7588,\"count\":1,\"chance\":\"100000\"},{\"id\":10578,\"count\":1,\"chance\":\"40000\"}]'),
(2008, 0, 'Shark', 0, 700, 1200, 5, 0, '[\"Rarr chomp chomp!\"]', '[\"invisible\",\"drown\"]', 0, 0, 'blood', '[{\"id\":2146,\"count\":1,\"chance\":\"1222\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"50000\"},{\"id\":2148,\"count\":\"38\",\"chance\":\"40000\"},{\"id\":\"2667\",\"count\":\"4\",\"chance\":\"25000\"},{\"id\":5895,\"count\":1,\"chance\":\"161\"},{\"id\":\"7632\",\"count\":1,\"chance\":\"550\"},{\"id\":13870,\"count\":1,\"chance\":\"1270\"},{\"id\":15430,\"count\":1,\"chance\":\"9090\"}]'),
(2009, 0, 'Sharptooth', 0, 1600, 2500, 35, 1, '[\"Gnarrr!\",\"Tcharrr!\",\"Rrrah!\",\"Rraaar!\"]', '[\"ice\",\"fire\",\"lifedrain\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":2226,\"count\":1,\"chance\":\"50000\"}]'),
(2010, 0, 'Sheep', 250, 0, 20, 1, 0, '[\"Maeh\"]', '[]', 1, 1, 'blood', '[{\"id\":2666,\"count\":\"4\",\"chance\":\"70000\"},{\"id\":11236,\"count\":1,\"chance\":\"1000\"}]'),
(2011, 0, 'Shiversleep', 0, 1900, 4600, 25, 0, '[\"Knorrrr!\"]', '[\"earth\",\"energy\",\"lifedrain\",\"paralyze\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":2143,\"count\":1,\"chance\":\"866\"},{\"id\":2144,\"count\":1,\"chance\":\"866\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"30000\"},{\"id\":2152,\"count\":\"10\",\"chance\":\"33333\"},{\"id\":2393,\"count\":1,\"chance\":\"422\"},{\"id\":2477,\"count\":1,\"chance\":\"444\"},{\"id\":\"2487\",\"count\":1,\"chance\":\"632\"},{\"id\":5880,\"count\":\"2\",\"chance\":\"2195\"},{\"id\":5904,\"count\":1,\"chance\":\"632\"},{\"id\":7590,\"count\":\"4\",\"chance\":\"3100\"},{\"id\":8473,\"count\":\"2\",\"chance\":\"2195\"},{\"id\":9980,\"count\":1,\"chance\":\"1066\"},{\"id\":11227,\"count\":1,\"chance\":\"1032\"},{\"id\":18390,\"count\":1,\"chance\":\"1766\"},{\"id\":18412,\"count\":1,\"chance\":\"1066\"},{\"id\":18435,\"count\":\"8\",\"chance\":\"366\"},{\"id\":18450,\"count\":1,\"chance\":\"603\"},{\"id\":18453,\"count\":1,\"chance\":\"603\"}]'),
(2012, 0, 'Shock Head', 0, 2300, 4200, 15, 0, '[\"<brrzz>\",\"Thun... Thun... THUNDER!\"]', '[\"earth\",\"fire\",\"paralyze\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":2146,\"count\":1,\"chance\":\"5000\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"43000\"},{\"id\":2148,\"count\":\"87\",\"chance\":\"50000\"},{\"id\":2498,\"count\":1,\"chance\":\"270\"},{\"id\":22539,\"count\":1,\"chance\":\"10000\"}]'),
(2013, 0, 'Shredderthrower', 0, 0, 1, 1, 0, '[]', '[\"physical\",\"energy\",\"fire\",\"earth\",\"drown\",\"ice\",\"holy\",\"death\",\"lifedrain\",\"manadrain\",\"paralyze\",\"drunk\",\"outfit\",\"invisible\"]', 0, 0, 'undead', '[]'),
(2014, 0, 'Sibang', 0, 105, 225, 1, 1, '[\"Eeeeek! Eeeeek\",\"Huh! Huh! Huh!\",\"Ahhuuaaa!\"]', '[\"outfit\",\"drunk\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2148\",\"count\":\"35\",\"chance\":\"88771\"},{\"id\":\"2676\",\"count\":\"12\",\"chance\":\"30452\"},{\"id\":\"1294\",\"count\":\"3\",\"chance\":\"29967\"},{\"id\":\"2675\",\"count\":\"5\",\"chance\":\"19971\"},{\"id\":\"12467\",\"count\":1,\"chance\":\"4948\"},{\"id\":\"2678\",\"count\":\"3\",\"chance\":\"1968\"},{\"id\":\"2682\",\"count\":1,\"chance\":\"1001\"},{\"id\":\"5883\",\"count\":1,\"chance\":\"988\"}]'),
(2015, 0, 'Sight Of Surrender', 0, 17000, 28000, 60, 1, '[\"BOW LOW!\",\"FEEL THE TRUE MEANING OF VANQUISH!\",\"HAHAHAHA DO YOU WANT TO AMUSE YOUR MASTER?\",\"NOW YOU WILL SURRENDER!\"]', '[\"paralyze\",\"invisible\"]', 0, 0, 'undead', '[{\"id\":\"22518\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2152\",\"count\":\"20\",\"chance\":\"100000\"},{\"id\":\"22517\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"8473\",\"count\":\"5\",\"chance\":\"76987\"},{\"id\":\"7590\",\"count\":\"5\",\"chance\":\"76407\"},{\"id\":\"8472\",\"count\":\"5\",\"chance\":\"75442\"},{\"id\":\"18418\",\"count\":\"5\",\"chance\":\"35099\"},{\"id\":\"18416\",\"count\":\"5\",\"chance\":\"32754\"},{\"id\":\"18417\",\"count\":\"5\",\"chance\":\"32147\"},{\"id\":\"18413\",\"count\":\"3\",\"chance\":\"25855\"},{\"id\":\"18414\",\"count\":\"3\",\"chance\":\"24558\"},{\"id\":\"18415\",\"count\":\"3\",\"chance\":\"23841\"},{\"id\":\"2197\",\"count\":1,\"chance\":\"14790\"},{\"id\":\"2445\",\"count\":1,\"chance\":\"5215\"},{\"id\":\"2164\",\"count\":1,\"chance\":\"5188\"},{\"id\":\"22396\",\"count\":\"2\",\"chance\":\"2953\"},{\"id\":\"2645\",\"count\":1,\"chance\":\"2511\"},{\"id\":\"2472\",\"count\":1,\"chance\":\"1821\"},{\"id\":\"7421\",\"count\":1,\"chance\":\"1325\"},{\"id\":\"7422\",\"count\":1,\"chance\":\"1269\"},{\"id\":\"2528\",\"count\":1,\"chance\":\"1269\"},{\"id\":\"2444\",\"count\":1,\"chance\":\"883\"},{\"id\":\"2497\",\"count\":1,\"chance\":\"800\"},{\"id\":\"2488\",\"count\":1,\"chance\":\"552\"},{\"id\":\"22542\",\"count\":1,\"chance\":\"386\"}]'),
(2016, 0, 'Silencer', 0, 5100, 5400, 125, 1, '[\"Prrrroooaaaah!!! PRROAAAH!!\",\"PRRRROOOOOAAAAAHHHH!!!\",\"HUUUSSSSSSSSH!!\",\"Hussssssh!!\"]', '[\"earth\",\"paralyze\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2152\",\"count\":\"8\",\"chance\":\"99919\"},{\"id\":\"2148\",\"count\":\"100\",\"chance\":\"99717\"},{\"id\":\"22534\",\"count\":1,\"chance\":\"16350\"},{\"id\":\"22535\",\"count\":1,\"chance\":\"9528\"},{\"id\":\"7368\",\"count\":\"10\",\"chance\":\"8357\"},{\"id\":\"7454\",\"count\":1,\"chance\":\"2584\"},{\"id\":\"7413\",\"count\":1,\"chance\":\"1978\"},{\"id\":\"7407\",\"count\":1,\"chance\":\"1938\"},{\"id\":\"2165\",\"count\":1,\"chance\":\"1534\"},{\"id\":\"2521\",\"count\":1,\"chance\":\"1453\"},{\"id\":\"7387\",\"count\":1,\"chance\":\"1373\"},{\"id\":\"7451\",\"count\":1,\"chance\":\"1090\"},{\"id\":\"7886\",\"count\":1,\"chance\":\"929\"},{\"id\":\"7885\",\"count\":1,\"chance\":\"888\"},{\"id\":\"22396\",\"count\":1,\"chance\":\"686\"},{\"id\":\"2195\",\"count\":1,\"chance\":\"444\"}]'),
(2017, 0, 'Silver Rabbit', 220, 0, 15, 1, 0, '[]', '[]', 1, 1, 'blood', '[{\"id\":2666,\"count\":\"2\",\"chance\":\"85000\"},{\"id\":11209,\"count\":1,\"chance\":\"30000\"},{\"id\":\"2684\",\"count\":1,\"chance\":\"10000\"}]'),
(2018, 0, 'Sir Valorcrest', 0, 1800, 1600, 25, 0, '[\"I challenge you!\"]', '[\"lifedrain\",\"death\",\"invisible\"]', 0, 0, 'undead', '[{\"id\":2148,\"count\":\"93\",\"chance\":\"100000\"},{\"id\":2152,\"count\":\"5\",\"chance\":\"50000\"},{\"id\":2207,\"count\":1,\"chance\":\"1400\"},{\"id\":2214,\"count\":1,\"chance\":\"17111\"},{\"id\":\"2229\",\"count\":1,\"chance\":\"15000\"},{\"id\":2534,\"count\":1,\"chance\":\"6300\"},{\"id\":7427,\"count\":1,\"chance\":\"250\"},{\"id\":7588,\"count\":1,\"chance\":\"1500\"},{\"id\":9020,\"count\":1,\"chance\":\"100000\"},{\"id\":9020,\"count\":1,\"chance\":\"100000\"}]'),
(2019, 0, 'Skeleton Warrior', 350, 45, 65, 1, 0, '[]', '[\"death\"]', 1, 1, 'undead', '[{\"id\":2148,\"count\":\"10\",\"chance\":\"43500\"},{\"id\":\"2230\",\"count\":1,\"chance\":\"50000\"},{\"id\":\"2376\",\"count\":1,\"chance\":\"1500\"},{\"id\":2398,\"count\":1,\"chance\":\"2000\"},{\"id\":2787,\"count\":\"3\",\"chance\":\"24000\"},{\"id\":2789,\"count\":1,\"chance\":\"1700\"},{\"id\":12437,\"count\":1,\"chance\":\"10630\"}]'),
(2020, 0, 'Skeleton', 300, 35, 50, 1, 0, '[]', '[\"death\",\"drown\",\"lifedrain\"]', 1, 1, 'undead', '[{\"id\":\"2230\",\"count\":1,\"chance\":\"50915\"},{\"id\":\"2148\",\"count\":\"10\",\"chance\":\"44978\"},{\"id\":\"2050\",\"count\":1,\"chance\":\"10285\"},{\"id\":\"12437\",\"count\":1,\"chance\":\"10178\"},{\"id\":\"2473\",\"count\":1,\"chance\":\"7687\"},{\"id\":\"2388\",\"count\":1,\"chance\":\"5375\"},{\"id\":\"2398\",\"count\":1,\"chance\":\"4625\"},{\"id\":\"2376\",\"count\":1,\"chance\":\"2107\"},{\"id\":\"2511\",\"count\":1,\"chance\":\"920\"}]'),
(2021, 0, 'Skunk', 200, 3, 20, 1, 0, '[]', '[]', 1, 1, 'blood', '[{\"id\":\"9114\",\"count\":1,\"chance\":\"4472\"},{\"id\":\"11191\",\"count\":1,\"chance\":\"884\"}]'),
(2022, 0, 'Slick Water Elemental', 0, 450, 550, 30, 0, '[\"Blubb\",\"Splipsh Splash\"]', '[\"ice\",\"drown\"]', 0, 0, 'undead', '[{\"id\":2148,\"count\":\"70\",\"chance\":\"22500\"},{\"id\":2148,\"count\":\"60\",\"chance\":\"22500\"},{\"id\":7839,\"count\":\"3\",\"chance\":\"2575\"},{\"id\":8302,\"count\":1,\"chance\":\"6000\"}]'),
(2023, 0, 'Slim', 0, 580, 1025, 1, 0, '[\"Zhroozzzzs.\"]', '[\"death\",\"earth\",\"outfit\",\"drunk\",\"invisible\"]', 0, 0, 'undead', '[]'),
(2024, 0, 'Slime', 0, 160, 150, 1, 0, '[\"Blubb\"]', '[\"earth\"]', 0, 0, 'venom', '[]'),
(2025, 0, 'Slippery Northern Pike', 0, 0, 100, 45, 0, '[\"Blub!\"]', '[\"earth\",\"fire\",\"invisible\",\"drown\"]', 0, 0, 'blood', '[]'),
(2026, 0, 'Slug', 0, 70, 255, 1, 0, '[]', '[]', 0, 0, 'venom', '[{\"id\":2148,\"count\":\"40\",\"chance\":\"62000\"},{\"id\":3976,\"count\":\"3\",\"chance\":\"5000\"}]'),
(2027, 0, 'Smuggler', 390, 48, 130, 1, 0, '[\"I will silence you forever!\",\"You saw something you shouldn\'t!\"]', '[]', 1, 1, 'blood', '[{\"id\":\"2148\",\"count\":\"10\",\"chance\":\"79815\"},{\"id\":\"2050\",\"count\":\"2\",\"chance\":\"30203\"},{\"id\":\"2649\",\"count\":1,\"chance\":\"14782\"},{\"id\":\"2671\",\"count\":1,\"chance\":\"10185\"},{\"id\":\"2406\",\"count\":1,\"chance\":\"10051\"},{\"id\":\"2461\",\"count\":1,\"chance\":\"10036\"},{\"id\":\"2403\",\"count\":1,\"chance\":\"10012\"},{\"id\":\"2376\",\"count\":1,\"chance\":\"5012\"},{\"id\":\"8840\",\"count\":\"5\",\"chance\":\"4896\"},{\"id\":\"2404\",\"count\":1,\"chance\":\"4042\"},{\"id\":\"7397\",\"count\":1,\"chance\":\"112\"}]'),
(2028, 0, 'Smuggler Baron Silvertoe', 0, 170, 280, 90, 0, '[\"I will make your death look like an accident!\",\"You should not have interferred with my bussiness!\",\"Bribes are expensive, murder is cheap!\",\"I see some profit in your death!\",\"I expect you to die!\"]', '[]', 0, 0, 'blood', '[{\"id\":\"2148\",\"count\":\"30\",\"chance\":\"80000\"},{\"id\":\"2050\",\"count\":\"2\",\"chance\":\"30200\"},{\"id\":\"2649\",\"count\":1,\"chance\":\"14000\"},{\"id\":\"2671\",\"count\":1,\"chance\":\"10000\"},{\"id\":\"2406\",\"count\":1,\"chance\":\"10000\"},{\"id\":\"2461\",\"count\":1,\"chance\":\"10000\"},{\"id\":\"2403\",\"count\":1,\"chance\":\"10000\"},{\"id\":\"2376\",\"count\":1,\"chance\":\"5000\"},{\"id\":\"8840\",\"count\":\"5\",\"chance\":\"5000\"},{\"id\":\"2404\",\"count\":1,\"chance\":\"4000\"},{\"id\":\"7397\",\"count\":1,\"chance\":\"110\"}]'),
(2029, 0, 'Snake God Essence', 0, 1350, 20000, 40, 0, '[\"AHHH ZHE POWER...\",\"ZHE TIME OF ZHE SNAKE HAZ COME!\"]', '[\"earth\",\"invisible\",\"paralyze\"]', 0, 0, 'blood', '[]'),
(2030, 0, 'Snake Thing', 0, 4600, 20000, 10, 0, '[\"POWER! I SEED MORE POWER!\"]', '[\"paralyze\",\"invisible\",\"earth\"]', 0, 0, 'venom', '[]'),
(2031, 0, 'Snake', 205, 10, 15, 1, 0, '[\"Zzzzzzt\"]', '[]', 1, 0, 'blood', '[]'),
(2032, 0, 'Son of Verminor', 0, 5900, 8500, 10, 0, '[\"Blubb\"]', '[\"earth\",\"paralyze\",\"invisible\"]', 0, 0, 'venom', '[]'),
(2033, 0, 'Souleater', 0, 1300, 1100, 1, 0, '[\"Life is such a fickle thing!\",\"I will devour your soul.\",\"Souuuls!\",\"I will feed on you.\"]', '[\"paralyze\",\"invisible\",\"death\"]', 0, 0, 'undead', '[{\"id\":2148,\"count\":\"100\",\"chance\":\"33400\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"33400\"},{\"id\":2152,\"count\":\"6\",\"chance\":\"49610\"},{\"id\":2185,\"count\":1,\"chance\":\"980\"},{\"id\":2189,\"count\":1,\"chance\":\"910\"},{\"id\":5884,\"count\":1,\"chance\":\"140\"},{\"id\":\"6300\",\"count\":1,\"chance\":\"300\"},{\"id\":7590,\"count\":1,\"chance\":\"8000\"},{\"id\":8473,\"count\":1,\"chance\":\"9400\"},{\"id\":12635,\"count\":1,\"chance\":\"20\"},{\"id\":12636,\"count\":1,\"chance\":\"15250\"},{\"id\":12637,\"count\":1,\"chance\":\"2000\"}]'),
(2034, 0, 'Sparkion', 0, 1520, 2700, 41, 0, '[\"Zzing!\",\"Frizzle!\"]', '[\"paralyze\",\"invisible\"]', 0, 0, 'energy', '[{\"id\":2148,\"count\":\"100\",\"chance\":\"100000\"},{\"id\":2152,\"count\":\"3\",\"chance\":\"90000\"},{\"id\":26158,\"count\":1,\"chance\":\"16000\"},{\"id\":26201,\"count\":1,\"chance\":\"15000\"},{\"id\":26191,\"count\":1,\"chance\":\"15000\"},{\"id\":26161,\"count\":1,\"chance\":\"13000\"},{\"id\":26160,\"count\":1,\"chance\":\"11000\"},{\"id\":26159,\"count\":1,\"chance\":\"9700\"},{\"id\":7590,\"count\":\"2\",\"chance\":\"9500\"},{\"id\":8472,\"count\":\"2\",\"chance\":\"9500\"},{\"id\":7591,\"count\":\"2\",\"chance\":\"9500\"},{\"id\":18418,\"count\":1,\"chance\":\"7700\"},{\"id\":18419,\"count\":1,\"chance\":\"5300\"},{\"id\":2146,\"count\":\"2\",\"chance\":\"4400\"},{\"id\":18413,\"count\":1,\"chance\":\"4000\"},{\"id\":2158,\"count\":1,\"chance\":\"900\"},{\"id\":2189,\"count\":1,\"chance\":\"900\"},{\"id\":\"26187\",\"count\":1,\"chance\":\"400\"},{\"id\":\"26189\",\"count\":1,\"chance\":\"400\"},{\"id\":\"26185\",\"count\":1,\"chance\":\"400\"},{\"id\":\"26199\",\"count\":1,\"chance\":\"250\"},{\"id\":\"26198\",\"count\":1,\"chance\":\"250\"},{\"id\":\"26200\",\"count\":1,\"chance\":\"250\"}]'),
(2035, 0, 'Spectral Scum', 0, 0, 1, 5, 0, '[\"BBooze! More booze!, Harrr Harrr!\",\"Burp, Fart.\",\"Nothing better than plundering and getting palstered!\",\"Yarrr!, A pirate\'s unlife for me!\"]', '[\"fire\",\"invisible\"]', 0, 0, 'undead', '[]'),
(2036, 0, 'Spectre', 0, 2100, 1350, 5, 1, '[\"Revenge ... is so ... sweet!\",\"Life...force! Feed me your... lifeforce!\"]', '[\"paralyze\",\"invisible\",\"drown\",\"lifedrain\",\"earth\",\"death\",\"drunk\"]', 0, 0, 'undead', '[{\"id\":\"2071\",\"count\":1,\"chance\":\"9620\"},{\"id\":2134,\"count\":1,\"chance\":\"850\"},{\"id\":2134,\"count\":1,\"chance\":\"110\"},{\"id\":\"2136\",\"count\":1,\"chance\":\"110\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"33000\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"33000\"},{\"id\":2148,\"count\":\"97\",\"chance\":\"33000\"},{\"id\":2152,\"count\":\"7\",\"chance\":\"3850\"},{\"id\":2165,\"count\":1,\"chance\":\"190\"},{\"id\":2189,\"count\":1,\"chance\":\"9800\"},{\"id\":2260,\"count\":\"2\",\"chance\":\"30310\"},{\"id\":5909,\"count\":1,\"chance\":\"3800\"},{\"id\":5944,\"count\":1,\"chance\":\"6005\"},{\"id\":\"6300\",\"count\":1,\"chance\":\"280\"},{\"id\":6500,\"count\":1,\"chance\":\"6270\"},{\"id\":7383,\"count\":1,\"chance\":\"700\"},{\"id\":7590,\"count\":1,\"chance\":\"920\"},{\"id\":11227,\"count\":1,\"chance\":\"1000\"}]'),
(2037, 0, 'Spider Queen', 0, 120, 10000, 30, 0, '[]', '[\"physical\",\"outfit\",\"drunk\",\"invisible\",\"earth\"]', 0, 0, 'venom', '[]'),
(2038, 0, 'Spider', 210, 12, 20, 1, 0, '[]', '[]', 1, 1, 'venom', '[{\"id\":2148,\"count\":\"5\",\"chance\":\"65000\"},{\"id\":8859,\"count\":1,\"chance\":\"950\"}]'),
(2039, 0, 'Spidris Elite', 0, 4000, 5000, 20, 0, '[]', '[\"earth\",\"invisible\"]', 0, 0, 'venom', '[{\"id\":2147,\"count\":\"5\",\"chance\":\"23280\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"50000\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"50000\"},{\"id\":2152,\"count\":\"6\",\"chance\":\"45000\"},{\"id\":2153,\"count\":1,\"chance\":\"1120\"},{\"id\":\"6300\",\"count\":1,\"chance\":\"4480\"},{\"id\":7413,\"count\":1,\"chance\":\"1440\"},{\"id\":7590,\"count\":\"2\",\"chance\":\"20400\"},{\"id\":\"7632\",\"count\":1,\"chance\":\"3040\"},{\"id\":8473,\"count\":\"2\",\"chance\":\"9250\"},{\"id\":15485,\"count\":1,\"chance\":\"27440\"},{\"id\":15486,\"count\":1,\"chance\":\"13210\"},{\"id\":15489,\"count\":1,\"chance\":\"1280\"},{\"id\":15491,\"count\":1,\"chance\":\"1170\"},{\"id\":15492,\"count\":1,\"chance\":\"1390\"}]'),
(2040, 0, 'Spidris', 0, 2600, 3700, 20, 1, '[\"Eeeeeeyyyyh!\",\"Iiiiieeeeeh!\"]', '[\"earth\",\"invisible\"]', 0, 0, 'venom', '[{\"id\":2147,\"count\":\"5\",\"chance\":\"11900\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"50000\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"50000\"},{\"id\":2152,\"count\":\"4\",\"chance\":\"45000\"},{\"id\":2153,\"count\":1,\"chance\":\"770\"},{\"id\":\"6300\",\"count\":1,\"chance\":\"2700\"},{\"id\":7413,\"count\":1,\"chance\":\"920\"},{\"id\":7590,\"count\":\"2\",\"chance\":\"11500\"},{\"id\":\"7632\",\"count\":1,\"chance\":\"1700\"},{\"id\":8473,\"count\":\"2\",\"chance\":\"6250\"},{\"id\":15485,\"count\":1,\"chance\":\"14960\"},{\"id\":15486,\"count\":1,\"chance\":\"12500\"},{\"id\":15489,\"count\":1,\"chance\":\"370\"},{\"id\":15491,\"count\":1,\"chance\":\"720\"},{\"id\":15492,\"count\":1,\"chance\":\"690\"}]'),
(2041, 0, 'Spirit of Earth', 0, 800, 1200, 1, 0, '[\"Show your strengh ... or perish.\"]', '[\"outfit\",\"drunk\",\"invisible\"]', 0, 0, 'undead', '[]'),
(2042, 0, 'Spirit of Fire', 0, 950, 2210, 1, 0, '[\"Feel the heat.\"]', '[\"fire\",\"outfit\",\"drunk\",\"invisible\"]', 0, 0, 'blood', '[]'),
(2043, 0, 'Spirit of Water', 0, 850, 1400, 1, 0, '[\"Blubb\"]', '[\"fire\",\"ice\",\"outfit\",\"drunk\",\"invisible\"]', 0, 0, 'undead', '[]'),
(2044, 0, 'Spit Nettle', 0, 20, 150, 1, 0, '[]', '[\"energy\",\"earth\",\"paralyze\",\"invisible\"]', 0, 0, 'venom', '[{\"id\":\"2804\",\"count\":1,\"chance\":\"10954\"},{\"id\":\"2148\",\"count\":\"5\",\"chance\":\"10703\"},{\"id\":\"12432\",\"count\":1,\"chance\":\"9840\"},{\"id\":\"2802\",\"count\":\"2\",\"chance\":\"5556\"},{\"id\":\"2747\",\"count\":1,\"chance\":\"989\"},{\"id\":\"11231\",\"count\":1,\"chance\":\"910\"},{\"id\":\"7732\",\"count\":1,\"chance\":\"361\"}]'),
(2045, 0, 'Spite of the Emperor', 0, 5600, 8000, 95, 0, '[]', '[\"death\",\"earth\"]', 0, 0, 'undead', '[]'),
(2046, 0, 'Spitter', 0, 1100, 1500, 1, 1, '[]', '[\"earth\",\"invisible\"]', 0, 0, 'venom', '[{\"id\":2148,\"count\":\"100\",\"chance\":\"50000\"},{\"id\":2148,\"count\":\"90\",\"chance\":\"50000\"},{\"id\":2150,\"count\":\"2\",\"chance\":\"8000\"},{\"id\":2152,\"count\":1,\"chance\":\"75250\"},{\"id\":2155,\"count\":1,\"chance\":\"210\"},{\"id\":\"2169\",\"count\":1,\"chance\":\"2400\"},{\"id\":2171,\"count\":1,\"chance\":\"260\"},{\"id\":2497,\"count\":1,\"chance\":\"230\"},{\"id\":2789,\"count\":\"3\",\"chance\":\"7500\"},{\"id\":7440,\"count\":1,\"chance\":\"310\"},{\"id\":7449,\"count\":1,\"chance\":\"2000\"},{\"id\":7590,\"count\":1,\"chance\":\"8000\"},{\"id\":7591,\"count\":1,\"chance\":\"5000\"},{\"id\":15481,\"count\":1,\"chance\":\"18000\"},{\"id\":15486,\"count\":1,\"chance\":\"15000\"},{\"id\":15489,\"count\":1,\"chance\":\"240\"},{\"id\":15490,\"count\":1,\"chance\":\"130\"}]'),
(2047, 0, 'Splasher', 0, 500, 1700, 150, 0, '[\"Qua hah tsh!\",\"Teech tsha tshul!\",\"Quara tsha Fach!\",\"Tssssha Quara!\",\"Blubber.\",\"Blup.\"]', '[\"ice\",\"fire\",\"drown\",\"paralyze\"]', 0, 0, 'blood', '[{\"id\":2148,\"count\":\"4\",\"chance\":\"13000\"}]'),
(2048, 0, 'Squidgy Slime', 0, 55, 150, 1, 0, '[\"Blubb\"]', '[\"earth\"]', 0, 0, 'venom', '[]'),
(2049, 0, 'Squirrel', 220, 0, 20, 130, 0, '[\"Chchch\"]', '[]', 1, 1, 'blood', '[{\"id\":\"11213\",\"count\":1,\"chance\":\"36613\"},{\"id\":\"7910\",\"count\":1,\"chance\":\"652\"},{\"id\":\"7909\",\"count\":1,\"chance\":\"516\"}]'),
(2050, 0, 'Stalker', 0, 90, 120, 20, 0, '[]', '[\"invisible\",\"lifedrain\"]', 0, 0, 'blood', '[{\"id\":\"2148\",\"count\":\"8\",\"chance\":\"13123\"},{\"id\":\"2410\",\"count\":\"2\",\"chance\":\"11116\"},{\"id\":\"2260\",\"count\":1,\"chance\":\"8811\"},{\"id\":\"2511\",\"count\":1,\"chance\":\"5617\"},{\"id\":\"2478\",\"count\":1,\"chance\":\"3531\"},{\"id\":\"12430\",\"count\":1,\"chance\":\"1543\"},{\"id\":\"2425\",\"count\":1,\"chance\":\"1198\"},{\"id\":\"2412\",\"count\":1,\"chance\":\"519\"}]'),
(2051, 0, 'Stampor', 0, 780, 1200, 10, 0, '[\"KRRRRRNG\"]', '[\"paralyze\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":2148,\"count\":\"100\",\"chance\":\"10000\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"10000\"},{\"id\":2148,\"count\":\"42\",\"chance\":\"10000\"},{\"id\":2152,\"count\":\"2\",\"chance\":\"9920\"},{\"id\":2391,\"count\":1,\"chance\":\"1010\"},{\"id\":2476,\"count\":1,\"chance\":\"870\"},{\"id\":7452,\"count\":1,\"chance\":\"160\"},{\"id\":7588,\"count\":\"2\",\"chance\":\"5000\"},{\"id\":7589,\"count\":\"2\",\"chance\":\"5000\"},{\"id\":9970,\"count\":\"2\",\"chance\":\"7940\"},{\"id\":13299,\"count\":1,\"chance\":\"4920\"},{\"id\":13300,\"count\":\"2\",\"chance\":\"9950\"},{\"id\":13301,\"count\":1,\"chance\":\"3020\"}]'),
(2052, 0, 'Starving Wolf', 0, 65, 85, 1, 0, '[\"Gaarrrrrr\",\"Gnoorrr\",\"Yoooohhuuuu!\"]', '[\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2220\",\"count\":1,\"chance\":\"64730\"},{\"id\":2666,\"count\":\"2\",\"chance\":\"5300\"},{\"id\":5897,\"count\":1,\"chance\":\"1430\"}]'),
(2053, 0, 'Stone Devourer', 0, 2900, 4200, 15, 0, '[\"Rumble!\"]', '[\"paralyze\",\"invisible\",\"fire\",\"earth\"]', 0, 0, 'undead', '[{\"id\":2148,\"count\":\"100\",\"chance\":\"100000\"},{\"id\":2152,\"count\":\"7\",\"chance\":\"92000\"},{\"id\":2197,\"count\":1,\"chance\":\"2270\"},{\"id\":2213,\"count\":1,\"chance\":\"2840\"},{\"id\":2393,\"count\":1,\"chance\":\"570\"},{\"id\":2445,\"count\":1,\"chance\":\"850\"},{\"id\":2454,\"count\":1,\"chance\":\"920\"},{\"id\":7437,\"count\":1,\"chance\":\"1490\"},{\"id\":7452,\"count\":1,\"chance\":\"1490\"},{\"id\":7454,\"count\":1,\"chance\":\"3340\"},{\"id\":7588,\"count\":\"2\",\"chance\":\"13840\"},{\"id\":7589,\"count\":\"2\",\"chance\":\"14900\"},{\"id\":7590,\"count\":\"2\",\"chance\":\"15610\"},{\"id\":7620,\"count\":\"2\",\"chance\":\"15050\"},{\"id\":8473,\"count\":1,\"chance\":\"14410\"},{\"id\":\"8748\",\"count\":1,\"chance\":\"11360\"},{\"id\":10549,\"count\":1,\"chance\":\"12850\"},{\"id\":18304,\"count\":\"10\",\"chance\":\"9940\"},{\"id\":18416,\"count\":1,\"chance\":\"6960\"},{\"id\":18419,\"count\":1,\"chance\":\"6810\"},{\"id\":18431,\"count\":1,\"chance\":\"18679\"},{\"id\":18432,\"count\":1,\"chance\":\"16320\"}]'),
(2054, 0, 'Stone Golem', 590, 160, 270, 1, 0, '[]', '[\"paralyze\",\"drown\",\"earth\"]', 1, 1, 'undead', '[{\"id\":\"2148\",\"count\":\"40\",\"chance\":\"95794\"},{\"id\":\"1294\",\"count\":\"4\",\"chance\":\"12849\"},{\"id\":\"11232\",\"count\":1,\"chance\":\"10115\"},{\"id\":\"2166\",\"count\":1,\"chance\":\"5137\"},{\"id\":\"2395\",\"count\":1,\"chance\":\"2572\"},{\"id\":\"5880\",\"count\":1,\"chance\":\"2054\"},{\"id\":\"10549\",\"count\":1,\"chance\":\"1017\"},{\"id\":\"11227\",\"count\":1,\"chance\":\"782\"},{\"id\":\"13757\",\"count\":1,\"chance\":\"528\"},{\"id\":\"11343\",\"count\":1,\"chance\":\"416\"},{\"id\":\"2124\",\"count\":1,\"chance\":\"181\"},{\"id\":\"2156\",\"count\":1,\"chance\":\"48\"}]'),
(2055, 0, 'Stonecracker', 0, 3500, 6500, 30, 1, '[\"HUAHAHA!\"]', '[\"paralyze\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"5930\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2148\",\"count\":\"162\",\"chance\":\"100000\"},{\"id\":\"5893\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"7396\",\"count\":1,\"chance\":\"97619\"},{\"id\":\"2150\",\"count\":\"5\",\"chance\":\"69048\"},{\"id\":\"7368\",\"count\":\"94\",\"chance\":\"64286\"},{\"id\":\"2377\",\"count\":1,\"chance\":\"52381\"},{\"id\":\"2666\",\"count\":1,\"chance\":\"23810\"},{\"id\":\"2489\",\"count\":1,\"chance\":\"14286\"},{\"id\":\"2387\",\"count\":1,\"chance\":\"7143\"},{\"id\":\"11227\",\"count\":1,\"chance\":\"4762\"}]'),
(2056, 0, 'Strange Slime', 0, 0, 15, 1, 0, '[]', '[]', 0, 0, 'venom', '[]'),
(2057, 0, 'Svoren the Mad', 0, 3000, 6310, 1, 0, '[\"NO mommy NO. Leave me alone!\",\"Not that tower again!\",\"The cat has grown some horns!!\",\"What was I doing here again?\",\"Are we there soon mommy?\"]', '[\"fire\",\"ice\",\"energy\",\"earth\",\"outfit\",\"drunk\",\"invisible\"]', 0, 0, 'blood', '[]'),
(2058, 0, 'Swamp Troll', 320, 25, 55, 1, 0, '[\"Grrrr\",\"Groar!\",\"Me strong! Me ate spinach!\"]', '[]', 1, 0, 'blood', '[{\"id\":\"2667\",\"count\":1,\"chance\":\"60000\"},{\"id\":2148,\"count\":\"5\",\"chance\":\"50300\"},{\"id\":\"2050\",\"count\":1,\"chance\":\"15000\"},{\"id\":2389,\"count\":1,\"chance\":\"13000\"},{\"id\":2235,\"count\":1,\"chance\":\"10000\"},{\"id\":2643,\"count\":1,\"chance\":\"10000\"},{\"id\":10603,\"count\":1,\"chance\":\"3100\"},{\"id\":13506,\"count\":1,\"chance\":\"2400\"},{\"id\":\"5901\",\"count\":1,\"chance\":\"2000\"},{\"id\":2805,\"count\":1,\"chance\":\"1000\"},{\"id\":2580,\"count\":1,\"chance\":\"80\"}]'),
(2059, 0, 'Swampling', 0, 45, 80, 1, 0, '[\"Gnark!\",\"Crrrck!\"]', '[\"paralyze\",\"invisible\"]', 0, 0, 'venom', '[{\"id\":\"2120\",\"count\":1,\"chance\":\"4540\"},{\"id\":2148,\"count\":\"12\",\"chance\":\"60000\"},{\"id\":2787,\"count\":\"5\",\"chance\":\"8980\"},{\"id\":20101,\"count\":1,\"chance\":\"18670\"},{\"id\":20102,\"count\":1,\"chance\":\"12610\"},{\"id\":20103,\"count\":1,\"chance\":\"8270\"}]'),
(2060, 0, 'Swarmer Hatchling', 0, 0, 5, 1, 0, '[\"Flzlzlzlzlzlzlz?\"]', '[]', 0, 0, 'venom', '[]'),
(2061, 0, 'Swarmer', 0, 350, 460, 1, 1, '[\"Flzlzlzlzlzlzlz!\",\"Rzlrzlrzlrzlrzlrzl!\"]', '[\"earth\",\"invisible\"]', 0, 0, 'venom', '[{\"id\":2148,\"count\":\"75\",\"chance\":\"100000\"},{\"id\":2149,\"count\":1,\"chance\":\"920\"},{\"id\":2438,\"count\":1,\"chance\":\"450\"},{\"id\":15479,\"count\":1,\"chance\":\"15300\"},{\"id\":15486,\"count\":1,\"chance\":\"12500\"}]'),
(2062, 0, 'Tanjis', 0, 15000, 30000, 170, 0, '[\"JAUL QJELL, JAKNH JEH KENH!!\"]', '[\"ice\",\"paralyze\",\"drown\",\"fire\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":15409,\"count\":1,\"chance\":\"50000\"},{\"id\":15413,\"count\":1,\"chance\":\"20000\"},{\"id\":15414,\"count\":1,\"chance\":\"25000\"}]'),
(2063, 0, 'Tarantula', 485, 120, 225, 1, 1, '[]', '[\"earth\",\"outfit\",\"drunk\"]', 1, 1, 'venom', '[{\"id\":\"2148\",\"count\":\"40\",\"chance\":\"79114\"},{\"id\":\"11198\",\"count\":1,\"chance\":\"9960\"},{\"id\":\"8859\",\"count\":1,\"chance\":\"4844\"},{\"id\":\"2478\",\"count\":1,\"chance\":\"3021\"},{\"id\":\"2510\",\"count\":1,\"chance\":\"1966\"},{\"id\":\"3351\",\"count\":1,\"chance\":\"925\"},{\"id\":\"2169\",\"count\":1,\"chance\":\"112\"}]'),
(2064, 0, 'Tarnished Spirit', 0, 120, 150, 1, 0, '[\"Huh!\"]', '[\"physical\",\"drown\",\"earth\",\"death\",\"lifedrain\",\"paralyze\"]', 0, 0, 'undead', '[{\"id\":\"1962\",\"count\":1,\"chance\":\"1310\"},{\"id\":2165,\"count\":1,\"chance\":\"180\"},{\"id\":2394,\"count\":1,\"chance\":\"10610\"},{\"id\":2404,\"count\":1,\"chance\":\"7002\"},{\"id\":2532,\"count\":1,\"chance\":\"860\"},{\"id\":2654,\"count\":1,\"chance\":\"8800\"},{\"id\":2804,\"count\":1,\"chance\":\"14400\"},{\"id\":5909,\"count\":1,\"chance\":\"1940\"},{\"id\":10607,\"count\":1,\"chance\":\"1870\"}]'),
(2065, 0, 'Teleskor', 0, 70, 80, 1, 0, '[\"Who disturbs my slumber?\",\"Mourn the dead, do not hunt them!\"]', '[]', 0, 0, 'undead', '[{\"id\":\"12437\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2148\",\"count\":\"79\",\"chance\":\"81000\"},{\"id\":\"2398\",\"count\":1,\"chance\":\"72000\"},{\"id\":\"2473\",\"count\":1,\"chance\":\"72000\"},{\"id\":\"2511\",\"count\":1,\"chance\":\"45000\"},{\"id\":\"2050\",\"count\":1,\"chance\":\"36000\"},{\"id\":\"2388\",\"count\":1,\"chance\":\"27000\"},{\"id\":\"2376\",\"count\":1,\"chance\":\"27000\"}]');
INSERT INTO `myaac_monsters` (`id`, `hidden`, `name`, `mana`, `exp`, `health`, `speed_lvl`, `use_haste`, `voices`, `immunities`, `summonable`, `convinceable`, `race`, `loot`) VALUES
(2066, 0, 'Terofar', 0, 24000, 40000, 110, 1, '[\"IT TOOK AN ARMY OF YOUR KIND TO DEFEAT THE WARDEN. NOW YOU ARE ALONE!\",\"FEELS GOOD TO BE BACK IN ACTION!\",\"THE WARDS ARE FAILING! MY ESCAPE IS ONLY A MATTER OF TIME!!\",\"Terofar cast a greater death curse on you!\"]', '[\"poison\",\"lifedrain\",\"paralyze\",\"outfit\",\"drunk\",\"invisible\"]', 0, 0, 'fire', '[{\"id\":\"22396\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"22598\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"22397\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"6500\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"5954\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"22610\",\"count\":1,\"chance\":\"3560\"},{\"id\":\"2148\",\"count\":\"100\",\"chance\":\"50000\"},{\"id\":\"2148\",\"count\":\"100\",\"chance\":\"50000\"},{\"id\":\"2152\",\"count\":\"50\",\"chance\":\"100000\"},{\"id\":\"7590\",\"count\":\"10\",\"chance\":\"33330\"},{\"id\":\"8473\",\"count\":\"10\",\"chance\":\"3890\"},{\"id\":\"8472\",\"count\":\"5\",\"chance\":\"2780\"},{\"id\":\"18413\",\"count\":\"8\",\"chance\":\"22220\"},{\"id\":\"18414\",\"count\":\"8\",\"chance\":\"33330\"},{\"id\":\"18415\",\"count\":\"8\",\"chance\":\"44440\"},{\"id\":\"9971\",\"count\":1,\"chance\":\"16670\"},{\"id\":\"7632\",\"count\":1,\"chance\":\"38890\"},{\"id\":\"7633\",\"count\":1,\"chance\":\"38890\"},{\"id\":\"2520\",\"count\":1,\"chance\":\"11110\"},{\"id\":\"2515\",\"count\":1,\"chance\":\"22220\"},{\"id\":\"2519\",\"count\":1,\"chance\":\"11110\"},{\"id\":\"2514\",\"count\":1,\"chance\":\"960\"},{\"id\":\"8891\",\"count\":1,\"chance\":\"5560\"},{\"id\":\"8879\",\"count\":1,\"chance\":\"11110\"},{\"id\":\"8877\",\"count\":1,\"chance\":\"6110\"},{\"id\":\"2155\",\"count\":1,\"chance\":\"16670\"},{\"id\":\"2158\",\"count\":1,\"chance\":\"11110\"},{\"id\":\"8882\",\"count\":1,\"chance\":\"410\"},{\"id\":\"2472\",\"count\":1,\"chance\":\"610\"},{\"id\":\"2645\",\"count\":1,\"chance\":\"910\"},{\"id\":\"2498\",\"count\":1,\"chance\":\"910\"},{\"id\":\"7886\",\"count\":1,\"chance\":\"2910\"},{\"id\":\"2195\",\"count\":1,\"chance\":\"1910\"},{\"id\":\"5741\",\"count\":1,\"chance\":\"1910\"}]'),
(2067, 0, 'Terramite', 505, 160, 365, 1, 0, '[\"Zrp zrp!\"]', '[\"invisible\"]', 1, 1, 'venom', '[{\"id\":2148,\"count\":\"45\",\"chance\":\"97520\"},{\"id\":11369,\"count\":1,\"chance\":\"7730\"},{\"id\":11370,\"count\":\"3\",\"chance\":\"4680\"},{\"id\":11371,\"count\":1,\"chance\":\"14880\"}]'),
(2068, 0, 'Terrified Elephant', 500, 160, 320, 1, 1, '[\"Hooooot-Toooooot!\",\"Tooooot!\",\"Trooooot!\"]', '[]', 0, 1, 'blood', '[{\"id\":\"2666\",\"count\":1,\"chance\":\"40845\"},{\"id\":\"2671\",\"count\":1,\"chance\":\"29165\"},{\"id\":\"3956\",\"count\":\"2\",\"chance\":\"8611\"},{\"id\":\"3973\",\"count\":1,\"chance\":\"99\"}]'),
(2069, 0, 'Terror Bird', 490, 150, 300, 1, 0, '[\"CRAAAHHH!\",\"Gruuuh Gruuuh.\",\"Carrah Carrah!\"]', '[]', 1, 1, 'blood', '[{\"id\":2148,\"count\":\"30\",\"chance\":\"82500\"},{\"id\":2666,\"count\":\"3\",\"chance\":\"48000\"},{\"id\":11190,\"count\":1,\"chance\":\"10000\"},{\"id\":3976,\"count\":1,\"chance\":\"9500\"},{\"id\":12470,\"count\":1,\"chance\":\"3000\"},{\"id\":7618,\"count\":1,\"chance\":\"690\"},{\"id\":7732,\"count\":1,\"chance\":\"230\"},{\"id\":3970,\"count\":1,\"chance\":\"100\"}]'),
(2070, 0, 'Terrorsleep', 0, 5900, 7200, 70, 1, '[\"Aktat Roshok! Marruk!\",\"I will eat you in your sleep.\",\"I am the darkness around you...\"]', '[\"earth\",\"paralyze\",\"invisible\"]', 0, 0, 'venom', '[{\"id\":\"2148\",\"count\":\"197\",\"chance\":\"99960\"},{\"id\":\"2152\",\"count\":\"9\",\"chance\":\"99960\"},{\"id\":\"7590\",\"count\":\"2\",\"chance\":\"34849\"},{\"id\":\"8473\",\"count\":1,\"chance\":\"21811\"},{\"id\":\"18419\",\"count\":1,\"chance\":\"16700\"},{\"id\":\"22538\",\"count\":1,\"chance\":\"16660\"},{\"id\":\"2150\",\"count\":\"3\",\"chance\":\"14889\"},{\"id\":\"9970\",\"count\":\"3\",\"chance\":\"14447\"},{\"id\":\"2149\",\"count\":\"3\",\"chance\":\"13561\"},{\"id\":\"2147\",\"count\":\"3\",\"chance\":\"12797\"},{\"id\":\"18418\",\"count\":1,\"chance\":\"12274\"},{\"id\":\"22537\",\"count\":1,\"chance\":\"12233\"},{\"id\":\"18413\",\"count\":1,\"chance\":\"8974\"},{\"id\":\"5909\",\"count\":1,\"chance\":\"4024\"},{\"id\":\"5912\",\"count\":1,\"chance\":\"3461\"},{\"id\":\"2476\",\"count\":1,\"chance\":\"2294\"},{\"id\":\"5895\",\"count\":1,\"chance\":\"2173\"},{\"id\":\"22363\",\"count\":1,\"chance\":\"2093\"},{\"id\":\"2393\",\"count\":1,\"chance\":\"1650\"},{\"id\":\"2475\",\"count\":1,\"chance\":\"1650\"},{\"id\":\"2656\",\"count\":1,\"chance\":\"1207\"},{\"id\":\"5911\",\"count\":1,\"chance\":\"1127\"},{\"id\":\"22396\",\"count\":1,\"chance\":\"805\"}]'),
(2071, 0, 'Thalas', 0, 2950, 4100, 50, 0, '[\"You will become a feast for my maggots!\"]', '[\"death\",\"earth\",\"invisible\"]', 0, 0, 'undead', '[{\"id\":2351,\"count\":1,\"chance\":\"100000\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"30000\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"30000\"},{\"id\":2148,\"count\":\"38\",\"chance\":\"30000\"},{\"id\":2411,\"count\":1,\"chance\":\"21000\"},{\"id\":2149,\"count\":\"3\",\"chance\":\"9000\"},{\"id\":7591,\"count\":1,\"chance\":\"8200\"},{\"id\":\"2169\",\"count\":1,\"chance\":\"5200\"},{\"id\":2409,\"count\":1,\"chance\":\"2700\"},{\"id\":2451,\"count\":1,\"chance\":\"1000\"},{\"id\":2155,\"count\":1,\"chance\":\"100\"}]'),
(2072, 0, 'The Abomination', 0, 8500, 285000, 60, 0, '[\"DEATH IS INEVITABLE!\",\"I AM THE ESSENCE OF DEATH!\"]', '[\"earth\",\"outfit\",\"drunk\",\"invisible\"]', 0, 0, 'venom', '[{\"id\":2148,\"count\":\"100\",\"chance\":\"100000\"},{\"id\":2152,\"count\":\"3\",\"chance\":\"10000\"},{\"id\":5944,\"count\":1,\"chance\":\"2500\"},{\"id\":6500,\"count\":1,\"chance\":\"2857\"}]'),
(2073, 0, 'The Axeorcist', 0, 3000, 5000, 15, 0, '[\"DEESTRUCTIOON!\",\"Blood! Carnage! Muhahaha!\"]', '[\"invisible\"]', 0, 0, 'blood', '[]'),
(2074, 0, 'The Big Bad One', 0, 170, 300, 22, 0, '[\"Grrrrrrr\",\"Yoooohhuuuu!\"]', '[\"outfit\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"7394\",\"count\":1,\"chance\":\"50000\"},{\"id\":\"2671\",\"count\":1,\"chance\":\"25000\"},{\"id\":2666,\"count\":\"4\",\"chance\":\"25000\"},{\"id\":5897,\"count\":\"2\",\"chance\":\"15000\"},{\"id\":11235,\"count\":1,\"chance\":\"5000\"}]'),
(2075, 0, 'The Blightfather', 0, 600, 400, 35, 0, '[\"Crump!\"]', '[\"earth\",\"invisible\",\"lifedrain\",\"paralyze\"]', 0, 0, 'venom', '[{\"id\":2148,\"count\":\"61\",\"chance\":\"2000\"},{\"id\":2148,\"count\":\"60\",\"chance\":\"2000\"},{\"id\":2150,\"count\":1,\"chance\":\"800\"},{\"id\":10557,\"count\":1,\"chance\":\"12500\"},{\"id\":10609,\"count\":1,\"chance\":\"17500\"},{\"id\":11372,\"count\":1,\"chance\":\"7000\"},{\"id\":11374,\"count\":1,\"chance\":\"400\"}]'),
(2076, 0, 'The Bloodtusk', 0, 300, 600, 1, 0, '[]', '[\"paralyze\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":2148,\"count\":\"65\",\"chance\":\"66900\"},{\"id\":2152,\"count\":\"3\",\"chance\":\"83825\"},{\"id\":3973,\"count\":1,\"chance\":\"83825\"},{\"id\":7432,\"count\":1,\"chance\":\"50500\"},{\"id\":7463,\"count\":1,\"chance\":\"42175\"},{\"id\":8614,\"count\":\"2\",\"chance\":\"58825\"},{\"id\":11238,\"count\":\"2\",\"chance\":\"38000\"}]'),
(2077, 0, 'The Bloodweb', 0, 1450, 1750, 60, 1, '[\"Screeech!\"]', '[\"fire\",\"ice\",\"paralyze\",\"outfit\",\"drunk\",\"invisible\"]', 0, 0, 'undead', '[{\"id\":\"2152\",\"count\":\"9\",\"chance\":\"100000\"},{\"id\":\"7441\",\"count\":1,\"chance\":\"99231\"},{\"id\":\"7589\",\"count\":1,\"chance\":\"70769\"},{\"id\":\"5879\",\"count\":1,\"chance\":\"65385\"},{\"id\":\"7902\",\"count\":1,\"chance\":\"28462\"},{\"id\":\"7896\",\"count\":1,\"chance\":\"26154\"},{\"id\":\"11306\",\"count\":1,\"chance\":\"20769\"},{\"id\":\"7437\",\"count\":1,\"chance\":\"12308\"},{\"id\":\"2476\",\"count\":1,\"chance\":\"8462\"},{\"id\":\"5801\",\"count\":1,\"chance\":\"5385\"},{\"id\":\"2477\",\"count\":1,\"chance\":\"5385\"},{\"id\":\"7290\",\"count\":1,\"chance\":\"1538\"},{\"id\":\"2169\",\"count\":1,\"chance\":\"1538\"}]'),
(2078, 0, 'The Collector', 0, 100, 340, 1, 0, '[\"Leave as long as you can.\"]', '[\"ice\"]', 0, 0, 'undead', '[]'),
(2079, 0, 'The Count', 0, 450, 1250, 75, 0, '[]', '[\"lifedrain\",\"death\",\"invisible\"]', 0, 0, 'undead', '[{\"id\":2148,\"count\":\"98\",\"chance\":\"40000\"},{\"id\":2391,\"count\":1,\"chance\":\"2300\"},{\"id\":8752,\"count\":1,\"chance\":\"100000\"}]'),
(2080, 0, 'The Dark Dancer', 0, 435, 805, 1, 0, '[\"I hope you like my voice!\"]', '[\"outfit\",\"drunk\",\"invisible\"]', 0, 0, 'blood', '[]'),
(2081, 0, 'The Dreadorian', 0, 4000, 9000, 15, 0, '[]', '[\"invisible\",\"fire\"]', 0, 0, 'blood', '[]'),
(2082, 0, 'The Evil Eye', 0, 750, 1200, 10, 0, '[\"Inferior creatures, bow before my power!\",\"653768764!\"]', '[\"earth\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":5898,\"count\":1,\"chance\":\"100000\"},{\"id\":2148,\"count\":\"29\",\"chance\":\"33000\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"33000\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"33000\"},{\"id\":12468,\"count\":1,\"chance\":\"100000\"},{\"id\":2394,\"count\":1,\"chance\":\"50000\"},{\"id\":2509,\"count\":1,\"chance\":\"50000\"},{\"id\":2377,\"count\":1,\"chance\":\"34000\"},{\"id\":2397,\"count\":1,\"chance\":\"23000\"},{\"id\":\"2175\",\"count\":1,\"chance\":\"23000\"},{\"id\":7590,\"count\":1,\"chance\":\"15000\"},{\"id\":2518,\"count\":1,\"chance\":\"11000\"},{\"id\":7884,\"count\":1,\"chance\":\"11000\"},{\"id\":2181,\"count\":1,\"chance\":\"500\"},{\"id\":3972,\"count\":1,\"chance\":\"100\"}]'),
(2083, 0, 'The Fettered Shatterer', 0, 58000, 220000, 50, 1, '[\"RAAAAR! I! WILL! SHATTER! ALL!!\",\"WANT! TO! BREAK! FREE!!\",\"CRASH! BOOM! BANG! AHAHAHAAH!\",\"I WILL BREAK THE WORLD LIKE GLASS!\"]', '[\"earth\",\"paralyze\",\"energy\",\"fire\",\"invisible\"]', 0, 0, 'fire', '[]'),
(2084, 0, 'The Frog Prince', 0, 1, 55, 50, 0, '[\"Don\'t Kill me!!!\",\"Have mercy!\",\"Perhaps a kiss might release me!\"]', '[]', 0, 0, 'blood', '[]'),
(2085, 0, 'The Hag', 0, 510, 935, 1, 0, '[\"If you think I am to old to fight then you\'re wrong!\",\"I\'ve forgotten more things then you have ever learned!\",\"Let me teach you a few things youngster!\",\"I\'ll teach you respect for the old!\"]', '[\"outfit\",\"drunk\",\"invisible\"]', 0, 0, 'blood', '[]'),
(2086, 0, 'The Hairy One', 0, 115, 325, 10, 0, '[\"Hugah!\",\"Ungh! Ungh!\"]', '[\"outfit\",\"drunk\",\"invisible\"]', 0, 0, 'blood', '[]'),
(2087, 0, 'The Halloween Hare', 0, 0, 1, 1, 0, '[]', '[\"physical\",\"energy\",\"fire\",\"earth\",\"drown\",\"ice\",\"holy\",\"death\",\"lifedrain\",\"manadrain\",\"paralyze\",\"drunk\",\"invisible\"]', 0, 0, 'blood', '[]'),
(2088, 0, 'The Handmaiden', 0, 7500, 19500, 115, 1, '[]', '[\"energy\",\"fire\",\"ice\",\"earth\",\"lifedrain\",\"paralyze\",\"outfit\",\"drunk\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":6539,\"count\":1,\"chance\":\"35000\"}]'),
(2089, 0, 'The Horned Fox', 0, 300, 265, 1, 0, '[\"You will never get me!\",\"I\'ll be back!\",\"Catch me, if you can!\",\"Help me, boys!\"]', '[\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"5804\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2148\",\"count\":\"99\",\"chance\":\"96875\"},{\"id\":\"5878\",\"count\":1,\"chance\":\"96875\"},{\"id\":\"12428\",\"count\":\"2\",\"chance\":\"93750\"},{\"id\":\"12438\",\"count\":1,\"chance\":\"81250\"},{\"id\":\"7363\",\"count\":\"14\",\"chance\":\"46875\"},{\"id\":\"2465\",\"count\":1,\"chance\":\"28125\"},{\"id\":\"2666\",\"count\":1,\"chance\":\"15625\"},{\"id\":\"2513\",\"count\":1,\"chance\":\"12500\"},{\"id\":\"2502\",\"count\":1,\"chance\":\"9375\"},{\"id\":\"7588\",\"count\":1,\"chance\":\"9375\"},{\"id\":\"2580\",\"count\":1,\"chance\":\"6250\"},{\"id\":\"2387\",\"count\":1,\"chance\":\"3125\"}]'),
(2090, 0, 'The Imperor', 0, 8000, 15000, 55, 1, '[\"Muahaha!\",\"He he he!\"]', '[\"fire\",\"earth\",\"lifedrain\",\"paralyze\",\"outfit\",\"drunk\",\"invisible\"]', 0, 0, 'fire', '[{\"id\":\"2050\",\"count\":1,\"chance\":\"15000\"},{\"id\":2148,\"count\":\"79\",\"chance\":\"100000\"},{\"id\":2150,\"count\":1,\"chance\":\"8888\"},{\"id\":2165,\"count\":1,\"chance\":\"4555\"},{\"id\":2185,\"count\":1,\"chance\":\"833\"},{\"id\":2260,\"count\":1,\"chance\":\"18000\"},{\"id\":2464,\"count\":1,\"chance\":\"7887\"},{\"id\":2465,\"count\":1,\"chance\":\"6577\"},{\"id\":2465,\"count\":1,\"chance\":\"6577\"},{\"id\":2548,\"count\":1,\"chance\":\"20000\"},{\"id\":5944,\"count\":1,\"chance\":\"5666\"},{\"id\":\"6300\",\"count\":1,\"chance\":\"999\"},{\"id\":6500,\"count\":1,\"chance\":\"7777\"},{\"id\":6529,\"count\":\"5\",\"chance\":\"5000\"},{\"id\":6534,\"count\":1,\"chance\":\"100000\"},{\"id\":7891,\"count\":1,\"chance\":\"2000\"},{\"id\":7899,\"count\":1,\"chance\":\"2000\"},{\"id\":7900,\"count\":1,\"chance\":\"2000\"}]'),
(2091, 0, 'The Many', 0, 4000, 5000, 20, 0, '[\"FCHHHHH\",\"HISSSS\"]', '[\"lifedrain\",\"paralyze\",\"invisible\",\"earth\"]', 0, 0, 'blood', '[{\"id\":2146,\"count\":\"5\",\"chance\":\"56325\"},{\"id\":2197,\"count\":1,\"chance\":\"100000\"},{\"id\":2475,\"count\":1,\"chance\":\"75500\"},{\"id\":2498,\"count\":1,\"chance\":\"25500\"},{\"id\":2536,\"count\":1,\"chance\":\"75500\"},{\"id\":7589,\"count\":\"2\",\"chance\":\"100000\"},{\"id\":9971,\"count\":\"3\",\"chance\":\"47725\"},{\"id\":10219,\"count\":1,\"chance\":\"75500\"},{\"id\":10523,\"count\":1,\"chance\":\"100000\"}]'),
(2092, 0, 'The Masked Marauder', 0, 3500, 7320, 15, 0, '[\"Didn\'t you leave your house door open?\",\"Oops, your shoelaces are open!\",\"Look! It\'s Ferumbras behind you!\",\"Stop! I give up!\"]', '[\"fire\",\"outfit\",\"drunk\",\"invisible\"]', 0, 0, 'blood', '[]'),
(2093, 0, 'The Noxious Spawn', 0, 6000, 9500, 70, 0, '[\"Sssssouls for the one\",\"HISSSS\",\"Tsssse one will risssse again\",\"I bring your deathhh, mortalssss\"]', '[\"paralyze\",\"invisible\",\"earth\"]', 0, 0, 'venom', '[{\"id\":\"10611\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"11230\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2152\",\"count\":\"5\",\"chance\":\"80822\"},{\"id\":\"2149\",\"count\":\"5\",\"chance\":\"71233\"},{\"id\":\"7590\",\"count\":\"4\",\"chance\":\"64384\"},{\"id\":\"10309\",\"count\":1,\"chance\":\"45205\"},{\"id\":\"2528\",\"count\":1,\"chance\":\"43836\"},{\"id\":\"7456\",\"count\":1,\"chance\":\"42466\"},{\"id\":\"7386\",\"count\":1,\"chance\":\"36986\"},{\"id\":\"2033\",\"count\":1,\"chance\":\"32877\"},{\"id\":\"7368\",\"count\":\"98\",\"chance\":\"31507\"},{\"id\":\"2487\",\"count\":1,\"chance\":\"30137\"},{\"id\":\"2796\",\"count\":1,\"chance\":\"16438\"},{\"id\":\"8902\",\"count\":1,\"chance\":\"16438\"},{\"id\":\"2168\",\"count\":1,\"chance\":\"12329\"},{\"id\":\"2498\",\"count\":1,\"chance\":\"2740\"},{\"id\":\"8880\",\"count\":1,\"chance\":\"2740\"}]'),
(2094, 0, 'The Obliverator', 0, 6000, 9020, 30, 0, '[\"NO ONE WILL BEAT ME!\"]', '[\"fire\",\"outfit\",\"drunk\",\"invisible\"]', 0, 0, 'fire', '[]'),
(2095, 0, 'The Old Whopper', 0, 750, 785, 100, 0, '[\"Han oydar hot auden oydar\"]', '[\"invisible\"]', 0, 0, 'blood', '[{\"id\":2148,\"count\":\"100\",\"chance\":\"100000\"},{\"id\":2209,\"count\":1,\"chance\":\"90\"},{\"id\":2378,\"count\":1,\"chance\":\"5450\"},{\"id\":2387,\"count\":1,\"chance\":\"880\"},{\"id\":2417,\"count\":1,\"chance\":\"5200\"},{\"id\":2442,\"count\":1,\"chance\":\"2000\"},{\"id\":\"2490\",\"count\":1,\"chance\":\"200\"},{\"id\":2510,\"count\":1,\"chance\":\"2000\"},{\"id\":2513,\"count\":1,\"chance\":\"6190\"},{\"id\":2666,\"count\":1,\"chance\":\"49950\"},{\"id\":\"7398\",\"count\":1,\"chance\":\"75000\"},{\"id\":7452,\"count\":1,\"chance\":\"5150\"},{\"id\":7588,\"count\":1,\"chance\":\"390\"},{\"id\":10574,\"count\":1,\"chance\":\"10280\"}]'),
(2096, 0, 'The Old Widow', 0, 4200, 3200, 10, 1, '[]', '[\"earth\",\"lifedrain\",\"outfit\",\"drunk\",\"invisible\"]', 0, 0, 'venom', '[{\"id\":2148,\"count\":\"100\",\"chance\":\"99500\"},{\"id\":2152,\"count\":\"10\",\"chance\":\"98888\"},{\"id\":5879,\"count\":\"3\",\"chance\":\"87000\"},{\"id\":2457,\"count\":1,\"chance\":\"77000\"},{\"id\":7591,\"count\":\"4\",\"chance\":\"67000\"},{\"id\":2476,\"count\":1,\"chance\":\"42000\"},{\"id\":2167,\"count\":1,\"chance\":\"33333\"},{\"id\":2165,\"count\":1,\"chance\":\"33333\"},{\"id\":\"2169\",\"count\":1,\"chance\":\"33333\"},{\"id\":2477,\"count\":1,\"chance\":\"26000\"},{\"id\":2171,\"count\":1,\"chance\":\"21000\"},{\"id\":13307,\"count\":1,\"chance\":\"21000\"},{\"id\":5886,\"count\":1,\"chance\":\"10000\"},{\"id\":7419,\"count\":1,\"chance\":\"2800\"},{\"id\":7416,\"count\":1,\"chance\":\"1120\"}]'),
(2097, 0, 'The Pale Count', 0, 28000, 50000, 40, 0, '[\"Feel the hungry kiss of death!\",\"The monsters in the mirror will come eat your dreams.\",\"Your pitiful life has come to an end!\",\"I will squish you like a maggot and suck you dry!\",\"Yield to the inevitable!\",\"Some day I shall see my beautiful face in a mirror again.\"]', '[\"death\",\"lifedrain\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"9020\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"21244\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"21253\",\"count\":1,\"chance\":\"5000\"},{\"id\":\"21252\",\"count\":1,\"chance\":\"5000\"},{\"id\":\"12405\",\"count\":1,\"chance\":\"50000\"},{\"id\":\"10602\",\"count\":1,\"chance\":\"50000\"},{\"id\":\"21400\",\"count\":1,\"chance\":\"5000\"},{\"id\":\"2148\",\"count\":\"100\",\"chance\":\"100000\"},{\"id\":\"2152\",\"count\":\"5\",\"chance\":\"100000\"},{\"id\":\"7589\",\"count\":\"3\",\"chance\":\"50000\"},{\"id\":\"7588\",\"count\":\"3\",\"chance\":\"50000\"},{\"id\":\"2165\",\"count\":1,\"chance\":\"10000\"},{\"id\":\"2214\",\"count\":1,\"chance\":\"10000\"},{\"id\":\"5909\",\"count\":1,\"chance\":\"10000\"},{\"id\":\"5911\",\"count\":1,\"chance\":\"10000\"},{\"id\":\"5912\",\"count\":1,\"chance\":\"10000\"},{\"id\":\"7427\",\"count\":1,\"chance\":\"5000\"},{\"id\":\"2438\",\"count\":1,\"chance\":\"10000\"},{\"id\":\"7419\",\"count\":1,\"chance\":\"5000\"},{\"id\":\"8903\",\"count\":1,\"chance\":\"5000\"},{\"id\":\"21707\",\"count\":1,\"chance\":\"5000\"},{\"id\":\"2534\",\"count\":1,\"chance\":\"5000\"},{\"id\":\"21708\",\"count\":1,\"chance\":\"5000\"},{\"id\":\"2145\",\"count\":\"5\",\"chance\":\"50000\"},{\"id\":\"2144\",\"count\":\"5\",\"chance\":\"50000\"},{\"id\":\"2146\",\"count\":\"5\",\"chance\":\"50000\"},{\"id\":\"2149\",\"count\":\"5\",\"chance\":\"50000\"},{\"id\":\"2153\",\"count\":1,\"chance\":\"10000\"}]'),
(2098, 0, 'The Pit Lord', 0, 2500, 5270, 25, 1, '[\"I\'LL GET YOU ALL!\",\"I won\'t let you escape!\",\"I\'ll crush you beneath my feet!\"]', '[\"outfit\",\"drunk\",\"invisible\"]', 0, 0, 'blood', '[]'),
(2099, 0, 'The Plasmother', 0, 12000, 7500, 45, 0, '[\"Blubb\"]', '[\"earth\",\"lifedrain\",\"paralyze\",\"invisible\"]', 0, 0, 'venom', '[{\"id\":2144,\"count\":\"3\",\"chance\":\"5000\"},{\"id\":2146,\"count\":\"3\",\"chance\":\"5000\"},{\"id\":2148,\"count\":\"70\",\"chance\":\"20000\"},{\"id\":2148,\"count\":\"60\",\"chance\":\"20000\"},{\"id\":2148,\"count\":\"45\",\"chance\":\"20000\"},{\"id\":2152,\"count\":\"13\",\"chance\":\"25000\"},{\"id\":5944,\"count\":1,\"chance\":\"35000\"},{\"id\":6500,\"count\":1,\"chance\":\"45000\"},{\"id\":6535,\"count\":1,\"chance\":\"100000\"}]'),
(2100, 0, 'The Ruthless Herald', 0, 0, 100, 1, 0, '[\"I am so proud of my son Orshabaal.\",\"Have you heard, the imperor is marrying an imp named April? What a fool.\",\"The Ruthless Seven are going to make the easter bunny an honorary member!\",\"They are coming ... perhaps for YOU!\",\"Beware! The Ruthless Seven are coming!\",\"Killing me is imp-ossible, because I am imp-roved! I am immune to any imp-act!\",\"The one who kills me gets an imp-outfit.\",\"Hey you! I\'ve heard that! You\'re first to die when the masters come.\",\"Nice to meet you. I am Harold, the ruthless herald.\",\"Have you seen my friend Harvey? I could swear he\'s somewhere around.\",\"My masters are on their way!\"]', '[\"physical\",\"energy\",\"fire\",\"earth\",\"drown\",\"ice\",\"holy\",\"death\",\"lifedrain\",\"manadrain\",\"paralyze\",\"drunk\",\"invisible\"]', 0, 0, 'fire', '[]'),
(2101, 0, 'The Snapper', 0, 150, 300, 10, 0, '[]', '[\"paralyze\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":2148,\"count\":\"100\",\"chance\":\"50675\"},{\"id\":2148,\"count\":\"94\",\"chance\":\"50675\"},{\"id\":2168,\"count\":1,\"chance\":\"100000\"},{\"id\":2463,\"count\":1,\"chance\":\"35800\"},{\"id\":2476,\"count\":1,\"chance\":\"4025\"},{\"id\":2647,\"count\":1,\"chance\":\"44025\"},{\"id\":3982,\"count\":1,\"chance\":\"9900\"},{\"id\":7618,\"count\":\"5\",\"chance\":\"51100\"}]'),
(2102, 0, 'The Weakened Count', 0, 450, 740, 9, 1, '[\"1... 2... 2... Uh, can\'t concentrate.\"]', '[\"lifedrain\",\"paralyze\",\"invisible\",\"earth\",\"death\"]', 0, 0, 'undead', '[{\"id\":2148,\"count\":\"92\",\"chance\":\"100000\"},{\"id\":8752,\"count\":1,\"chance\":\"100000\"},{\"id\":10602,\"count\":1,\"chance\":\"7600\"},{\"id\":12405,\"count\":1,\"chance\":\"5100\"},{\"id\":\"2747\",\"count\":1,\"chance\":\"1910\"},{\"id\":2144,\"count\":1,\"chance\":\"1800\"},{\"id\":7588,\"count\":1,\"chance\":\"1500\"},{\"id\":2412,\"count\":1,\"chance\":\"1560\"},{\"id\":2383,\"count\":1,\"chance\":\"1000\"},{\"id\":\"2229\",\"count\":1,\"chance\":\"1000\"},{\"id\":2396,\"count\":1,\"chance\":\"470\"},{\"id\":2479,\"count\":1,\"chance\":\"420\"},{\"id\":2172,\"count\":1,\"chance\":\"230\"},{\"id\":2127,\"count\":1,\"chance\":\"210\"},{\"id\":2534,\"count\":1,\"chance\":\"200\"}]'),
(2103, 0, 'Thief', 0, 5, 60, 1, 0, '[\"Alarm!\",\"Don\'t let him escape!\",\"Intruder! Get him!\",\"You dare stealing from us?\"]', '[\"invisible\"]', 0, 0, 'blood', '[]'),
(2104, 0, 'Thornback Tortoise', 490, 150, 300, 1, 0, '[]', '[]', 0, 1, 'blood', '[{\"id\":2143,\"count\":1,\"chance\":\"1600\"},{\"id\":2144,\"count\":1,\"chance\":\"800\"},{\"id\":2148,\"count\":\"48\",\"chance\":\"89500\"},{\"id\":2391,\"count\":1,\"chance\":\"260\"},{\"id\":\"2667\",\"count\":\"2\",\"chance\":\"10800\"},{\"id\":2787,\"count\":1,\"chance\":\"1200\"},{\"id\":2789,\"count\":1,\"chance\":\"700\"},{\"id\":5678,\"count\":\"3\",\"chance\":\"790\"},{\"id\":5899,\"count\":1,\"chance\":\"800\"},{\"id\":7618,\"count\":1,\"chance\":\"1600\"},{\"id\":10560,\"count\":1,\"chance\":\"15980\"}]'),
(2105, 0, 'Thornfire Wolf', 0, 200, 600, 15, 0, '[]', '[\"fire\",\"invisible\",\"paralyze\"]', 0, 0, 'energy', '[{\"id\":2148,\"count\":\"53\",\"chance\":\"64000\"},{\"id\":2666,\"count\":1,\"chance\":\"34000\"},{\"id\":5897,\"count\":1,\"chance\":\"7900\"},{\"id\":7840,\"count\":\"8\",\"chance\":\"15000\"},{\"id\":10553,\"count\":1,\"chance\":\"7900\"}]'),
(2106, 0, 'Thul', 670, 2700, 2950, 150, 0, '[\"Gaaahhh!\"]', '[\"lifedrain\",\"ice\",\"earth\"]', 0, 0, 'blood', '[{\"id\":2148,\"count\":\"77\",\"chance\":\"50000\"},{\"id\":2670,\"count\":1,\"chance\":\"25000\"},{\"id\":5895,\"count\":1,\"chance\":\"100000\"},{\"id\":7383,\"count\":1,\"chance\":\"50000\"}]'),
(2107, 0, 'Tiger', 420, 40, 75, 1, 1, '[]', '[]', 1, 1, 'blood', '[{\"id\":2666,\"count\":\"4\",\"chance\":\"35190\"},{\"id\":11210,\"count\":1,\"chance\":\"10830\"}]'),
(2108, 0, 'Tiquandas Revenge', 0, 2635, 1800, 110, 0, '[]', '[\"earth\",\"invisible\"]', 0, 0, 'venom', '[{\"id\":\"5015\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"7732\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2148\",\"count\":\"118\",\"chance\":\"87234\"},{\"id\":\"2666\",\"count\":1,\"chance\":\"70213\"},{\"id\":\"2671\",\"count\":1,\"chance\":\"38298\"},{\"id\":\"2792\",\"count\":\"5\",\"chance\":\"21277\"},{\"id\":\"13298\",\"count\":1,\"chance\":\"12766\"}]'),
(2109, 0, 'Tirecz', 0, 6000, 25000, 1, 0, '[\"Hissss!\"]', '[\"paralyze\",\"invisible\"]', 0, 0, 'blood', '[]'),
(2110, 0, 'Toad', 400, 60, 135, 1, 1, '[\"Ribbit, ribbit!\",\"Ribbit!\"]', '[]', 1, 0, 'blood', '[{\"id\":2148,\"count\":\"20\",\"chance\":\"80000\"},{\"id\":2391,\"count\":1,\"chance\":\"148\"},{\"id\":2398,\"count\":1,\"chance\":\"2854\"},{\"id\":\"2667\",\"count\":1,\"chance\":\"20000\"},{\"id\":10557,\"count\":1,\"chance\":\"4761\"}]'),
(2111, 0, 'Tomb Servant', 0, 215, 475, 1, 0, '[\"Chaarr!!\",\"Ngl..Nglll...Gll\"]', '[\"death\",\"earth\",\"invisible\"]', 0, 0, 'undead', '[{\"id\":2148,\"count\":\"100\",\"chance\":\"41000\"},{\"id\":2148,\"count\":\"8\",\"chance\":\"41000\"},{\"id\":2159,\"count\":1,\"chance\":\"8210\"},{\"id\":2227,\"count\":1,\"chance\":\"2000\"},{\"id\":\"2230\",\"count\":1,\"chance\":\"49000\"},{\"id\":2397,\"count\":1,\"chance\":\"6560\"},{\"id\":2541,\"count\":1,\"chance\":\"5300\"},{\"id\":3976,\"count\":\"12\",\"chance\":\"25325\"},{\"id\":11200,\"count\":1,\"chance\":\"1000\"},{\"id\":13535,\"count\":1,\"chance\":\"230\"}]'),
(2112, 0, 'Tormented Ghost', 0, 5, 210, 1, 0, '[\"Haaahhh!\",\"Grrglll\"]', '[\"earth\",\"death\",\"physical\",\"lifedrain\",\"paralyze\",\"invisible\"]', 0, 0, 'undead', '[]'),
(2113, 0, 'Tortoise', 445, 90, 185, 1, 0, '[]', '[]', 0, 1, 'blood', '[{\"id\":2148,\"count\":\"30\",\"chance\":\"59000\"},{\"id\":2417,\"count\":1,\"chance\":\"730\"},{\"id\":2510,\"count\":1,\"chance\":\"2850\"},{\"id\":\"2667\",\"count\":1,\"chance\":\"4600\"},{\"id\":5678,\"count\":\"2\",\"chance\":\"770\"},{\"id\":5899,\"count\":1,\"chance\":\"1300\"},{\"id\":6131,\"count\":1,\"chance\":\"200\"}]'),
(2114, 0, 'Tremorak', 0, 1300, 10000, 35, 0, '[\"STOMP STOMP!\"]', '[\"earth\",\"invisible\"]', 0, 0, 'undead', '[]'),
(2115, 0, 'Troll Champion', 340, 40, 75, 1, 0, '[\"Meee maity!\",\"Grrrr\",\"Whaaaz up!?\",\"Gruntz!\",\"Groar\"]', '[]', 1, 1, 'blood', '[{\"id\":\"2148\",\"count\":\"12\",\"chance\":\"64606\"},{\"id\":\"2389\",\"count\":1,\"chance\":\"25082\"},{\"id\":\"2666\",\"count\":1,\"chance\":\"9962\"},{\"id\":\"2643\",\"count\":1,\"chance\":\"9936\"},{\"id\":\"2512\",\"count\":1,\"chance\":\"5322\"},{\"id\":\"2544\",\"count\":\"5\",\"chance\":\"5069\"},{\"id\":\"2448\",\"count\":1,\"chance\":\"5069\"},{\"id\":\"10606\",\"count\":1,\"chance\":\"3075\"},{\"id\":\"12471\",\"count\":1,\"chance\":\"909\"},{\"id\":\"2170\",\"count\":1,\"chance\":\"127\"}]'),
(2116, 0, 'Troll Guard', 0, 25, 60, 1, 0, '[]', '[]', 0, 0, 'blood', '[{\"id\":\"2120\",\"count\":1,\"chance\":\"10000\"},{\"id\":2148,\"count\":\"12\",\"chance\":\"58000\"},{\"id\":2448,\"count\":1,\"chance\":\"3000\"},{\"id\":2666,\"count\":\"2\",\"chance\":\"14000\"}]'),
(2117, 0, 'Troll Legionnaire', 0, 140, 210, 1, 0, '[\"Attack!\",\"Graaaaar!\"]', '[\"invisible\"]', 0, 0, 'blood', '[{\"id\":2148,\"count\":\"100\",\"chance\":\"46000\"},{\"id\":2148,\"count\":\"55\",\"chance\":\"46000\"},{\"id\":2165,\"count\":1,\"chance\":\"560\"},{\"id\":2399,\"count\":\"10\",\"chance\":\"28000\"},{\"id\":10565,\"count\":1,\"chance\":\"5120\"}]'),
(2118, 0, 'Troll', 290, 20, 50, 1, 0, '[\"Grrrr\",\"Groar\",\"Gruntz!\",\"Hmmm, bugs\",\"Hmmm, dogs\"]', '[]', 1, 1, 'blood', '[{\"id\":\"2148\",\"count\":\"12\",\"chance\":\"65542\"},{\"id\":\"2380\",\"count\":1,\"chance\":\"19690\"},{\"id\":\"2666\",\"count\":1,\"chance\":\"15431\"},{\"id\":\"2389\",\"count\":1,\"chance\":\"12998\"},{\"id\":\"2461\",\"count\":1,\"chance\":\"11892\"},{\"id\":\"2643\",\"count\":1,\"chance\":\"9983\"},{\"id\":\"2120\",\"count\":1,\"chance\":\"8131\"},{\"id\":\"2448\",\"count\":1,\"chance\":\"5448\"},{\"id\":\"2512\",\"count\":1,\"chance\":\"5448\"},{\"id\":\"10606\",\"count\":1,\"chance\":\"1189\"}]'),
(2119, 0, 'Undead Cavebear', 0, 600, 450, 15, 0, '[]', '[\"death\",\"earth\",\"paralyze\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":2148,\"count\":\"80\",\"chance\":\"9750\"},{\"id\":13291,\"count\":1,\"chance\":\"900\"},{\"id\":13302,\"count\":1,\"chance\":\"2350\"},{\"id\":13303,\"count\":1,\"chance\":\"3150\"}]'),
(2120, 0, 'Undead Dragon', 0, 7200, 8350, 55, 0, '[\"FEEEED MY ETERNAL HUNGER!\",\"I SENSE LIFE\"]', '[\"fire\",\"earth\",\"death\",\"paralyze\",\"invisible\",\"drown\"]', 0, 0, 'undead', '[{\"id\":\"2148\",\"count\":\"200\",\"chance\":\"100000\"},{\"id\":\"2152\",\"count\":\"5\",\"chance\":\"49699\"},{\"id\":\"11233\",\"count\":1,\"chance\":\"33778\"},{\"id\":\"2146\",\"count\":\"2\",\"chance\":\"27571\"},{\"id\":\"7368\",\"count\":\"5\",\"chance\":\"25090\"},{\"id\":\"7590\",\"count\":\"3\",\"chance\":\"24723\"},{\"id\":\"7591\",\"count\":\"3\",\"chance\":\"24647\"},{\"id\":\"2144\",\"count\":\"2\",\"chance\":\"22363\"},{\"id\":\"6500\",\"count\":1,\"chance\":\"15402\"},{\"id\":\"5925\",\"count\":1,\"chance\":\"15320\"},{\"id\":\"2547\",\"count\":\"15\",\"chance\":\"14573\"},{\"id\":\"2033\",\"count\":1,\"chance\":\"5126\"},{\"id\":\"2476\",\"count\":1,\"chance\":\"4904\"},{\"id\":\"7430\",\"count\":1,\"chance\":\"4138\"},{\"id\":\"6300\",\"count\":1,\"chance\":\"1822\"},{\"id\":\"2177\",\"count\":1,\"chance\":\"1588\"},{\"id\":\"2454\",\"count\":1,\"chance\":\"1329\"},{\"id\":\"2498\",\"count\":1,\"chance\":\"1120\"},{\"id\":\"2158\",\"count\":1,\"chance\":\"1095\"},{\"id\":\"9971\",\"count\":1,\"chance\":\"1031\"},{\"id\":\"7402\",\"count\":1,\"chance\":\"993\"},{\"id\":\"11355\",\"count\":1,\"chance\":\"924\"},{\"id\":\"2466\",\"count\":1,\"chance\":\"658\"},{\"id\":\"8885\",\"count\":1,\"chance\":\"437\"},{\"id\":\"8889\",\"count\":1,\"chance\":\"304\"}]'),
(2121, 0, 'Undead Gladiator', 0, 800, 1000, 1, 0, '[\"Let\'s battle it out in a duel!\",\"Bring it!\",\"I\'ll fight here in eternity and beyond.\",\"I will not give up!\",\"Another foolish adventurer who tries to beat me.\"]', '[\"invisible\"]', 0, 0, 'undead', '[{\"id\":\"2148\",\"count\":\"149\",\"chance\":\"95314\"},{\"id\":\"2399\",\"count\":\"18\",\"chance\":\"14874\"},{\"id\":\"2419\",\"count\":1,\"chance\":\"10743\"},{\"id\":\"8872\",\"count\":1,\"chance\":\"5209\"},{\"id\":\"10573\",\"count\":1,\"chance\":\"5201\"},{\"id\":\"2478\",\"count\":1,\"chance\":\"4923\"},{\"id\":\"2465\",\"count\":1,\"chance\":\"4820\"},{\"id\":\"3965\",\"count\":1,\"chance\":\"4519\"},{\"id\":\"2647\",\"count\":1,\"chance\":\"2268\"},{\"id\":\"2463\",\"count\":1,\"chance\":\"2244\"},{\"id\":\"2377\",\"count\":1,\"chance\":\"1982\"},{\"id\":\"2200\",\"count\":1,\"chance\":\"1927\"},{\"id\":\"2490\",\"count\":1,\"chance\":\"1395\"},{\"id\":\"7618\",\"count\":1,\"chance\":\"404\"},{\"id\":\"2430\",\"count\":1,\"chance\":\"246\"},{\"id\":\"2497\",\"count\":1,\"chance\":\"182\"},{\"id\":\"5885\",\"count\":1,\"chance\":\"166\"},{\"id\":\"2165\",\"count\":1,\"chance\":\"48\"}]'),
(2122, 0, 'Undead Jester', 0, 5, 355, 2, 0, '[\"Who\'s bad?\",\"I have a cunning plan!\",\"Resistance is futile! You will be amused!\",\"Pull my finger!\",\"Why did the chicken cross the road? TO KILL YOU!!!\",\"I will teach you all to mock me!\",\"He who laughs last, Laughs best!\",\"Th-Th-Th-That\'s all, folks!\",\"A zathroth priest, a druid and a paladin walk into a bar ...Ha Ha!\",\"Doh!\",\"Zathroth made me do it!\",\"And now for something completely different!\",\"You think this is funny now?\",\"Are we having fun yet?\",\"Did I do that?\"]', '[\"death\",\"earth\",\"drunk\",\"paralyze\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2667\",\"count\":1,\"chance\":\"60000\"},{\"id\":\"9108\",\"count\":1,\"chance\":\"40000\"},{\"id\":\"9696\",\"count\":1,\"chance\":\"1000\"},{\"id\":\"9697\",\"count\":1,\"chance\":\"1000\"},{\"id\":\"9698\",\"count\":1,\"chance\":\"1000\"},{\"id\":\"9699\",\"count\":1,\"chance\":\"1000\"},{\"id\":\"9695\",\"count\":1,\"chance\":\"800\"},{\"id\":\"9694\",\"count\":1,\"chance\":\"400\"},{\"id\":5909,\"count\":1,\"chance\":\"1400\"},{\"id\":5913,\"count\":1,\"chance\":\"1100\"},{\"id\":5910,\"count\":1,\"chance\":\"1000\"},{\"id\":7158,\"count\":1,\"chance\":\"1000\"},{\"id\":5912,\"count\":1,\"chance\":\"900\"},{\"id\":7159,\"count\":1,\"chance\":\"900\"},{\"id\":5914,\"count\":1,\"chance\":\"700\"},{\"id\":5911,\"count\":1,\"chance\":\"500\"},{\"id\":7963,\"count\":1,\"chance\":\"200\"}]'),
(2123, 0, 'Undead Mine Worker', 0, 45, 65, 1, 0, '[]', '[\"death\"]', 0, 0, 'undead', '[{\"id\":2148,\"count\":\"10\",\"chance\":\"73000\"},{\"id\":\"2230\",\"count\":1,\"chance\":\"42000\"},{\"id\":\"2376\",\"count\":1,\"chance\":\"3850\"},{\"id\":2398,\"count\":1,\"chance\":\"26900\"},{\"id\":2787,\"count\":\"3\",\"chance\":\"15400\"},{\"id\":2789,\"count\":1,\"chance\":\"3850\"}]'),
(2124, 0, 'Undead Minion', 620, 550, 850, 5, 0, '[]', '[\"fire\",\"earth\",\"lifedrain\",\"drunk\"]', 0, 1, 'undead', '[{\"id\":2148,\"count\":\"40\",\"chance\":\"100000\"},{\"id\":2260,\"count\":1,\"chance\":\"10000\"},{\"id\":2417,\"count\":1,\"chance\":\"5000\"},{\"id\":2513,\"count\":1,\"chance\":\"1000\"},{\"id\":2515,\"count\":1,\"chance\":\"5000\"},{\"id\":\"6570\",\"count\":1,\"chance\":\"5538\"},{\"id\":\"6571\",\"count\":1,\"chance\":\"1538\"}]'),
(2125, 0, 'Undead Prospector', 440, 85, 100, 1, 0, '[\"Our mine... leave us alone.\",\"Turn back...\",\"These mine is ours... you shall not pass.\"]', '[\"lifedrain\",\"death\",\"drown\"]', 1, 1, 'blood', '[{\"id\":\"3976\",\"count\":\"6\",\"chance\":\"80636\"},{\"id\":\"2148\",\"count\":\"30\",\"chance\":\"71225\"},{\"id\":\"2050\",\"count\":1,\"chance\":\"61070\"},{\"id\":\"2460\",\"count\":1,\"chance\":\"18551\"},{\"id\":\"2403\",\"count\":1,\"chance\":\"14760\"},{\"id\":\"2473\",\"count\":1,\"chance\":\"5349\"},{\"id\":\"2483\",\"count\":1,\"chance\":\"3588\"},{\"id\":\"2229\",\"count\":1,\"chance\":\"2708\"},{\"id\":\"5913\",\"count\":1,\"chance\":\"948\"},{\"id\":\"2168\",\"count\":1,\"chance\":\"135\"}]'),
(2126, 0, 'Ungreez', 0, 500, 8200, 55, 0, '[\"I\'ll teach you that even heros can die\",\"You wil die Begging like the others did\"]', '[\"energy\",\"fire\",\"lifedrain\",\"paralyze\",\"outfit\",\"drunk\",\"invisible\"]', 0, 0, 'fire', '[{\"id\":2148,\"count\":\"90\",\"chance\":\"21000\"},{\"id\":2795,\"count\":\"6\",\"chance\":\"10000\"},{\"id\":7590,\"count\":1,\"chance\":\"20000\"},{\"id\":7591,\"count\":1,\"chance\":\"20000\"}]'),
(2127, 0, 'Ushuriel', 0, 10000, 31500, 110, 1, '[\"You can\'t run or hide forever!\",\"I\'m the executioner of the Seven!\",\"The final punishment awaits you!\",\"The judgement is guilty! The sentence is death!\"]', '[\"death\",\"lifedrain\",\"paralyze\",\"invisible\"]', 0, 0, 'fire', '[{\"id\":\"6500\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2789\",\"count\":\"30\",\"chance\":\"96863\"},{\"id\":\"2148\",\"count\":\"190\",\"chance\":\"96863\"},{\"id\":\"5880\",\"count\":1,\"chance\":\"43922\"},{\"id\":\"5925\",\"count\":\"20\",\"chance\":\"28235\"},{\"id\":\"8473\",\"count\":1,\"chance\":\"26667\"},{\"id\":\"7591\",\"count\":1,\"chance\":\"25490\"},{\"id\":\"2498\",\"count\":1,\"chance\":\"25294\"},{\"id\":\"8472\",\"count\":1,\"chance\":\"23725\"},{\"id\":\"2177\",\"count\":1,\"chance\":\"21176\"},{\"id\":\"7590\",\"count\":1,\"chance\":\"20980\"},{\"id\":\"5741\",\"count\":1,\"chance\":\"20980\"},{\"id\":\"2152\",\"count\":\"30\",\"chance\":\"20784\"},{\"id\":\"9971\",\"count\":1,\"chance\":\"20196\"},{\"id\":\"2178\",\"count\":1,\"chance\":\"20196\"},{\"id\":\"5669\",\"count\":1,\"chance\":\"20000\"},{\"id\":\"2475\",\"count\":1,\"chance\":\"19412\"},{\"id\":\"7391\",\"count\":1,\"chance\":\"19216\"},{\"id\":\"2392\",\"count\":1,\"chance\":\"18824\"},{\"id\":\"2176\",\"count\":1,\"chance\":\"17647\"},{\"id\":\"9810\",\"count\":1,\"chance\":\"16471\"},{\"id\":\"5892\",\"count\":1,\"chance\":\"14510\"},{\"id\":\"2393\",\"count\":1,\"chance\":\"11961\"},{\"id\":\"2419\",\"count\":1,\"chance\":\"10980\"},{\"id\":\"5954\",\"count\":\"2\",\"chance\":\"10784\"},{\"id\":\"2383\",\"count\":1,\"chance\":\"10196\"},{\"id\":\"7402\",\"count\":1,\"chance\":\"10000\"},{\"id\":\"7385\",\"count\":1,\"chance\":\"9216\"},{\"id\":\"2491\",\"count\":1,\"chance\":\"9020\"},{\"id\":\"2479\",\"count\":1,\"chance\":\"9020\"},{\"id\":\"7417\",\"count\":1,\"chance\":\"8431\"},{\"id\":\"5891\",\"count\":1,\"chance\":\"5686\"},{\"id\":\"5884\",\"count\":1,\"chance\":\"5098\"},{\"id\":\"6103\",\"count\":1,\"chance\":\"4118\"},{\"id\":\"5885\",\"count\":1,\"chance\":\"3725\"}]'),
(2128, 0, 'Valkyrie', 450, 85, 190, 1, 0, '[\"Another head for me!\",\"Head off!\",\"Your head will be mine!\",\"Stand still!\",\"One more head for me!\"]', '[]', 1, 1, 'blood', '[{\"id\":2389,\"count\":\"3\",\"chance\":\"55000\"},{\"id\":2148,\"count\":\"12\",\"chance\":\"32000\"},{\"id\":2666,\"count\":1,\"chance\":\"30100\"},{\"id\":2464,\"count\":1,\"chance\":\"10000\"},{\"id\":2674,\"count\":\"2\",\"chance\":\"7500\"},{\"id\":12399,\"count\":1,\"chance\":\"6000\"},{\"id\":3965,\"count\":1,\"chance\":\"5155\"},{\"id\":12400,\"count\":1,\"chance\":\"3200\"},{\"id\":2200,\"count\":1,\"chance\":\"1100\"},{\"id\":2463,\"count\":1,\"chance\":\"820\"},{\"id\":\"2229\",\"count\":1,\"chance\":\"740\"},{\"id\":7618,\"count\":1,\"chance\":\"500\"},{\"id\":2387,\"count\":1,\"chance\":\"420\"},{\"id\":2145,\"count\":1,\"chance\":\"200\"}]'),
(2129, 0, 'Vampire Bride', 0, 1050, 1200, 5, 0, '[\"Kneel before your Mistress!\",\"Dead is the new alive.\",\"Come, let me kiss you, darling. Oh wait, I meant kill.\",\"Enjoy the pain - I know you love it.\",\"Are you suffering nicely enough?\",\"You won\'t regret you came to me, sweetheart.\"]', '[\"death\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":2127,\"count\":1,\"chance\":\"1100\"},{\"id\":2145,\"count\":\"2\",\"chance\":\"1020\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"45000\"},{\"id\":2148,\"count\":\"49\",\"chance\":\"45000\"},{\"id\":2152,\"count\":1,\"chance\":\"9910\"},{\"id\":2186,\"count\":1,\"chance\":\"5500\"},{\"id\":2195,\"count\":1,\"chance\":\"220\"},{\"id\":5670,\"count\":1,\"chance\":\"170\"},{\"id\":7588,\"count\":1,\"chance\":\"5000\"},{\"id\":7589,\"count\":1,\"chance\":\"10210\"},{\"id\":\"7733\",\"count\":1,\"chance\":\"200\"},{\"id\":8873,\"count\":1,\"chance\":\"1030\"},{\"id\":9447,\"count\":1,\"chance\":\"60\"},{\"id\":\"9809\",\"count\":1,\"chance\":\"1010\"},{\"id\":\"9837\",\"count\":1,\"chance\":\"970\"},{\"id\":10602,\"count\":1,\"chance\":\"10000\"},{\"id\":12405,\"count\":1,\"chance\":\"4950\"},{\"id\":13293,\"count\":1,\"chance\":\"20\"}]'),
(2130, 0, 'Vampire Pig', 0, 165, 305, 40, 0, '[\"Oink\",\"Oink oink\"]', '[\"lifedrain\",\"drown\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":2148,\"count\":\"40\",\"chance\":\"90000\"}]'),
(2131, 0, 'Vampire Viscount', 0, 800, 1200, 1, 1, '[\"Prepare to BLEED!\",\"Don\'t struggle. We don\'t want to waste a drop of blood now, do we?\",\"Ah, refreshments have arrived!\"]', '[\"invisible\",\"paralyze\",\"death\",\"earth\"]', 0, 0, 'blood', '[{\"id\":\"2148\",\"count\":\"50\",\"chance\":\"84797\"},{\"id\":\"10602\",\"count\":1,\"chance\":\"7712\"},{\"id\":\"7589\",\"count\":1,\"chance\":\"7447\"},{\"id\":\"7588\",\"count\":1,\"chance\":\"6103\"},{\"id\":\"21241\",\"count\":1,\"chance\":\"5321\"},{\"id\":\"21244\",\"count\":1,\"chance\":\"3922\"},{\"id\":\"2147\",\"count\":\"2\",\"chance\":\"3338\"},{\"id\":\"12405\",\"count\":1,\"chance\":\"2930\"},{\"id\":\"2144\",\"count\":1,\"chance\":\"2666\"},{\"id\":\"2396\",\"count\":1,\"chance\":\"815\"},{\"id\":\"2156\",\"count\":1,\"chance\":\"364\"},{\"id\":\"5911\",\"count\":1,\"chance\":\"275\"},{\"id\":\"2534\",\"count\":1,\"chance\":\"209\"}]'),
(2132, 0, 'Vampire', 0, 305, 475, 9, 1, '[\"BLOOD!\",\"Let me kiss your neck\",\"I smell warm blood!\",\"I call you, my bats! Come!\"]', '[\"lifedrain\",\"paralyze\",\"invisible\",\"earth\",\"death\",\"drown\",\"drunk\"]', 0, 0, 'undead', '[{\"id\":2148,\"count\":\"60\",\"chance\":\"90230\"},{\"id\":10602,\"count\":1,\"chance\":\"7600\"},{\"id\":12405,\"count\":1,\"chance\":\"5100\"},{\"id\":\"2747\",\"count\":1,\"chance\":\"1910\"},{\"id\":2144,\"count\":1,\"chance\":\"1800\"},{\"id\":7588,\"count\":1,\"chance\":\"1500\"},{\"id\":2412,\"count\":1,\"chance\":\"1560\"},{\"id\":2383,\"count\":1,\"chance\":\"1000\"},{\"id\":\"2229\",\"count\":1,\"chance\":\"1000\"},{\"id\":2396,\"count\":1,\"chance\":\"470\"},{\"id\":2479,\"count\":1,\"chance\":\"420\"},{\"id\":2172,\"count\":1,\"chance\":\"230\"},{\"id\":2127,\"count\":1,\"chance\":\"210\"},{\"id\":2534,\"count\":1,\"chance\":\"200\"}]'),
(2133, 0, 'Vashresamun', 0, 2950, 4000, 60, 1, '[\"If music is the food of death, drop dead.\",\"Are you enjoying my music?\",\"Come my maidens, we have visitors!\",\"Chakka Chakka!\",\"Heheheheee!\"]', '[\"death\",\"invisible\"]', 0, 0, 'undead', '[{\"id\":2349,\"count\":1,\"chance\":\"100000\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"31000\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"31000\"},{\"id\":2148,\"count\":\"50\",\"chance\":\"31000\"},{\"id\":2143,\"count\":1,\"chance\":\"10000\"},{\"id\":\"2072\",\"count\":1,\"chance\":\"9200\"},{\"id\":7590,\"count\":1,\"chance\":\"8000\"},{\"id\":2656,\"count\":1,\"chance\":\"1200\"},{\"id\":2445,\"count\":1,\"chance\":\"1000\"},{\"id\":\"2124\",\"count\":1,\"chance\":\"1000\"},{\"id\":\"2074\",\"count\":1,\"chance\":\"330\"},{\"id\":2139,\"count\":1,\"chance\":\"170\"},{\"id\":11207,\"count\":1,\"chance\":\"170\"}]'),
(2134, 0, 'Verminor', 0, 35000, 80000, 80, 1, '[\"BOW TO THE POWER OF THE RUTHLESS SEVEN!\",\"DESTRUCTION!\",\"CHAOS!\",\"DEATH TO ALL!\"]', '[\"energy\",\"fire\",\"earth\",\"lifedrain\",\"paralyze\",\"outfit\",\"drunk\",\"invisible\"]', 0, 0, 'fire', '[{\"id\":1982,\"count\":1,\"chance\":\"2600\"},{\"id\":2033,\"count\":1,\"chance\":\"7500\"},{\"id\":2112,\"count\":1,\"chance\":\"14500\"},{\"id\":2123,\"count\":1,\"chance\":\"3500\"},{\"id\":\"2124\",\"count\":1,\"chance\":\"5500\"},{\"id\":2125,\"count\":1,\"chance\":\"1500\"},{\"id\":\"2142\",\"count\":1,\"chance\":\"3500\"},{\"id\":2143,\"count\":\"15\",\"chance\":\"12500\"},{\"id\":2144,\"count\":\"15\",\"chance\":\"15000\"},{\"id\":2145,\"count\":\"5\",\"chance\":\"9500\"},{\"id\":2146,\"count\":\"10\",\"chance\":\"13500\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"99900\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"88800\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"77700\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"66600\"},{\"id\":2149,\"count\":\"10\",\"chance\":\"15500\"},{\"id\":2150,\"count\":\"20\",\"chance\":\"13500\"},{\"id\":2151,\"count\":\"7\",\"chance\":\"14000\"},{\"id\":2155,\"count\":1,\"chance\":\"1500\"},{\"id\":2158,\"count\":1,\"chance\":\"1500\"},{\"id\":\"2162\",\"count\":1,\"chance\":\"11500\"},{\"id\":2164,\"count\":1,\"chance\":\"5000\"},{\"id\":2165,\"count\":1,\"chance\":\"9500\"},{\"id\":2167,\"count\":1,\"chance\":\"13500\"},{\"id\":2170,\"count\":1,\"chance\":\"13000\"},{\"id\":2171,\"count\":1,\"chance\":\"4500\"},{\"id\":2174,\"count\":1,\"chance\":\"2500\"},{\"id\":2176,\"count\":1,\"chance\":\"12000\"},{\"id\":2177,\"count\":1,\"chance\":\"1000\"},{\"id\":\"2178\",\"count\":1,\"chance\":\"4000\"},{\"id\":2179,\"count\":1,\"chance\":\"8000\"},{\"id\":2182,\"count\":1,\"chance\":\"3500\"},{\"id\":2185,\"count\":1,\"chance\":\"3500\"},{\"id\":2186,\"count\":1,\"chance\":\"3500\"},{\"id\":2188,\"count\":1,\"chance\":\"2500\"},{\"id\":\"2192\",\"count\":1,\"chance\":\"2500\"},{\"id\":2195,\"count\":1,\"chance\":\"4000\"},{\"id\":2197,\"count\":1,\"chance\":\"4000\"},{\"id\":2200,\"count\":1,\"chance\":\"4500\"},{\"id\":2214,\"count\":1,\"chance\":\"13000\"},{\"id\":\"2231\",\"count\":1,\"chance\":\"9000\"},{\"id\":2377,\"count\":1,\"chance\":\"20000\"},{\"id\":2387,\"count\":1,\"chance\":\"20000\"},{\"id\":2393,\"count\":1,\"chance\":\"12500\"},{\"id\":2396,\"count\":1,\"chance\":\"7500\"},{\"id\":2402,\"count\":1,\"chance\":\"15500\"},{\"id\":2418,\"count\":1,\"chance\":\"4500\"},{\"id\":2421,\"count\":1,\"chance\":\"13500\"},{\"id\":2432,\"count\":1,\"chance\":\"17000\"},{\"id\":2434,\"count\":1,\"chance\":\"4500\"},{\"id\":2436,\"count\":1,\"chance\":\"5000\"},{\"id\":2462,\"count\":1,\"chance\":\"11000\"},{\"id\":2470,\"count\":1,\"chance\":\"5000\"},{\"id\":2472,\"count\":1,\"chance\":\"3000\"},{\"id\":\"2514\",\"count\":1,\"chance\":\"7500\"},{\"id\":2520,\"count\":1,\"chance\":\"15500\"},{\"id\":\"3955\",\"count\":1,\"chance\":\"100\"}]'),
(2135, 0, 'Versperoth', 0, 20000, 100000, 1, 0, '[\"GrrroaR!\",\"GROWL!\",\"Waaaah!\"]', '[\"paralyze\",\"invisible\"]', 0, 0, 'blood', '[]'),
(2136, 0, 'Vicious Manbat', 0, 1200, 1700, 1, 0, '[]', '[\"invisible\",\"paralyze\",\"death\",\"earth\"]', 0, 0, 'blood', '[{\"id\":2148,\"count\":\"100\",\"chance\":\"50000\"}]'),
(2137, 0, 'Vicious Squire', 0, 900, 1000, 1, 0, '[\"For hurting me, my sire will kill you!\",\"Your stuff will be mine soon!\",\"I\'ll cut you a bloody grin!\",\"You shouldn\'t have come here!\",\"You are as good as dead!\"]', '[\"paralyze\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2455\",\"count\":1,\"chance\":\"12763\"},{\"id\":\"2148\",\"count\":\"70\",\"chance\":\"100000\"},{\"id\":\"2661\",\"count\":1,\"chance\":\"743\"},{\"id\":\"2543\",\"count\":\"10\",\"chance\":\"21685\"},{\"id\":\"2666\",\"count\":1,\"chance\":\"11771\"},{\"id\":\"2145\",\"count\":1,\"chance\":\"2602\"},{\"id\":\"2149\",\"count\":1,\"chance\":\"3097\"},{\"id\":\"2150\",\"count\":1,\"chance\":\"2973\"},{\"id\":\"2391\",\"count\":1,\"chance\":\"991\"},{\"id\":\"2381\",\"count\":1,\"chance\":\"2230\"},{\"id\":\"2477\",\"count\":1,\"chance\":\"619\"},{\"id\":\"2515\",\"count\":1,\"chance\":\"247\"},{\"id\":\"2475\",\"count\":1,\"chance\":\"123\"},{\"id\":\"7591\",\"count\":1,\"chance\":\"5576\"},{\"id\":\"2164\",\"count\":1,\"chance\":\"247\"}]'),
(2138, 0, 'Vile Grandmaster', 0, 1500, 1700, 1, 0, '[\"You\'ll make a fine trophy!\",\"Is that the best, they can throw at me?\",\"I\'ve seen orcs tougher than you!\",\"I will end this now!\",\"Your gods won\'t help you!\"]', '[\"paralyze\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"12406\",\"count\":1,\"chance\":\"724\"},{\"id\":\"2148\",\"count\":\"100\",\"chance\":\"100000\"},{\"id\":\"2148\",\"count\":\"55\",\"chance\":\"60000\"},{\"id\":\"2152\",\"count\":\"2\",\"chance\":\"73188\"},{\"id\":\"2121\",\"count\":1,\"chance\":\"7246\"},{\"id\":\"12466\",\"count\":1,\"chance\":\"8695\"},{\"id\":\"2666\",\"count\":1,\"chance\":\"7971\"},{\"id\":\"2147\",\"count\":1,\"chance\":\"2173\"},{\"id\":\"2146\",\"count\":1,\"chance\":\"2173\"},{\"id\":\"2391\",\"count\":1,\"chance\":\"1449\"},{\"id\":\"5911\",\"count\":1,\"chance\":\"2898\"},{\"id\":\"2487\",\"count\":1,\"chance\":\"1449\"},{\"id\":\"2491\",\"count\":1,\"chance\":\"1449\"},{\"id\":\"2392\",\"count\":1,\"chance\":\"2173\"},{\"id\":\"7591\",\"count\":1,\"chance\":\"9420\"},{\"id\":\"2488\",\"count\":1,\"chance\":\"724\"}]'),
(2139, 0, 'Vulcongra', 0, 1100, 1600, 50, 0, '[\"Fuchah! Fuchah!\",\"Fuchah!\",\"Yag! Yag! Yag!\"]', '[\"fire\",\"earth\",\"paralyze\",\"invisible\"]', 0, 0, 'fire', '[{\"id\":\"2148\",\"count\":\"107\",\"chance\":\"100000\"},{\"id\":\"2152\",\"count\":1,\"chance\":\"14338\"},{\"id\":\"18424\",\"count\":1,\"chance\":\"12277\"},{\"id\":\"2676\",\"count\":\"10\",\"chance\":\"9563\"},{\"id\":\"10553\",\"count\":1,\"chance\":\"9041\"},{\"id\":\"18425\",\"count\":1,\"chance\":\"7893\"},{\"id\":\"7589\",\"count\":1,\"chance\":\"7319\"},{\"id\":\"7588\",\"count\":1,\"chance\":\"7280\"},{\"id\":\"18417\",\"count\":1,\"chance\":\"4945\"},{\"id\":\"2207\",\"count\":1,\"chance\":\"3053\"},{\"id\":\"18420\",\"count\":1,\"chance\":\"2401\"},{\"id\":\"2187\",\"count\":1,\"chance\":\"978\"},{\"id\":\"7890\",\"count\":1,\"chance\":\"887\"},{\"id\":\"13757\",\"count\":1,\"chance\":\"848\"},{\"id\":\"2392\",\"count\":1,\"chance\":\"300\"},{\"id\":\"7899\",\"count\":1,\"chance\":\"170\"}]'),
(2140, 0, 'Wailing Widow', 0, 450, 850, 17, 1, '[]', '[\"paralyze\",\"invisible\",\"death\",\"earth\",\"lifedrain\",\"drunk\"]', 0, 0, 'venom', '[{\"id\":\"2148\",\"count\":\"140\",\"chance\":\"96855\"},{\"id\":\"11328\",\"count\":1,\"chance\":\"19966\"},{\"id\":\"7620\",\"count\":1,\"chance\":\"5251\"},{\"id\":\"7618\",\"count\":1,\"chance\":\"4942\"},{\"id\":\"2381\",\"count\":1,\"chance\":\"4708\"},{\"id\":\"2510\",\"count\":1,\"chance\":\"3173\"},{\"id\":\"2796\",\"count\":1,\"chance\":\"2986\"},{\"id\":\"11323\",\"count\":1,\"chance\":\"2256\"},{\"id\":\"11329\",\"count\":1,\"chance\":\"683\"}]'),
(2141, 0, 'Walker', 0, 2200, 3000, 40, 0, '[\"?\"]', '[\"invisible\",\"paralyze\",\"lifedrain\"]', 0, 0, 'venom', '[{\"id\":2148,\"count\":\"100\",\"chance\":\"50000\"},{\"id\":2148,\"count\":\"99\",\"chance\":\"50000\"},{\"id\":2152,\"count\":\"3\",\"chance\":\"52000\"},{\"id\":23569,\"count\":1,\"chance\":\"20000\"},{\"id\":9970,\"count\":\"6\",\"chance\":\"10000\"},{\"id\":8472,\"count\":1,\"chance\":\"8000\"},{\"id\":7591,\"count\":1,\"chance\":\"8000\"},{\"id\":2150,\"count\":\"3\",\"chance\":\"4500\"},{\"id\":2149,\"count\":\"3\",\"chance\":\"4500\"},{\"id\":23540,\"count\":1,\"chance\":\"3500\"},{\"id\":23541,\"count\":1,\"chance\":\"2200\"},{\"id\":2445,\"count\":1,\"chance\":\"670\"},{\"id\":2645,\"count\":1,\"chance\":\"520\"}]');
INSERT INTO `myaac_monsters` (`id`, `hidden`, `name`, `mana`, `exp`, `health`, `speed_lvl`, `use_haste`, `voices`, `immunities`, `summonable`, `convinceable`, `race`, `loot`) VALUES
(2142, 0, 'War Golem', 0, 2750, 4300, 10, 1, '[\"Azerus barada nikto!\",\"Klonk klonk klonk\",\"Engaging Enemy!\",\"Threat level processed.\",\"Charging weapon systems!\",\"Auto repair in progress.\",\"The battle is joined!\",\"Termination initialized!\",\"Rrrtttarrrttarrrtta\"]', '[\"invisible\",\"paralyze\"]', 0, 0, 'energy', '[{\"id\":2148,\"count\":\"90\",\"chance\":\"37500\"},{\"id\":2148,\"count\":\"80\",\"chance\":\"37500\"},{\"id\":2177,\"count\":1,\"chance\":\"1000\"},{\"id\":2209,\"count\":1,\"chance\":\"810\"},{\"id\":2213,\"count\":1,\"chance\":\"1210\"},{\"id\":2377,\"count\":1,\"chance\":\"5500\"},{\"id\":2394,\"count\":1,\"chance\":\"7000\"},{\"id\":2438,\"count\":1,\"chance\":\"6400\"},{\"id\":2510,\"count\":1,\"chance\":\"9000\"},{\"id\":2513,\"count\":1,\"chance\":\"6500\"},{\"id\":2645,\"count\":1,\"chance\":\"620\"},{\"id\":5880,\"count\":1,\"chance\":\"1920\"},{\"id\":7403,\"count\":1,\"chance\":\"50\"},{\"id\":7422,\"count\":1,\"chance\":\"120\"},{\"id\":7428,\"count\":1,\"chance\":\"770\"},{\"id\":7439,\"count\":1,\"chance\":\"900\"},{\"id\":7590,\"count\":1,\"chance\":\"8860\"},{\"id\":7893,\"count\":1,\"chance\":\"90\"},{\"id\":8309,\"count\":\"5\",\"chance\":\"5260\"},{\"id\":8473,\"count\":1,\"chance\":\"10080\"},{\"id\":\"9809\",\"count\":1,\"chance\":\"260\"},{\"id\":\"9978\",\"count\":1,\"chance\":\"1080\"},{\"id\":9980,\"count\":1,\"chance\":\"130\"}]'),
(2143, 0, 'War Wolf', 420, 55, 140, 22, 0, '[\"Grrrrrrr\",\"Yoooohhuuuu!\"]', '[\"outfit\"]', 0, 1, 'blood', '[{\"id\":\"2671\",\"count\":1,\"chance\":\"39170\"},{\"id\":\"11235\",\"count\":1,\"chance\":\"4951\"},{\"id\":\"5897\",\"count\":1,\"chance\":\"993\"},{\"id\":\"7394\",\"count\":1,\"chance\":\"48\"}]'),
(2144, 0, 'Warlock', 0, 4000, 3500, 5, 0, '[\"Learn the secret of our magic! YOUR death!\",\"Even a rat is a better mage than you.\",\"We don\'t like intruders!\"]', '[\"fire\",\"energy\",\"ice\",\"paralyze\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2148\",\"count\":\"80\",\"chance\":\"30006\"},{\"id\":\"2679\",\"count\":\"4\",\"chance\":\"19630\"},{\"id\":\"2689\",\"count\":1,\"chance\":\"8925\"},{\"id\":\"2411\",\"count\":1,\"chance\":\"7693\"},{\"id\":\"2436\",\"count\":1,\"chance\":\"6088\"},{\"id\":\"7591\",\"count\":1,\"chance\":\"5094\"},{\"id\":\"7590\",\"count\":1,\"chance\":\"5017\"},{\"id\":\"7368\",\"count\":\"4\",\"chance\":\"3289\"},{\"id\":\"2792\",\"count\":1,\"chance\":\"2934\"},{\"id\":\"2178\",\"count\":1,\"chance\":\"2128\"},{\"id\":\"2167\",\"count\":1,\"chance\":\"1967\"},{\"id\":\"2047\",\"count\":1,\"chance\":\"1573\"},{\"id\":\"2656\",\"count\":1,\"chance\":\"1561\"},{\"id\":\"2146\",\"count\":1,\"chance\":\"1283\"},{\"id\":\"2151\",\"count\":1,\"chance\":\"1051\"},{\"id\":\"7898\",\"count\":1,\"chance\":\"1006\"},{\"id\":\"2600\",\"count\":1,\"chance\":\"935\"},{\"id\":\"2124\",\"count\":1,\"chance\":\"742\"},{\"id\":\"12410\",\"count\":1,\"chance\":\"477\"},{\"id\":\"2123\",\"count\":1,\"chance\":\"406\"},{\"id\":\"2197\",\"count\":1,\"chance\":\"355\"},{\"id\":\"1986\",\"count\":1,\"chance\":\"239\"},{\"id\":\"2466\",\"count\":1,\"chance\":\"206\"},{\"id\":\"2114\",\"count\":1,\"chance\":\"77\"}]'),
(2145, 0, 'Warlord Ruzad', 0, 1700, 2500, 25, 0, '[]', '[\"invisible\",\"paralyze\"]', 0, 0, 'blood', '[{\"id\":\"2478\",\"count\":1,\"chance\":\"50000\"},{\"id\":\"2148\",\"count\":\"54\",\"chance\":\"25000\"},{\"id\":\"2428\",\"count\":1,\"chance\":\"25000\"},{\"id\":\"2463\",\"count\":1,\"chance\":\"25000\"},{\"id\":\"2377\",\"count\":1,\"chance\":\"25000\"},{\"id\":\"2490\",\"count\":1,\"chance\":\"12500\"},{\"id\":\"3965\",\"count\":1,\"chance\":\"12500\"},{\"id\":\"2666\",\"count\":1,\"chance\":\"12500\"},{\"id\":\"2647\",\"count\":1,\"chance\":\"12500\"},{\"id\":\"2419\",\"count\":1,\"chance\":\"12500\"}]'),
(2146, 0, 'Wasp', 280, 24, 35, 50, 0, '[\"Bssssss\"]', '[\"earth\"]', 1, 0, 'venom', '[{\"id\":5902,\"count\":1,\"chance\":\"3000\"}]'),
(2147, 0, 'Waspoid', 0, 830, 1100, 1, 0, '[\"Peeex!\"]', '[\"earth\",\"invisible\"]', 0, 0, 'venom', '[{\"id\":2127,\"count\":1,\"chance\":\"2040\"},{\"id\":2144,\"count\":1,\"chance\":\"4230\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"40000\"},{\"id\":2148,\"count\":\"35\",\"chance\":\"50000\"},{\"id\":2152,\"count\":1,\"chance\":\"40430\"},{\"id\":2154,\"count\":1,\"chance\":\"1040\"},{\"id\":15483,\"count\":1,\"chance\":\"9096\"},{\"id\":15484,\"count\":1,\"chance\":\"13890\"},{\"id\":15486,\"count\":1,\"chance\":\"6060\"},{\"id\":15490,\"count\":1,\"chance\":\"230\"},{\"id\":15491,\"count\":1,\"chance\":\"120\"},{\"id\":15492,\"count\":1,\"chance\":\"330\"}]'),
(2148, 0, 'Water Buffalo', 0, 20, 390, 1, 0, '[\"Gnorrr!\",\"Gnarrr!\",\"<snort>\",\"Mrrr!\"]', '[\"earth\",\"paralyze\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2148\",\"count\":\"20\",\"chance\":\"100000\"},{\"id\":\"2666\",\"count\":1,\"chance\":\"34573\"},{\"id\":\"2671\",\"count\":1,\"chance\":\"33042\"}]'),
(2149, 0, 'Water Elemental', 0, 650, 550, 1, 1, '[]', '[\"paralyze\",\"invisible\",\"drown\",\"fire\",\"ice\",\"earth\",\"lifedrain\"]', 0, 0, 'undead', '[{\"id\":2145,\"count\":1,\"chance\":\"1000\"},{\"id\":2146,\"count\":1,\"chance\":\"1000\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"50000\"},{\"id\":2149,\"count\":\"2\",\"chance\":\"1000\"},{\"id\":2152,\"count\":1,\"chance\":\"10000\"},{\"id\":2167,\"count\":1,\"chance\":\"950\"},{\"id\":2168,\"count\":1,\"chance\":\"930\"},{\"id\":\"2667\",\"count\":1,\"chance\":\"20000\"},{\"id\":7158,\"count\":1,\"chance\":\"940\"},{\"id\":7159,\"count\":1,\"chance\":\"1050\"},{\"id\":7588,\"count\":1,\"chance\":\"10000\"},{\"id\":7589,\"count\":1,\"chance\":\"10000\"},{\"id\":\"7632\",\"count\":1,\"chance\":\"800\"},{\"id\":\"7633\",\"count\":1,\"chance\":\"800\"},{\"id\":10220,\"count\":1,\"chance\":\"260\"}]'),
(2150, 0, 'Webster', 0, 1200, 2950, 35, 1, '[\"You are lost!\",\"Come my little morsel.\"]', '[\"ice\",\"outfit\",\"drunk\",\"invisible\"]', 0, 0, 'undead', '[]'),
(2151, 0, 'Weeper', 0, 4800, 6800, 20, 0, '[\"Moooaaan!\"]', '[\"fire\",\"earth\",\"outfit\",\"drown\",\"paralyze\",\"invisible\"]', 0, 0, 'fire', '[{\"id\":2147,\"count\":\"3\",\"chance\":\"15690\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"50000\"},{\"id\":2148,\"count\":\"99\",\"chance\":\"50000\"},{\"id\":2172,\"count\":\"7\",\"chance\":\"100000\"},{\"id\":2392,\"count\":1,\"chance\":\"3280\"},{\"id\":2432,\"count\":1,\"chance\":\"2150\"},{\"id\":7590,\"count\":\"2\",\"chance\":\"14800\"},{\"id\":7894,\"count\":1,\"chance\":\"790\"},{\"id\":7899,\"count\":1,\"chance\":\"790\"},{\"id\":8473,\"count\":\"2\",\"chance\":\"15440\"},{\"id\":10553,\"count\":1,\"chance\":\"13570\"},{\"id\":\"13757\",\"count\":1,\"chance\":\"1320\"},{\"id\":18409,\"count\":1,\"chance\":\"1480\"},{\"id\":18414,\"count\":1,\"chance\":\"5430\"},{\"id\":18417,\"count\":\"2\",\"chance\":\"12100\"},{\"id\":18420,\"count\":1,\"chance\":\"8880\"},{\"id\":18424,\"count\":1,\"chance\":\"13240\"},{\"id\":18425,\"count\":1,\"chance\":\"14890\"},{\"id\":18426,\"count\":1,\"chance\":\"15870\"},{\"id\":18435,\"count\":\"5\",\"chance\":\"10900\"}]'),
(2152, 0, 'Werewolf', 0, 1900, 1955, 30, 1, '[\"BLOOD!\",\"HRAAAAAAAAAARRRRRR!\"]', '[\"paralyze\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2148\",\"count\":\"301\",\"chance\":\"98760\"},{\"id\":\"24708\",\"count\":1,\"chance\":\"14788\"},{\"id\":\"11234\",\"count\":1,\"chance\":\"9757\"},{\"id\":\"2510\",\"count\":\"2\",\"chance\":\"9645\"},{\"id\":\"9809\",\"count\":1,\"chance\":\"7958\"},{\"id\":\"2789\",\"count\":1,\"chance\":\"6903\"},{\"id\":\"5897\",\"count\":1,\"chance\":\"5211\"},{\"id\":\"7588\",\"count\":\"2\",\"chance\":\"5171\"},{\"id\":\"2805\",\"count\":1,\"chance\":\"4987\"},{\"id\":\"2381\",\"count\":1,\"chance\":\"3072\"},{\"id\":\"8473\",\"count\":1,\"chance\":\"2016\"},{\"id\":\"7439\",\"count\":1,\"chance\":\"938\"},{\"id\":\"2197\",\"count\":1,\"chance\":\"882\"},{\"id\":\"2171\",\"count\":1,\"chance\":\"799\"},{\"id\":\"24739\",\"count\":1,\"chance\":\"726\"},{\"id\":\"2169\",\"count\":1,\"chance\":\"581\"},{\"id\":\"2438\",\"count\":1,\"chance\":\"475\"},{\"id\":\"7383\",\"count\":1,\"chance\":\"363\"},{\"id\":\"7428\",\"count\":1,\"chance\":\"268\"},{\"id\":\"7419\",\"count\":1,\"chance\":\"106\"}]'),
(2153, 0, 'White Deer', 0, 0, 195, 1, 0, '[\"*wheeze*\",\"ROOOAAARR!!\",\"*sniff*\",\"*bell*\"]', '[]', 0, 0, 'blood', '[]'),
(2154, 0, 'White Shade', 0, 120, 260, 1, 0, '[\"Leave this place... save yourself...\",\"The dark ones.. must be stopped... unholy, twisted, EVIL!\",\"No... don\'t go further stranger... danger lies in every step...\"]', '[\"lifedrain\",\"paralyze\",\"invisible\",\"earth\",\"death\",\"drown\"]', 0, 0, 'undead', '[{\"id\":5909,\"count\":1,\"chance\":\"3370\"}]'),
(2155, 0, 'Wiggler', 0, 900, 1200, 1, 1, '[\"Zzzrp!\",\"Crick! Crick!\"]', '[\"earth\",\"paralyze\",\"invisible\"]', 0, 0, 'venom', '[{\"id\":2148,\"count\":\"100\",\"chance\":\"100000\"},{\"id\":2152,\"count\":1,\"chance\":\"14790\"},{\"id\":2181,\"count\":1,\"chance\":\"850\"},{\"id\":2409,\"count\":1,\"chance\":\"1360\"},{\"id\":2529,\"count\":1,\"chance\":\"1320\"},{\"id\":2787,\"count\":\"5\",\"chance\":\"7142\"},{\"id\":5912,\"count\":1,\"chance\":\"2080\"},{\"id\":5914,\"count\":1,\"chance\":\"2160\"},{\"id\":7588,\"count\":1,\"chance\":\"4930\"},{\"id\":7589,\"count\":1,\"chance\":\"5250\"},{\"id\":18304,\"count\":\"5\",\"chance\":\"15540\"},{\"id\":18416,\"count\":1,\"chance\":\"3600\"},{\"id\":18421,\"count\":1,\"chance\":\"2070\"},{\"id\":18436,\"count\":\"5\",\"chance\":\"15260\"}]'),
(2156, 0, 'Wild Dog', 220, 0, 1000000, 1, 0, '[\"Wuff wuff\"]', '[]', 0, 1, 'blood', '[]'),
(2157, 0, 'Wild Fire Magic', 0, 0, 1, 1, 0, '[]', '[]', 0, 0, 'undead', '[]'),
(2158, 0, 'Wild Fury Magic', 0, 0, 1, 1, 0, '[]', '[]', 0, 0, 'undead', '[]'),
(2159, 0, 'Wild Horse', 0, 0, 75, 14, 0, '[\"Weeeeheeeeeee\",\"*snort*\",\"*Weeeeheeeeaaa*\"]', '[]', 0, 0, 'blood', '[]'),
(2160, 0, 'Wild Nature Magic', 0, 0, 1, 1, 0, '[]', '[]', 0, 0, 'undead', '[]'),
(2161, 0, 'Wild Warrior', 420, 60, 135, 1, 1, '[\"An enemy!\",\"Gimme your money!\"]', '[]', 1, 1, 'blood', '[{\"id\":\"2148\",\"count\":\"30\",\"chance\":\"65608\"},{\"id\":\"2386\",\"count\":1,\"chance\":\"20940\"},{\"id\":\"2511\",\"count\":1,\"chance\":\"17483\"},{\"id\":\"2398\",\"count\":1,\"chance\":\"13081\"},{\"id\":\"3606\",\"count\":\"2\",\"chance\":\"12596\"},{\"id\":\"2458\",\"count\":1,\"chance\":\"5204\"},{\"id\":\"2465\",\"count\":1,\"chance\":\"2779\"},{\"id\":\"2509\",\"count\":1,\"chance\":\"1314\"},{\"id\":\"2459\",\"count\":1,\"chance\":\"1032\"},{\"id\":\"2110\",\"count\":1,\"chance\":\"529\"}]'),
(2162, 0, 'Wild Water Magic', 0, 0, 1, 1, 0, '[]', '[]', 0, 0, 'undead', '[]'),
(2163, 0, 'Wilting Leaf Golem', 390, 145, 380, 1, 0, '[\"*crackle*\",\"*swwwwishhhh*\"]', '[]', 0, 0, 'blood', '[{\"id\":2148,\"count\":\"45\",\"chance\":\"97230\"},{\"id\":2149,\"count\":1,\"chance\":\"830\"},{\"id\":2787,\"count\":\"3\",\"chance\":\"4860\"},{\"id\":20104,\"count\":1,\"chance\":\"4200\"},{\"id\":21427,\"count\":1,\"chance\":\"10690\"},{\"id\":21428,\"count\":1,\"chance\":\"15630\"}]'),
(2164, 0, 'Winter Wolf', 260, 20, 30, 1, 0, '[\"Yoooohhuuuu!\"]', '[]', 1, 1, 'blood', '[{\"id\":2666,\"count\":\"2\",\"chance\":\"30000\"},{\"id\":11212,\"count\":1,\"chance\":\"10000\"}]'),
(2165, 0, 'Wisp', 0, 0, 115, 1, 1, '[\"Crackle!\",\"Tsshh\"]', '[\"death\",\"paralyze\"]', 0, 0, 'undead', '[{\"id\":10521,\"count\":1,\"chance\":\"140\"}]'),
(2166, 0, 'Witch', 0, 120, 300, 1, 0, '[\"Horax pokti!\",\"Herba budinia ex!\",\"Hihihihi!\"]', '[\"invisible\",\"energy\"]', 0, 0, 'blood', '[{\"id\":\"2148\",\"count\":\"40\",\"chance\":\"63913\"},{\"id\":\"2687\",\"count\":\"8\",\"chance\":\"30001\"},{\"id\":\"2129\",\"count\":1,\"chance\":\"10121\"},{\"id\":\"10569\",\"count\":1,\"chance\":\"10009\"},{\"id\":\"2800\",\"count\":1,\"chance\":\"9005\"},{\"id\":\"2643\",\"count\":1,\"chance\":\"5017\"},{\"id\":\"2654\",\"count\":1,\"chance\":\"4958\"},{\"id\":\"2405\",\"count\":1,\"chance\":\"3892\"},{\"id\":\"2199\",\"count\":1,\"chance\":\"2515\"},{\"id\":\"2651\",\"count\":1,\"chance\":\"2008\"},{\"id\":\"2185\",\"count\":1,\"chance\":\"1085\"},{\"id\":\"13537\",\"count\":1,\"chance\":\"895\"},{\"id\":\"2402\",\"count\":1,\"chance\":\"556\"},{\"id\":\"10570\",\"count\":1,\"chance\":\"90\"},{\"id\":\"11211\",\"count\":1,\"chance\":\"6\"}]'),
(2167, 0, 'Wolf', 255, 18, 25, 1, 0, '[\"Yoooohhuuuu!\",\"Grrrrrrr\"]', '[]', 1, 1, 'blood', '[{\"id\":2666,\"count\":\"2\",\"chance\":\"70000\"},{\"id\":5897,\"count\":1,\"chance\":\"1000\"}]'),
(2168, 0, 'Worker Golem', 0, 1250, 1470, 1, 0, '[\"INTRUDER ALARM!\",\"klonk klonk klonk\",\"Rrrtttarrrttarrrtta\",\"Awaiting orders.\",\"Secret objective complete.\"]', '[\"invisible\",\"paralyze\"]', 0, 0, 'energy', '[{\"id\":\"2148\",\"count\":\"139\",\"chance\":\"93817\"},{\"id\":\"8309\",\"count\":\"5\",\"chance\":\"4809\"},{\"id\":\"10572\",\"count\":1,\"chance\":\"2169\"},{\"id\":\"7591\",\"count\":1,\"chance\":\"1974\"},{\"id\":\"7590\",\"count\":1,\"chance\":\"1574\"},{\"id\":\"9809\",\"count\":1,\"chance\":\"1559\"},{\"id\":\"9690\",\"count\":1,\"chance\":\"1066\"},{\"id\":\"2177\",\"count\":1,\"chance\":\"1010\"},{\"id\":\"2391\",\"count\":1,\"chance\":\"990\"},{\"id\":\"2145\",\"count\":\"2\",\"chance\":\"974\"},{\"id\":\"9812\",\"count\":1,\"chance\":\"928\"},{\"id\":\"7452\",\"count\":1,\"chance\":\"913\"},{\"id\":\"5880\",\"count\":1,\"chance\":\"872\"},{\"id\":\"8472\",\"count\":1,\"chance\":\"820\"},{\"id\":\"7439\",\"count\":1,\"chance\":\"784\"},{\"id\":\"2164\",\"count\":1,\"chance\":\"502\"},{\"id\":\"9979\",\"count\":1,\"chance\":\"159\"},{\"id\":\"7428\",\"count\":1,\"chance\":\"113\"}]'),
(2169, 0, 'World Bug', 0, 50, 270, 10, 0, '[\"My father was a year 2k bug.\",\"Psst, I\'ll make you rich.\",\"You are bugged ... by me!\"]', '[]', 0, 0, 'venom', '[{\"id\":2148,\"count\":\"11\",\"chance\":\"100000\"},{\"id\":\"6570\",\"count\":1,\"chance\":\"6000\"},{\"id\":\"6571\",\"count\":1,\"chance\":\"800\"}]'),
(2170, 0, 'Worm Priestess', 0, 1500, 1100, 1, 1, '[\"An enemy of the worm shall become his food!\",\"The great worm will swallow you!\",\"And our enemies he will swallow!\",\"The worm may guide me in this hour of darkness!\",\"From the earthy depths he comes and brings freedom!\"]', '[]', 0, 0, 'blood', '[{\"id\":\"2148\",\"count\":\"100\",\"chance\":\"100000\"},{\"id\":\"2148\",\"count\":\"50\",\"chance\":\"60000\"},{\"id\":\"2152\",\"count\":\"3\",\"chance\":\"41130\"},{\"id\":\"12429\",\"count\":1,\"chance\":\"15850\"},{\"id\":\"7589\",\"count\":\"3\",\"chance\":\"12380\"},{\"id\":\"2182\",\"count\":1,\"chance\":\"11470\"},{\"id\":\"7425\",\"count\":1,\"chance\":\"5210\"},{\"id\":\"2050\",\"count\":1,\"chance\":\"4760\"},{\"id\":\"5878\",\"count\":1,\"chance\":\"4640\"},{\"id\":\"12428\",\"count\":\"2\",\"chance\":\"2940\"},{\"id\":\"2150\",\"count\":\"2\",\"chance\":\"2500\"},{\"id\":\"2149\",\"count\":\"2\",\"chance\":\"2370\"},{\"id\":\"2147\",\"count\":\"2\",\"chance\":\"2200\"},{\"id\":\"9970\",\"count\":\"2\",\"chance\":\"2460\"},{\"id\":\"2145\",\"count\":\"2\",\"chance\":\"2430\"},{\"id\":\"5911\",\"count\":1,\"chance\":\"1350\"},{\"id\":\"5910\",\"count\":1,\"chance\":\"1400\"},{\"id\":\"5912\",\"count\":1,\"chance\":\"1820\"},{\"id\":\"8910\",\"count\":1,\"chance\":\"1590\"},{\"id\":\"2154\",\"count\":1,\"chance\":\"560\"},{\"id\":\"2156\",\"count\":1,\"chance\":\"430\"},{\"id\":\"7401\",\"count\":1,\"chance\":\"160\"}]'),
(2171, 0, 'Wrath of the Emperor', 0, 600, 55000, 95, 0, '[]', '[\"death\",\"earth\"]', 0, 0, 'undead', '[]'),
(2172, 0, 'Wyrm', 0, 1550, 1825, 30, 0, '[\"GRRR\",\"GRROARR\"]', '[\"energy\",\"paralyze\",\"invisible\",\"lifedrain\"]', 0, 0, 'blood', '[{\"id\":\"2148\",\"count\":\"232\",\"chance\":\"96901\"},{\"id\":\"2672\",\"count\":1,\"chance\":\"34875\"},{\"id\":\"7588\",\"count\":1,\"chance\":\"20224\"},{\"id\":\"7589\",\"count\":1,\"chance\":\"15215\"},{\"id\":\"10582\",\"count\":1,\"chance\":\"14967\"},{\"id\":\"2546\",\"count\":\"10\",\"chance\":\"7941\"},{\"id\":\"2455\",\"count\":1,\"chance\":\"6047\"},{\"id\":\"8871\",\"count\":1,\"chance\":\"1230\"},{\"id\":\"8921\",\"count\":1,\"chance\":\"1009\"},{\"id\":\"2145\",\"count\":\"3\",\"chance\":\"912\"},{\"id\":\"7889\",\"count\":1,\"chance\":\"754\"},{\"id\":\"8920\",\"count\":1,\"chance\":\"464\"},{\"id\":\"8873\",\"count\":1,\"chance\":\"310\"},{\"id\":\"8855\",\"count\":1,\"chance\":\"106\"},{\"id\":\"7430\",\"count\":1,\"chance\":\"96\"},{\"id\":\"10221\",\"count\":1,\"chance\":\"85\"}]'),
(2173, 0, 'Wyvern', 0, 515, 795, 1, 1, '[\"Shriiiek\"]', '[\"drunk\",\"invisible\",\"earth\"]', 0, 0, 'blood', '[{\"id\":\"2148\",\"count\":\"90\",\"chance\":\"99981\"},{\"id\":\"2672\",\"count\":1,\"chance\":\"60229\"},{\"id\":\"10561\",\"count\":1,\"chance\":\"11990\"},{\"id\":\"2146\",\"count\":1,\"chance\":\"4949\"},{\"id\":\"2547\",\"count\":1,\"chance\":\"3380\"},{\"id\":\"7588\",\"count\":1,\"chance\":\"2473\"},{\"id\":\"2187\",\"count\":1,\"chance\":\"784\"},{\"id\":\"2127\",\"count\":1,\"chance\":\"590\"},{\"id\":\"7408\",\"count\":1,\"chance\":\"459\"}]'),
(2174, 0, 'Xenia', 0, 255, 200, 1, 0, '[\"Stand still!\",\"One more head for me!\",\"Head off!\"]', '[]', 0, 0, 'blood', '[{\"id\":2125,\"count\":1,\"chance\":\"2500\"},{\"id\":2145,\"count\":\"2\",\"chance\":\"2500\"},{\"id\":2147,\"count\":\"2\",\"chance\":\"2500\"},{\"id\":2148,\"count\":\"45\",\"chance\":\"100000\"},{\"id\":2200,\"count\":1,\"chance\":\"1000\"},{\"id\":2387,\"count\":1,\"chance\":\"3333\"},{\"id\":2420,\"count\":1,\"chance\":\"10000\"},{\"id\":2458,\"count\":1,\"chance\":\"5000\"},{\"id\":2463,\"count\":1,\"chance\":\"1333\"},{\"id\":2464,\"count\":1,\"chance\":\"6666\"},{\"id\":2666,\"count\":\"3\",\"chance\":\"20000\"},{\"id\":2674,\"count\":\"4\",\"chance\":\"10000\"},{\"id\":3976,\"count\":\"10\",\"chance\":\"50000\"}]'),
(2175, 0, 'Yaga The Crone', 0, 375, 620, 10, 0, '[\"Where did I park my hut?\",\"You will taste so sweet!\",\"Hexipooh, bewitched are you!\"]', '[\"energy\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2654\",\"count\":1,\"chance\":\"68000\"},{\"id\":\"2324\",\"count\":1,\"chance\":\"64000\"},{\"id\":\"2687\",\"count\":\"8\",\"chance\":\"64000\"},{\"id\":\"2148\",\"count\":\"74\",\"chance\":\"32000\"},{\"id\":\"2129\",\"count\":1,\"chance\":\"24000\"},{\"id\":\"2800\",\"count\":1,\"chance\":\"20000\"},{\"id\":\"2651\",\"count\":1,\"chance\":\"8000\"},{\"id\":\"2199\",\"count\":1,\"chance\":\"8000\"},{\"id\":\"8902\",\"count\":1,\"chance\":\"8000\"},{\"id\":\"2185\",\"count\":1,\"chance\":\"4000\"},{\"id\":\"2402\",\"count\":1,\"chance\":\"4000\"}]'),
(2176, 0, 'Yakchal', 0, 4400, 5750, 1, 0, '[\"So you think you are cool?\",\"I hope it is not too cold for you! HeHeHe.\",\"Freeze!\"]', '[\"ice\",\"paralyze\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":2148,\"count\":\"88\",\"chance\":\"10000\"},{\"id\":2195,\"count\":1,\"chance\":\"2000\"},{\"id\":2201,\"count\":1,\"chance\":\"3250\"},{\"id\":2436,\"count\":1,\"chance\":\"4500\"},{\"id\":2445,\"count\":1,\"chance\":\"4000\"},{\"id\":5912,\"count\":1,\"chance\":\"5000\"},{\"id\":7290,\"count\":1,\"chance\":\"100000\"},{\"id\":7410,\"count\":1,\"chance\":\"1500\"},{\"id\":7439,\"count\":1,\"chance\":\"1500\"},{\"id\":7440,\"count\":1,\"chance\":\"1500\"},{\"id\":7443,\"count\":1,\"chance\":\"1500\"},{\"id\":7449,\"count\":1,\"chance\":\"4000\"},{\"id\":7459,\"count\":1,\"chance\":\"1000\"},{\"id\":7896,\"count\":1,\"chance\":\"2650\"},{\"id\":7897,\"count\":1,\"chance\":\"3000\"},{\"id\":9971,\"count\":1,\"chance\":\"5000\"}]'),
(2177, 0, 'Yalahari', 0, 5, 150, 1, 0, '[\"Welcome to Yalahar, outsider.\",\"Hail Yalahar.\",\"You can learn a lot from us.\",\"Our wisdom and knowledge are unequalled in this world.\",\"That knowledge would overburden your fragile mind.\",\"I wouldn\'t expect you to understand.\",\"One day Yalahar will return to its former glory.\"]', '[\"earth\",\"physical\",\"death\"]', 0, 0, 'blood', '[]'),
(2178, 0, 'Yeti', 0, 460, 950, 15, 0, '[\"Yooodelaaahooohooo!\",\"Yooodelaaaheeeheee!\"]', '[\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2148\",\"count\":\"27\",\"chance\":\"79310\"},{\"id\":\"2666\",\"count\":1,\"chance\":\"71264\"},{\"id\":\"2111\",\"count\":\"22\",\"chance\":\"52874\"},{\"id\":\"2671\",\"count\":1,\"chance\":\"39080\"},{\"id\":\"2644\",\"count\":1,\"chance\":\"1149\"},{\"id\":\"2129\",\"count\":1,\"chance\":\"1149\"}]'),
(2179, 0, 'Yielothax', 0, 1250, 1500, 10, 0, '[\"IIEEH!! Iiih iih ih iiih!!!\",\"Bsssssssm Bssssssm Bsssssssssssm!\"]', '[\"earth\",\"invisible\"]', 0, 0, 'venom', '[{\"id\":2145,\"count\":\"5\",\"chance\":\"4761\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"50000\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"50000\"},{\"id\":2148,\"count\":\"27\",\"chance\":\"50000\"},{\"id\":2151,\"count\":1,\"chance\":\"917\"},{\"id\":2164,\"count\":1,\"chance\":\"3846\"},{\"id\":2189,\"count\":1,\"chance\":\"523\"},{\"id\":2438,\"count\":1,\"chance\":\"564\"},{\"id\":2789,\"count\":\"3\",\"chance\":\"9090\"},{\"id\":7440,\"count\":1,\"chance\":\"490\"},{\"id\":7588,\"count\":1,\"chance\":\"20000\"},{\"id\":7589,\"count\":1,\"chance\":\"20000\"},{\"id\":7889,\"count\":1,\"chance\":\"862\"},{\"id\":7895,\"count\":1,\"chance\":\"480\"},{\"id\":10221,\"count\":1,\"chance\":\"571\"},{\"id\":13877,\"count\":1,\"chance\":\"261\"},{\"id\":13881,\"count\":1,\"chance\":\"300\"},{\"id\":13942,\"count\":1,\"chance\":\"320\"}]'),
(2180, 0, 'Young Sea Serpent', 0, 1000, 1050, 50, 1, '[\"CHHHRRRR\",\"HISSSS\"]', '[\"ice\",\"paralyze\",\"invisible\",\"drown\"]', 0, 0, 'blood', '[{\"id\":2146,\"count\":\"2\",\"chance\":\"1900\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"50000\"},{\"id\":2148,\"count\":\"74\",\"chance\":\"48000\"},{\"id\":2165,\"count\":1,\"chance\":\"1000\"},{\"id\":2177,\"count\":1,\"chance\":\"300\"},{\"id\":2378,\"count\":1,\"chance\":\"8000\"},{\"id\":2394,\"count\":1,\"chance\":\"40000\"},{\"id\":2417,\"count\":1,\"chance\":\"5000\"},{\"id\":7588,\"count\":1,\"chance\":\"5000\"},{\"id\":7589,\"count\":1,\"chance\":\"4000\"},{\"id\":\"9808\",\"count\":1,\"chance\":\"7940\"},{\"id\":\"9809\",\"count\":1,\"chance\":\"7940\"},{\"id\":10583,\"count\":1,\"chance\":\"5000\"}]'),
(2181, 0, 'Young Troll', 0, 12, 30, 80, 0, '[]', '[]', 0, 0, 'blood', '[{\"id\":\"2120\",\"count\":1,\"chance\":\"10000\"},{\"id\":2148,\"count\":\"12\",\"chance\":\"58000\"},{\"id\":2448,\"count\":1,\"chance\":\"3000\"},{\"id\":2666,\"count\":1,\"chance\":\"14000\"}]'),
(2182, 0, 'Zarabustor', 0, 8000, 5100, 110, 0, '[\"Killing is such a splendid diversion from my studies.\",\"Time to test my newest spells!\"]', '[\"fire\",\"energy\",\"ice\",\"paralyze\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2148\",\"count\":\"80\",\"chance\":\"32000\"},{\"id\":\"2679\",\"count\":\"4\",\"chance\":\"21000\"},{\"id\":\"2689\",\"count\":1,\"chance\":\"11000\"},{\"id\":\"2411\",\"count\":1,\"chance\":\"9600\"},{\"id\":\"2436\",\"count\":1,\"chance\":\"8330\"},{\"id\":\"7591\",\"count\":1,\"chance\":\"7190\"},{\"id\":\"7590\",\"count\":1,\"chance\":\"6760\"},{\"id\":\"7368\",\"count\":\"4\",\"chance\":\"5500\"},{\"id\":\"2792\",\"count\":1,\"chance\":\"5000\"},{\"id\":\"2167\",\"count\":1,\"chance\":\"4200\"},{\"id\":\"2178\",\"count\":1,\"chance\":\"4000\"},{\"id\":\"2047\",\"count\":1,\"chance\":\"3500\"},{\"id\":\"2656\",\"count\":1,\"chance\":\"3390\"},{\"id\":\"2146\",\"count\":1,\"chance\":\"3190\"},{\"id\":\"2151\",\"count\":1,\"chance\":\"3160\"},{\"id\":\"7898\",\"count\":1,\"chance\":\"3040\"},{\"id\":\"2600\",\"count\":1,\"chance\":\"3000\"},{\"id\":\"2124\",\"count\":1,\"chance\":\"2670\"},{\"id\":\"12410\",\"count\":1,\"chance\":\"2500\"},{\"id\":\"2123\",\"count\":1,\"chance\":\"2420\"},{\"id\":\"2197\",\"count\":1,\"chance\":\"2320\"},{\"id\":\"1986\",\"count\":1,\"chance\":\"2310\"},{\"id\":\"2466\",\"count\":1,\"chance\":\"2240\"},{\"id\":\"2114\",\"count\":1,\"chance\":\"2060\"}]'),
(2183, 0, 'Zavarash', 0, 21000, 35000, 110, 1, '[\"Harrr, Harrr!\"]', '[\"lifedrain\",\"paralyze\",\"outfit\",\"drunk\",\"invisible\"]', 0, 0, 'fire', '[{\"id\":\"22396\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"2148\",\"count\":\"100\",\"chance\":\"50000\"},{\"id\":\"2148\",\"count\":\"97\",\"chance\":\"50000\"},{\"id\":\"2152\",\"count\":\"50\",\"chance\":\"100000\"},{\"id\":\"5954\",\"count\":1,\"chance\":\"100000\"},{\"id\":\"22598\",\"count\":1,\"chance\":\"60000\"},{\"id\":\"6500\",\"count\":1,\"chance\":\"60000\"},{\"id\":\"7632\",\"count\":1,\"chance\":\"40000\"},{\"id\":\"18414\",\"count\":\"8\",\"chance\":\"40000\"},{\"id\":\"7590\",\"count\":\"10\",\"chance\":\"34440\"},{\"id\":\"8473\",\"count\":\"10\",\"chance\":\"34440\"},{\"id\":\"8472\",\"count\":\"5\",\"chance\":\"34440\"},{\"id\":\"18413\",\"count\":\"8\",\"chance\":\"30000\"},{\"id\":\"18415\",\"count\":\"8\",\"chance\":\"30000\"},{\"id\":\"2155\",\"count\":1,\"chance\":\"20000\"},{\"id\":\"2515\",\"count\":1,\"chance\":\"15030\"},{\"id\":\"2427\",\"count\":1,\"chance\":\"15030\"},{\"id\":\"2158\",\"count\":1,\"chance\":\"15030\"},{\"id\":\"9971\",\"count\":1,\"chance\":\"15030\"},{\"id\":\"7428\",\"count\":1,\"chance\":\"15030\"},{\"id\":\"2452\",\"count\":1,\"chance\":\"12940\"},{\"id\":\"2519\",\"count\":1,\"chance\":\"11540\"},{\"id\":\"22610\",\"count\":1,\"chance\":\"10000\"},{\"id\":\"8891\",\"count\":1,\"chance\":\"9620\"},{\"id\":\"7387\",\"count\":1,\"chance\":\"8390\"},{\"id\":\"2520\",\"count\":1,\"chance\":\"6290\"},{\"id\":\"2514\",\"count\":1,\"chance\":\"1400\"},{\"id\":\"7431\",\"count\":1,\"chance\":\"700\"},{\"id\":\"8877\",\"count\":1,\"chance\":\"350\"},{\"id\":\"8928\",\"count\":1,\"chance\":\"170\"}]'),
(2184, 0, 'Zevelon Duskbringer', 0, 1800, 1400, 45, 0, '[\"Human blood is not suitable for drinking\",\"Your short live is coming to an end\",\"Ashari Mortals. Come and stay forever!\"]', '[\"lifedrain\",\"death\",\"invisible\"]', 0, 0, 'undead', '[{\"id\":2144,\"count\":1,\"chance\":\"8000\"},{\"id\":2148,\"count\":\"75\",\"chance\":\"100000\"},{\"id\":2152,\"count\":\"5\",\"chance\":\"50000\"},{\"id\":2214,\"count\":1,\"chance\":\"11111\"},{\"id\":2534,\"count\":1,\"chance\":\"4500\"},{\"id\":7588,\"count\":1,\"chance\":\"4000\"},{\"id\":9020,\"count\":1,\"chance\":\"100000\"}]'),
(2185, 0, 'Zomba', 0, 300, 300, 1, 0, '[\"Groarrr!\"]', '[]', 0, 0, 'blood', '[{\"id\":2148,\"count\":\"25\",\"chance\":\"100000\"},{\"id\":2152,\"count\":1,\"chance\":\"25000\"},{\"id\":2168,\"count\":1,\"chance\":\"12500\"},{\"id\":10608,\"count\":\"2\",\"chance\":\"100000\"}]'),
(2186, 0, 'Zombie', 0, 280, 500, 1, 0, '[\"Mst.... klll....\",\"Whrrrr... ssss.... mmm.... grrrrl\",\"Dnnnt... cmmm... clsrrr....\",\"Httt.... hmnnsss...\"]', '[\"death\",\"energy\",\"ice\",\"earth\",\"drown\",\"drunk\",\"lifedrain\",\"paralyze\"]', 0, 0, 'blood', '[{\"id\":\"2148\",\"count\":\"65\",\"chance\":\"82036\"},{\"id\":\"2460\",\"count\":1,\"chance\":\"9793\"},{\"id\":\"2398\",\"count\":1,\"chance\":\"7847\"},{\"id\":\"2417\",\"count\":1,\"chance\":\"6856\"},{\"id\":\"9808\",\"count\":1,\"chance\":\"5790\"},{\"id\":\"3351\",\"count\":1,\"chance\":\"4799\"},{\"id\":\"2381\",\"count\":1,\"chance\":\"3802\"},{\"id\":\"2168\",\"count\":1,\"chance\":\"960\"},{\"id\":\"7620\",\"count\":1,\"chance\":\"748\"},{\"id\":\"2657\",\"count\":1,\"chance\":\"530\"}]'),
(2187, 0, 'Zoralurk', 0, 30000, 55000, 90, 1, '[\"I AM ZORALURK, THE DEMON WITH A THOUSAND FACES!\",\"BRING IT, COCKROACHES!\"]', '[\"energy\",\"fire\",\"earth\",\"lifedrain\",\"paralyze\",\"outfit\",\"drunk\",\"invisible\"]', 0, 0, 'undead', '[{\"id\":2143,\"count\":\"5\",\"chance\":\"10000\"},{\"id\":2148,\"count\":\"100\",\"chance\":\"100000\"},{\"id\":2148,\"count\":\"90\",\"chance\":\"50000\"},{\"id\":2195,\"count\":1,\"chance\":\"16033\"},{\"id\":2393,\"count\":1,\"chance\":\"60000\"},{\"id\":2407,\"count\":1,\"chance\":\"20000\"},{\"id\":2407,\"count\":1,\"chance\":\"20000\"},{\"id\":2408,\"count\":1,\"chance\":\"6000\"},{\"id\":2641,\"count\":1,\"chance\":\"7000\"},{\"id\":\"6530\",\"count\":1,\"chance\":\"16000\"}]'),
(2188, 0, 'Zugurosh', 0, 10000, 90500, 60, 0, '[\"You will run out of resources soon enough!!\",\"One little mistake and your all are mine!\",\"I sense your strength fading!\"]', '[\"death\",\"paralyze\",\"invisible\"]', 0, 0, 'fire', '[{\"id\":2148,\"count\":\"100\",\"chance\":\"100000\"},{\"id\":2148,\"count\":\"50\",\"chance\":\"100000\"},{\"id\":2149,\"count\":\"3\",\"chance\":\"1428\"},{\"id\":2151,\"count\":\"11\",\"chance\":\"6000\"},{\"id\":2158,\"count\":1,\"chance\":\"4444\"},{\"id\":2171,\"count\":1,\"chance\":\"2333\"},{\"id\":2195,\"count\":1,\"chance\":\"4444\"},{\"id\":2393,\"count\":1,\"chance\":\"3000\"},{\"id\":2402,\"count\":1,\"chance\":\"10000\"},{\"id\":2432,\"count\":1,\"chance\":\"5555\"},{\"id\":2462,\"count\":1,\"chance\":\"9700\"},{\"id\":2470,\"count\":1,\"chance\":\"6500\"},{\"id\":2477,\"count\":1,\"chance\":\"6666\"},{\"id\":2520,\"count\":1,\"chance\":\"9999\"},{\"id\":\"6300\",\"count\":1,\"chance\":\"7777\"}]'),
(2189, 0, 'Zulazza the Corruptor', 0, 10000, 46500, 35, 0, '[\"I\'m Zulazza, and you won\'t forget me that fazzt.\",\"Oh, HE will take revenge on zzizz azzault when you zztep in front of HIZZ fazze!\"]', '[\"paralyze\",\"invisible\",\"energy\"]', 0, 0, 'blood', '[{\"id\":\"2148\",\"count\":\"98\",\"chance\":\"100000\"},{\"id\":\"2152\",\"count\":\"6\",\"chance\":\"71429\"},{\"id\":\"2155\",\"count\":1,\"chance\":\"42857\"},{\"id\":\"2154\",\"count\":1,\"chance\":\"42857\"},{\"id\":\"2127\",\"count\":1,\"chance\":\"28571\"},{\"id\":\"7591\",\"count\":\"4\",\"chance\":\"28571\"},{\"id\":\"8472\",\"count\":\"7\",\"chance\":\"28571\"},{\"id\":\"2156\",\"count\":1,\"chance\":\"28571\"},{\"id\":\"5944\",\"count\":1,\"chance\":\"28571\"},{\"id\":\"2158\",\"count\":1,\"chance\":\"14286\"},{\"id\":8891,\"count\":1,\"chance\":\"5500\"},{\"id\":8882,\"count\":1,\"chance\":\"550\"},{\"id\":\"9810\",\"count\":1,\"chance\":\"14286\"},{\"id\":\"11118\",\"count\":1,\"chance\":\"500\"}]'),
(2190, 0, 'Zushuka', 0, 9000, 15000, 1, 0, '[\"Cool down, will you?\",\"Freeze!\",\"Is this all you\'ve got?\",\"Pay for your ignorance!\",\"And stay cool.\",\"Your cold dead body will be a marvelous ice statue.\"]', '[\"ice\",\"paralyze\",\"invisible\"]', 0, 0, 'blood', '[{\"id\":\"2148\",\"count\":\"100\",\"chance\":\"42000\"},{\"id\":\"2148\",\"count\":\"100\",\"chance\":\"42000\"},{\"id\":\"21400\",\"count\":1,\"chance\":\"92000\"},{\"id\":\"7290\",\"count\":1,\"chance\":\"57000\"},{\"id\":\"7449\",\"count\":1,\"chance\":\"42000\"},{\"id\":\"8472\",\"count\":\"5\",\"chance\":\"42000\"},{\"id\":\"2396\",\"count\":1,\"chance\":\"42000\"},{\"id\":\"2168\",\"count\":1,\"chance\":\"42000\"},{\"id\":\"7443\",\"count\":1,\"chance\":\"35000\"},{\"id\":\"7892\",\"count\":1,\"chance\":\"35000\"},{\"id\":\"7440\",\"count\":1,\"chance\":\"35000\"},{\"id\":\"2152\",\"count\":1,\"chance\":\"35000\"},{\"id\":\"5909\",\"count\":\"2\",\"chance\":\"35000\"},{\"id\":\"7439\",\"count\":1,\"chance\":\"28000\"},{\"id\":\"2158\",\"count\":1,\"chance\":\"28000\"},{\"id\":\"2663\",\"count\":1,\"chance\":\"28000\"},{\"id\":\"7888\",\"count\":1,\"chance\":\"21000\"},{\"id\":\"7590\",\"count\":\"5\",\"chance\":\"21000\"},{\"id\":\"5912\",\"count\":1,\"chance\":\"14000\"},{\"id\":\"2445\",\"count\":1,\"chance\":\"14000\"},{\"id\":\"2201\",\"count\":1,\"chance\":\"14000\"},{\"id\":\"7896\",\"count\":1,\"chance\":\"14000\"},{\"id\":\"7897\",\"count\":1,\"chance\":\"14000\"},{\"id\":\"9971\",\"count\":1,\"chance\":\"14000\"},{\"id\":\"7591\",\"count\":\"5\",\"chance\":\"14000\"},{\"id\":\"7459\",\"count\":1,\"chance\":\"14000\"},{\"id\":\"2436\",\"count\":1,\"chance\":\"14000\"},{\"id\":\"2195\",\"count\":1,\"chance\":\"7000\"},{\"id\":\"7902\",\"count\":1,\"chance\":\"7000\"},{\"id\":\"5911\",\"count\":1,\"chance\":\"7000\"},{\"id\":\"21699\",\"count\":1,\"chance\":\"7000\"},{\"id\":\"21700\",\"count\":1,\"chance\":\"3000\"},{\"id\":\"7410\",\"count\":1,\"chance\":\"3000\"}]');

-- --------------------------------------------------------

--
-- Table structure for table `myaac_news`
--

CREATE TABLE `myaac_news` (
  `id` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `body` text NOT NULL,
  `type` tinyint(1) NOT NULL DEFAULT 0 COMMENT '1 - news, 2 - ticker, 3 - article',
  `date` int(11) NOT NULL DEFAULT 0,
  `category` tinyint(1) NOT NULL DEFAULT 0,
  `player_id` int(11) NOT NULL DEFAULT 0,
  `last_modified_by` int(11) NOT NULL DEFAULT 0,
  `last_modified_date` int(11) NOT NULL DEFAULT 0,
  `comments` varchar(50) NOT NULL DEFAULT '',
  `article_text` varchar(300) NOT NULL DEFAULT '',
  `article_image` varchar(100) NOT NULL DEFAULT '',
  `hidden` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_uca1400_ai_ci;

--
-- Dumping data for table `myaac_news`
--

INSERT INTO `myaac_news` (`id`, `title`, `body`, `type`, `date`, `category`, `player_id`, `last_modified_by`, `last_modified_date`, `comments`, `article_text`, `article_image`, `hidden`) VALUES
(1, 'Hello!', 'MyAAC is just READY to use!', 1, 1724827006, 2, 7, 0, 0, 'https://my-aac.org', '', '', 0),
(2, 'Hello tickets!', 'https://my-aac.org', 2, 1724827006, 4, 7, 0, 0, '', '', '', 0);

-- --------------------------------------------------------

--
-- Table structure for table `myaac_news_categories`
--

CREATE TABLE `myaac_news_categories` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL DEFAULT '',
  `description` varchar(50) NOT NULL DEFAULT '',
  `icon_id` int(2) NOT NULL DEFAULT 0,
  `hidden` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_uca1400_ai_ci;

--
-- Dumping data for table `myaac_news_categories`
--

INSERT INTO `myaac_news_categories` (`id`, `name`, `description`, `icon_id`, `hidden`) VALUES
(1, '', '', 0, 0),
(2, '', '', 1, 0),
(3, '', '', 2, 0),
(4, '', '', 3, 0),
(5, '', '', 4, 0);

-- --------------------------------------------------------

--
-- Table structure for table `myaac_notepad`
--

CREATE TABLE `myaac_notepad` (
  `id` int(11) NOT NULL,
  `account_id` int(11) NOT NULL,
  `content` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `myaac_pages`
--

CREATE TABLE `myaac_pages` (
  `id` int(11) NOT NULL,
  `name` varchar(30) NOT NULL,
  `title` varchar(30) NOT NULL,
  `body` text NOT NULL,
  `date` int(11) NOT NULL DEFAULT 0,
  `player_id` int(11) NOT NULL DEFAULT 0,
  `php` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0 - plain html, 1 - php',
  `enable_tinymce` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1 - enabled, 0 - disabled',
  `access` tinyint(2) NOT NULL DEFAULT 0,
  `hidden` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_uca1400_ai_ci;

--
-- Dumping data for table `myaac_pages`
--

INSERT INTO `myaac_pages` (`id`, `name`, `title`, `body`, `date`, `player_id`, `php`, `enable_tinymce`, `access`, `hidden`) VALUES
(1, 'downloads', 'Downloads', '<p>&nbsp;</p>\n<p>&nbsp;</p>\n<div style=\"text-align: center;\">We\'re using a <strong>custom {{ config.client / 100 }} </strong> Tibia Client.<br />\n<p>Download our launcher for Windows <a href=\"https://github.com/tibia-oce/launcher/releases\" target=\"_blank\" rel=\"noopener\">HERE</a>.</p>\n</div>', 0, 1, 0, 1, 1, 0),
(2, 'commands', 'Commands', '<table style=\"border-collapse: collapse; width: 87.8471%; height: 57px;\" border=\"1\">\r\n<tbody>\r\n<tr style=\"height: 18px;\">\r\n<td style=\"width: 33.3333%; background-color: #505050; height: 18px;\"><span style=\"color: #ffffff;\"><strong>Words</strong></span></td>\r\n<td style=\"width: 33.3333%; background-color: #505050; height: 18px;\"><span style=\"color: #ffffff;\"><strong>Description</strong></span></td>\r\n</tr>\r\n<tr style=\"height: 18px; background-color: #f1e0c6;\">\r\n<td style=\"width: 33.3333%; height: 18px;\"><em>!example</em></td>\r\n<td style=\"width: 33.3333%; height: 18px;\">This is just an example</td>\r\n</tr>\r\n<tr style=\"height: 18px; background-color: #d4c0a1;\">\r\n<td style=\"width: 33.3333%; height: 18px;\"><em>!buyhouse</em></td>\r\n<td style=\"width: 33.3333%; height: 18px;\">Buy house you are looking at</td>\r\n</tr>\r\n<tr style=\"height: 18px; background-color: #f1e0c6;\">\r\n<td style=\"width: 33.3333%; height: 18px;\"><em>!aol</em></td>\r\n<td style=\"width: 33.3333%; height: 18px;\">Buy AoL</td>\r\n</tr>\r\n</tbody>\r\n</table>', 0, 1, 0, 1, 1, 0),
(3, 'rules_on_the_page', 'Rules', '1. Names\r\na) Names which contain insulting (e.g. \"Bastard\"), racist (e.g. \"Nigger\"), extremely right-wing (e.g. \"Hitler\"), sexist (e.g. \"Bitch\") or offensive (e.g. \"Copkiller\") language.\r\nb) Names containing parts of sentences (e.g. \"Mike returns\"), nonsensical combinations of letters (e.g. \"Fgfshdsfg\") or invalid formattings (e.g. \"Thegreatknight\").\r\nc) Names that obviously do not describe a person (e.g. \"Christmastree\", \"Matrix\"), names of real life celebrities (e.g. \"Britney Spears\"), names that refer to real countries (e.g. \"Swedish Druid\"), names which were created to fake other players\' identities (e.g. \"Arieswer\" instead of \"Arieswar\") or official positions (e.g. \"System Admin\").\r\n\r\n2. Cheating\r\na) Exploiting obvious errors of the game (\"bugs\"), for instance to duplicate items. If you find an error you must report it to CipSoft immediately.\r\nb) Intentional abuse of weaknesses in the gameplay, for example arranging objects or players in a way that other players cannot move them.\r\nc) Using tools to automatically perform or repeat certain actions without any interaction by the player (\"macros\").\r\nd) Manipulating the client program or using additional software to play the game.\r\ne) Trying to steal other players\' account data (\"hacking\").\r\nf) Playing on more than one account at the same time (\"multi-clienting\").\r\ng) Offering account data to other players or accepting other players\' account data (\"account-trading/sharing\").\r\n\r\n3. Gamemasters\r\na) Threatening a gamemaster because of his or her actions or position as a gamemaster.\r\nb) Pretending to be a gamemaster or to have influence on the decisions of a gamemaster.\r\nc) Intentionally giving wrong or misleading information to a gamemaster concerning his or her investigations or making false reports about rule violations.\r\n\r\n4. Player Killing\r\na) Excessive killing of characters who are not marked with a \"skull\" on worlds which are not PvP-enforced. Please note that killing marked characters is not a reason for a banishment.\r\n\r\nA violation of the Tibia Rules may lead to temporary banishment of characters and accounts. In severe cases removal or modification of character skills, attributes and belongings, as well as the permanent removal of accounts without any compensation may be considered. The sanction is based on the seriousness of the rule violation and the previous record of the player. It is determined by the gamemaster imposing the banishment.\r\n\r\nThese rules may be changed at any time. All changes will be announced on the official website.', 0, 1, 0, 0, 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `myaac_spells`
--

CREATE TABLE `myaac_spells` (
  `id` int(11) NOT NULL,
  `spell` varchar(255) NOT NULL DEFAULT '',
  `name` varchar(255) NOT NULL,
  `words` varchar(255) NOT NULL DEFAULT '',
  `category` tinyint(1) NOT NULL DEFAULT 0 COMMENT '1 - attack, 2 - healing, 3 - summon, 4 - supply, 5 - support',
  `type` tinyint(1) NOT NULL DEFAULT 0 COMMENT '1 - instant, 2 - conjure, 3 - rune',
  `level` int(11) NOT NULL DEFAULT 0,
  `maglevel` int(11) NOT NULL DEFAULT 0,
  `mana` int(11) NOT NULL DEFAULT 0,
  `soul` tinyint(3) NOT NULL DEFAULT 0,
  `conjure_id` int(11) NOT NULL DEFAULT 0,
  `conjure_count` tinyint(3) NOT NULL DEFAULT 0,
  `reagent` int(11) NOT NULL DEFAULT 0,
  `item_id` int(11) NOT NULL DEFAULT 0,
  `premium` tinyint(1) NOT NULL DEFAULT 0,
  `vocations` varchar(100) NOT NULL DEFAULT '',
  `hidden` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_uca1400_ai_ci;

--
-- Dumping data for table `myaac_spells`
--

INSERT INTO `myaac_spells` (`id`, `spell`, `name`, `words`, `category`, `type`, `level`, `maglevel`, `mana`, `soul`, `conjure_id`, `conjure_count`, `reagent`, `item_id`, `premium`, `vocations`, `hidden`) VALUES
(359, '', 'Annihilation', 'exori gran ico', 0, 1, 0, 0, 300, 0, 0, 0, 0, 0, 0, '[4,8]', 0),
(360, '', 'Apprentice\'s Strike', 'exori min flam', 0, 1, 0, 0, 6, 0, 0, 0, 0, 0, 0, '[1,2,5,6]', 0),
(361, '', 'Berserk', 'exori', 0, 1, 0, 0, 115, 0, 0, 0, 0, 0, 0, '[4,8]', 0),
(362, '', 'Brutal Strike', 'exori ico', 0, 1, 0, 0, 30, 0, 0, 0, 0, 0, 0, '[4,8]', 0),
(363, '', 'Buzz', 'exori infir vis', 0, 1, 0, 0, 6, 0, 0, 0, 0, 0, 0, '[1,5]', 0),
(364, '', 'Chill Out', 'exevo infir frigo hur', 0, 1, 0, 0, 8, 0, 0, 0, 0, 0, 0, '[2,6]', 0),
(365, '', 'Curse', 'utori mort', 0, 1, 0, 0, 30, 0, 0, 0, 0, 0, 0, '[1,5]', 0),
(366, '', 'Death Strike', 'exori mort', 0, 1, 0, 0, 20, 0, 0, 0, 0, 0, 0, '[1,5]', 0),
(367, '', 'Divine Caldera', 'exevo mas san', 0, 1, 0, 0, 160, 0, 0, 0, 0, 0, 0, '[3,7]', 0),
(368, '', 'Divine Missile', 'exori san', 0, 1, 0, 0, 20, 0, 0, 0, 0, 0, 0, '[3,7]', 0),
(369, '', 'Electrify', 'utori vis', 0, 1, 0, 0, 30, 0, 0, 0, 0, 0, 0, '[1,5]', 0),
(370, '', 'Energy Beam', 'exevo vis lux', 0, 1, 0, 0, 40, 0, 0, 0, 0, 0, 0, '[1,5]', 0),
(371, '', 'Energy Strike', 'exori vis', 0, 1, 0, 0, 20, 0, 0, 0, 0, 0, 0, '[1,2,5,6]', 0),
(372, '', 'Energy Wave', 'exevo vis hur', 0, 1, 0, 0, 170, 0, 0, 0, 0, 0, 0, '[1,5]', 0),
(373, '', 'Envenom', 'utori pox', 0, 1, 0, 0, 30, 0, 0, 0, 0, 0, 0, '[2,6]', 0),
(374, '', 'Eternal Winter', 'exevo gran mas frigo', 0, 1, 0, 0, 1050, 0, 0, 0, 0, 0, 0, '[2,6]', 0),
(375, '', 'Ethereal Spear', 'exori con', 0, 1, 0, 0, 25, 0, 0, 0, 0, 0, 0, '[3,7]', 0),
(376, '', 'Fierce Berserk', 'exori gran', 0, 1, 0, 0, 340, 0, 0, 0, 0, 0, 0, '[4,8]', 0),
(377, '', 'Fire Wave', 'exevo flam hur', 0, 1, 0, 0, 25, 0, 0, 0, 0, 0, 0, '[1,5]', 0),
(378, '', 'Flame Strike', 'exori flam', 0, 1, 0, 0, 20, 0, 0, 0, 0, 0, 0, '[1,2,5,6]', 0),
(379, '', 'Front Sweep', 'exori min', 0, 1, 0, 0, 200, 0, 0, 0, 0, 0, 0, '[4,8]', 0),
(380, '', 'Great Energy Beam', 'exevo gran vis lux', 0, 1, 0, 0, 110, 0, 0, 0, 0, 0, 0, '[1,5]', 0),
(381, '', 'Groundshaker', 'exori mas', 0, 1, 0, 0, 160, 0, 0, 0, 0, 0, 0, '[4,8]', 0),
(382, '', 'Hell\'s Core', 'exevo gran mas flam', 0, 1, 0, 0, 1100, 0, 0, 0, 0, 0, 0, '[1,5]', 0),
(383, '', 'Holy Flash', 'utori san', 0, 1, 0, 0, 30, 0, 0, 0, 0, 0, 0, '[3,7]', 0),
(384, '', 'Ice Strike', 'exori frigo', 0, 1, 0, 0, 20, 0, 0, 0, 0, 0, 0, '[1,5,2,6]', 0),
(385, '', 'Ice Wave', 'exevo frigo hur', 0, 1, 0, 0, 25, 0, 0, 0, 0, 0, 0, '[2,6]', 0),
(386, '', 'Ignite', 'utori flam', 0, 1, 0, 0, 30, 0, 0, 0, 0, 0, 0, '[1,5]', 0),
(387, '', 'Inflict Wound', 'utori kor', 0, 1, 0, 0, 30, 0, 0, 0, 0, 0, 0, '[4,8]', 0),
(388, '', 'Lightning', 'exori amp vis', 0, 1, 0, 0, 60, 0, 0, 0, 0, 0, 0, '[1,5]', 0),
(389, '', 'Mud Attack', 'exori infir tera', 0, 1, 0, 0, 6, 0, 0, 0, 0, 0, 0, '[2,6]', 0),
(390, '', 'Physical Strike', 'exori moe ico', 0, 1, 0, 0, 20, 0, 0, 0, 0, 0, 0, '[2,6]', 0),
(391, '', 'Practice Fire Wave', 'exevo dis flam hur', 0, 1, 0, 0, 5, 0, 0, 0, 0, 0, 0, '[0]', 0),
(392, '', 'Rage of the Skies', 'exevo gran mas vis', 0, 1, 0, 0, 600, 0, 0, 0, 0, 0, 0, '[1,5]', 0),
(393, '', 'Scorch', 'exevo infir flam hur', 0, 1, 0, 0, 8, 0, 0, 0, 0, 0, 0, '[1,5]', 0),
(394, '', 'Strong Energy Strike', 'exori gran vis', 0, 1, 0, 0, 60, 0, 0, 0, 0, 0, 0, '[1,5]', 0),
(395, '', 'Strong Ethereal Spear', 'exori gran con', 0, 1, 0, 0, 55, 0, 0, 0, 0, 0, 0, '[3,7]', 0),
(396, '', 'Strong Flame Strike', 'exori gran flam', 0, 1, 0, 0, 60, 0, 0, 0, 0, 0, 0, '[1,5]', 0),
(397, '', 'Strong Ice Strike', 'exori gran frigo', 0, 1, 0, 0, 60, 0, 0, 0, 0, 0, 0, '[2,6]', 0),
(398, '', 'Strong Ice Wave', 'exevo gran frigo hur', 0, 1, 0, 0, 170, 0, 0, 0, 0, 0, 0, '[2,6]', 0),
(399, '', 'Strong Terra Strike', 'exori gran tera', 0, 1, 0, 0, 60, 0, 0, 0, 0, 0, 0, '[2,6]', 0),
(400, '', 'Terra Strike', 'exori tera', 0, 1, 0, 0, 20, 0, 0, 0, 0, 0, 0, '[1,5,2,6]', 0),
(401, '', 'Terra Wave', 'exevo tera hur', 0, 1, 0, 0, 210, 0, 0, 0, 0, 0, 0, '[2,6]', 0),
(402, '', 'Ultimate Energy Strike', 'exori max vis', 0, 1, 0, 0, 100, 0, 0, 0, 0, 0, 0, '[1,5]', 0),
(403, '', 'Ultimate Flame Strike', 'exori max flam', 0, 1, 0, 0, 100, 0, 0, 0, 0, 0, 0, '[1,5]', 0),
(404, '', 'Ultimate Ice Strike', 'exori max frigo', 0, 1, 0, 0, 100, 0, 0, 0, 0, 0, 0, '[2,6]', 0),
(405, '', 'Ultimate Terra Strike', 'exori max tera', 0, 1, 0, 0, 100, 0, 0, 0, 0, 0, 0, '[2,6]', 0),
(406, '', 'Whirlwind Throw', 'exori hur', 0, 1, 0, 0, 40, 0, 0, 0, 0, 0, 0, '[4,8]', 0),
(407, '', 'Wrath of Nature', 'exevo gran mas tera', 0, 1, 0, 0, 700, 0, 0, 0, 0, 0, 0, '[2,6]', 0),
(408, '', 'Bruise Bane', 'exura infir ico', 0, 1, 0, 0, 10, 0, 0, 0, 0, 0, 0, '[4,8]', 0),
(409, '', 'Cure Bleeding', 'exana kor', 0, 1, 0, 0, 30, 0, 0, 0, 0, 0, 0, '[2,4,6,8]', 0),
(410, '', 'Cure Burning', 'exana flam', 0, 1, 0, 0, 30, 0, 0, 0, 0, 0, 0, '[2,6]', 0),
(411, '', 'Cure Curse', 'exana mort', 0, 1, 0, 0, 40, 0, 0, 0, 0, 0, 0, '[3,7]', 0),
(412, '', 'Cure Electrification', 'exana vis', 0, 1, 0, 0, 30, 0, 0, 0, 0, 0, 0, '[2,6]', 0),
(413, '', 'Cure Poison', 'exana pox', 0, 1, 0, 0, 30, 0, 0, 0, 0, 0, 0, '[1,2,3,4,5,6,7,8]', 0),
(414, '', 'Divine Healing', 'exura san', 0, 1, 0, 0, 160, 0, 0, 0, 0, 0, 0, '[3,7]', 0),
(415, '', 'Heal Friend', 'exura sio', 0, 1, 0, 0, 140, 0, 0, 0, 0, 0, 0, '[2,6]', 0),
(416, '', 'Intense Healing', 'exura gran', 0, 1, 0, 0, 70, 0, 0, 0, 0, 0, 0, '[1,2,3,5,6,7]', 0),
(417, '', 'Intense Recovery', 'utura gran', 0, 1, 0, 0, 165, 0, 0, 0, 0, 0, 0, '[3,4,7,8]', 0),
(418, '', 'Intense Wound Cleansing', 'exura gran ico', 0, 1, 0, 0, 200, 0, 0, 0, 0, 0, 0, '[4,8]', 0),
(419, '', 'Light Healing', 'exura', 0, 1, 0, 0, 20, 0, 0, 0, 0, 0, 0, '[1,2,3,5,6,7]', 0),
(420, '', 'Magic Patch', 'exura infir', 0, 1, 0, 0, 6, 0, 0, 0, 0, 0, 0, '[1,2,3,5,6,7]', 0),
(421, '', 'Mass Healing', 'exura gran mas res', 0, 1, 0, 0, 150, 0, 0, 0, 0, 0, 0, '[2,6]', 0),
(422, '', 'Practice Healing', 'exura dis', 0, 1, 0, 0, 5, 0, 0, 0, 0, 0, 0, '[0]', 0),
(423, '', 'Recovery', 'utura', 0, 1, 0, 0, 75, 0, 0, 0, 0, 0, 0, '[3,4,7,8]', 0),
(424, '', 'Salvation', 'exura gran san', 0, 1, 0, 0, 210, 0, 0, 0, 0, 0, 0, '[3,7]', 0),
(425, '', 'Ultimate Healing', 'exura vita', 0, 1, 0, 0, 160, 0, 0, 0, 0, 0, 0, '[1,2,5,6]', 0),
(426, '', 'Wound Cleansing', 'exura ico', 0, 1, 0, 0, 40, 0, 0, 0, 0, 0, 0, '[4,8]', 0),
(427, '', 'Blood Rage', 'utito tempo', 0, 1, 0, 0, 290, 0, 0, 0, 0, 0, 0, '[4,8]', 0),
(428, '', 'Cancel Invisibility', 'exana ina', 0, 1, 0, 0, 200, 0, 0, 0, 0, 0, 0, '[3,7]', 0),
(429, '', 'Challenge', 'exeta res', 0, 1, 0, 0, 30, 0, 0, 0, 0, 0, 0, '[8]', 0),
(430, '', 'Charge', 'utani tempo hur', 0, 1, 0, 0, 100, 0, 0, 0, 0, 0, 0, '[4,8]', 0),
(431, '', 'Creature Illusion', 'utevo res ina', 0, 1, 0, 0, 100, 0, 0, 0, 0, 0, 0, '[1,2,5,6]', 0),
(432, '', 'Find Person', 'exiva', 0, 1, 0, 0, 20, 0, 0, 0, 0, 0, 0, '[1,2,3,4,5,6,7,8]', 0),
(433, '', 'Food', 'exevo pan', 0, 1, 0, 0, 120, 1, 0, 0, 0, 0, 0, '[2,6]', 0),
(434, '', 'Great Light', 'utevo gran lux', 0, 1, 0, 0, 60, 0, 0, 0, 0, 0, 0, '[1,2,3,4,5,6,7,8]', 0),
(435, '', 'Haste', 'utani hur', 0, 1, 0, 0, 60, 0, 0, 0, 0, 0, 0, '[1,2,3,4,5,6,7,8]', 0),
(436, '', 'Invisibility', 'utana vid', 0, 1, 0, 0, 440, 0, 0, 0, 0, 0, 0, '[1,2,5,6]', 0),
(437, '', 'Levitate', 'exani hur', 0, 1, 0, 0, 50, 0, 0, 0, 0, 0, 0, '[1,2,3,4,5,6,7,8]', 0),
(438, '', 'Light', 'utevo lux', 0, 1, 0, 0, 20, 0, 0, 0, 0, 0, 0, '[1,2,3,4,5,6,7,8]', 0),
(439, '', 'Magic Rope', 'exani tera', 0, 1, 0, 0, 20, 0, 0, 0, 0, 0, 0, '[1,2,3,4,5,6,7,8]', 0),
(440, '', 'Magic Shield', 'utamo vita', 0, 1, 0, 0, 50, 0, 0, 0, 0, 0, 0, '[1,2,5,6]', 0),
(441, '', 'Protector', 'utamo tempo', 0, 1, 0, 0, 200, 0, 0, 0, 0, 0, 0, '[4,8]', 0),
(442, '', 'Sharpshooter', 'utito tempo san', 0, 1, 0, 0, 450, 0, 0, 0, 0, 0, 0, '[3,7]', 0),
(443, '', 'Strong Haste', 'utani gran hur', 0, 1, 0, 0, 100, 0, 0, 0, 0, 0, 0, '[1,2,5,6]', 0),
(444, '', 'Summon Creature', 'utevo res', 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '[1,2,5,6]', 0),
(445, '', 'Swift Foot', 'utamo tempo san', 0, 1, 0, 0, 400, 0, 0, 0, 0, 0, 0, '[3,7]', 0),
(446, '', 'Ultimate Light', 'utevo vis lux', 0, 1, 0, 0, 140, 0, 0, 0, 0, 0, 0, '[1,2,5,6]', 0),
(447, '', 'Enchant Party', 'utori mas sio', 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '[1,5]', 0),
(448, '', 'Heal Party', 'utura mas sio', 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '[2,6]', 0),
(449, '', 'Protect Party', 'utamo mas sio', 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '[3,7]', 0),
(450, '', 'Train Party', 'utito mas sio', 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '[4,8]', 0),
(451, '', 'Animate Dead Rune', 'adana mort', 0, 1, 0, 0, 600, 5, 0, 0, 0, 0, 0, '[1,2,5,6]', 0),
(452, '', 'Arrow Call', 'exevo infir con', 0, 1, 0, 0, 10, 1, 0, 0, 0, 0, 0, '[3,7]', 0),
(453, '', 'Avalanche Rune', 'adori mas frigo', 0, 1, 0, 0, 530, 3, 0, 0, 0, 0, 0, '[2,6]', 0),
(454, '', 'Blank Rune', 'adori blank', 0, 1, 0, 0, 50, 1, 0, 0, 0, 0, 0, '[2,6,3,7,1,5]', 0),
(455, '', 'Chameleon Rune', 'adevo ina', 0, 1, 0, 0, 600, 2, 0, 0, 0, 0, 0, '[2,6]', 0),
(456, '', 'Conjure Arrow', 'exevo con', 0, 1, 0, 0, 100, 1, 0, 0, 0, 0, 0, '[3,7]', 0),
(457, '', 'Conjure Bolt', 'exevo con mort', 0, 1, 0, 0, 140, 2, 0, 0, 0, 0, 0, '[3,7]', 0),
(458, '', 'Conjure Explosive Arrow', 'exevo con flam', 0, 1, 0, 0, 290, 3, 0, 0, 0, 0, 0, '[3,7]', 0),
(459, '', 'Conjure Piercing Bolt', 'exevo con grav', 0, 1, 0, 0, 180, 3, 0, 0, 0, 0, 0, '[3,7]', 0),
(460, '', 'Conjure Poisoned Arrow', 'exevo con pox', 0, 1, 0, 0, 130, 2, 0, 0, 0, 0, 0, '[3,7]', 0),
(461, '', 'Conjure Power Bolt', 'exevo con vis', 0, 1, 0, 0, 700, 4, 0, 0, 0, 0, 0, '[7]', 0),
(462, '', 'Conjure Sniper Arrow', 'exevo con hur', 0, 1, 0, 0, 160, 3, 0, 0, 0, 0, 0, '[3,7]', 0),
(463, '', 'Convince Creature Rune', 'adeta sio', 0, 1, 0, 0, 200, 3, 0, 0, 0, 0, 0, '[2,6]', 0),
(464, '', 'Cure Poison Rune', 'adana pox', 0, 1, 0, 0, 200, 1, 0, 0, 0, 0, 0, '[2,6]', 0),
(465, '', 'Destroy Field Rune', 'adito grav', 0, 1, 0, 0, 120, 2, 0, 0, 0, 0, 0, '[1,2,3,5,6,7]', 0),
(466, '', 'Disintegrate Rune', 'adito tera', 0, 1, 0, 0, 200, 3, 0, 0, 0, 0, 0, '[1,2,3,5,6,7]', 0),
(467, '', 'Enchant Spear', 'exeta con', 0, 1, 0, 0, 350, 3, 0, 0, 0, 0, 0, '[3,7]', 0),
(468, '', 'Enchant Staff', 'exeta vis', 0, 1, 0, 0, 80, 0, 0, 0, 0, 0, 0, '[5]', 0),
(469, '', 'Energy Bomb Rune', 'adevo mas vis', 0, 1, 0, 0, 880, 5, 0, 0, 0, 0, 0, '[1,5]', 0),
(470, '', 'Energy Field Rune', 'adevo grav vis', 0, 1, 0, 0, 320, 2, 0, 0, 0, 0, 0, '[1,2,5,6]', 0),
(471, '', 'Energy Wall Rune', 'adevo mas grav vis', 0, 1, 0, 0, 1000, 5, 0, 0, 0, 0, 0, '[1,2,5,6]', 0),
(472, '', 'Explosion Rune', 'adevo mas hur', 0, 1, 0, 0, 570, 4, 0, 0, 0, 0, 0, '[1,2,5,6]', 0),
(473, '', 'Fire Field Rune', 'adevo grav flam', 0, 1, 0, 0, 240, 1, 0, 0, 0, 0, 0, '[1,2,5,6]', 0),
(474, '', 'Fire Bomb Rune', 'adevo mas flam', 0, 1, 0, 0, 600, 4, 0, 0, 0, 0, 0, '[1,2,5,6]', 0),
(475, '', 'Fire Wall Rune', 'adevo mas grav flam', 0, 1, 0, 0, 780, 4, 0, 0, 0, 0, 0, '[1,2,5,6]', 0),
(476, '', 'Fireball Rune', 'adori flam', 0, 1, 0, 0, 460, 3, 0, 0, 0, 0, 0, '[1,5]', 0),
(477, '', 'Great Fireball Rune', 'adori mas flam', 0, 1, 0, 0, 530, 3, 0, 0, 0, 0, 0, '[1,5]', 0),
(478, '', 'Heavy Magic Missile Rune', 'adori vis', 0, 1, 0, 0, 350, 2, 0, 0, 0, 0, 0, '[1,5,2,6]', 0),
(479, '', 'Holy Missile Rune', 'adori san', 0, 1, 0, 0, 300, 3, 0, 0, 0, 0, 0, '[3,7]', 0),
(480, '', 'Icicle Rune', 'adori frigo', 0, 1, 0, 0, 460, 3, 0, 0, 0, 0, 0, '[2,6]', 0),
(481, '', 'Intense Healing Rune', 'adura gran', 0, 1, 0, 0, 120, 2, 0, 0, 0, 0, 0, '[2,6]', 0),
(482, '', 'Light Magic Missile Rune', 'adori min vis', 0, 1, 0, 0, 120, 1, 0, 0, 0, 0, 0, '[1,2,5,6]', 0),
(483, '', 'Light Stone Shower Rune', 'adori infir mas tera', 0, 1, 0, 0, 6, 3, 0, 0, 0, 0, 0, '[1,2,3,5,6,7]', 0),
(484, '', 'Lightest Missile Rune', 'adori infir vis', 0, 1, 0, 0, 6, 0, 0, 0, 0, 0, 0, '[1,2,3,5,6,7]', 0),
(485, '', 'Magic Wall Rune', 'adevo grav tera', 0, 1, 0, 0, 750, 5, 0, 0, 0, 0, 0, '[1,5]', 0),
(486, '', 'Paralyze Rune', 'adana ani', 0, 1, 0, 0, 1400, 3, 0, 0, 0, 0, 0, '[2,6]', 0),
(487, '', 'Poison Bomb Rune', 'adevo mas pox', 0, 1, 0, 0, 520, 2, 0, 0, 0, 0, 0, '[2,6]', 0),
(488, '', 'Poison Field Rune', 'adevo grav pox', 0, 1, 0, 0, 200, 1, 0, 0, 0, 0, 0, '[1,2,5,6]', 0),
(489, '', 'Poison Wall Rune', 'adevo mas grav pox', 0, 1, 0, 0, 640, 3, 0, 0, 0, 0, 0, '[1,2,5,6]', 0),
(490, '', 'Practice Magic Missile Rune', 'adori dis min vis', 0, 1, 0, 0, 5, 0, 0, 0, 0, 0, 0, '[0]', 0),
(491, '', 'Soulfire Rune', 'adevo res flam', 0, 1, 0, 0, 420, 3, 0, 0, 0, 0, 0, '[1,2,5,6]', 0),
(492, '', 'Stalagmite Rune', 'adori tera', 0, 1, 0, 0, 350, 2, 0, 0, 0, 0, 0, '[1,5,2,6]', 0),
(493, '', 'Stone Shower Rune', 'adori mas tera', 0, 1, 0, 0, 430, 3, 0, 0, 0, 0, 0, '[2,6]', 0),
(494, '', 'Sudden Death Rune', 'adori gran mort', 0, 1, 0, 0, 985, 5, 0, 0, 0, 0, 0, '[1,5]', 0),
(495, '', 'Thunderstorm Rune', 'adori mas vis', 0, 1, 0, 0, 430, 3, 0, 0, 0, 0, 0, '[1,5]', 0),
(496, '', 'Ultimate Healing Rune', 'adura vita', 0, 1, 0, 0, 400, 3, 0, 0, 0, 0, 0, '[2,6]', 0),
(497, '', 'Wild Growth Rune', 'adevo grav vita', 0, 1, 0, 0, 600, 5, 0, 0, 0, 0, 0, '[2,6]', 0),
(498, '', 'Edit Door', 'aleta grav', 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '[]', 0),
(499, '', 'Invite Guests', 'aleta sio', 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '[]', 0),
(500, '', 'Kick Guest', 'alana sio', 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '[]', 0),
(501, '', 'Invite Subowners', 'aleta som', 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, '[]', 0),
(502, '', 'Avalanche Rune Rune', '', 0, 3, 0, 0, 0, 0, 0, 0, 0, 2274, 0, '[]', 0),
(503, '', 'Energy Bomb Rune Rune', '', 0, 3, 0, 0, 0, 0, 0, 0, 0, 2262, 0, '[]', 0),
(504, '', 'Energy Field Rune Rune', '', 0, 3, 0, 0, 0, 0, 0, 0, 0, 2277, 0, '[]', 0),
(505, '', 'Energy Wall Rune Rune', '', 0, 3, 0, 0, 0, 0, 0, 0, 0, 2279, 0, '[]', 0),
(506, '', 'Explosion Rune Rune', '', 0, 3, 0, 0, 0, 0, 0, 0, 0, 2313, 0, '[]', 0),
(507, '', 'Fire Bomb Rune Rune', '', 0, 3, 0, 0, 0, 0, 0, 0, 0, 2305, 0, '[]', 0),
(508, '', 'Fire Field Rune Rune', '', 0, 3, 0, 0, 0, 0, 0, 0, 0, 2301, 0, '[]', 0),
(509, '', 'Fire Wall Rune Rune', '', 0, 3, 0, 0, 0, 0, 0, 0, 0, 2303, 0, '[]', 0),
(510, '', 'Fireball Rune Rune', '', 0, 3, 0, 0, 0, 0, 0, 0, 0, 2302, 0, '[]', 0),
(511, '', 'Great Fireball Rune Rune', '', 0, 3, 0, 0, 0, 0, 0, 0, 0, 2304, 0, '[]', 0),
(512, '', 'Heavy Magic Missile Rune Rune', '', 0, 3, 0, 0, 0, 0, 0, 0, 0, 2311, 0, '[]', 0),
(513, '', 'Holy Missile Rune Rune', '', 0, 3, 0, 0, 0, 0, 0, 0, 0, 2295, 0, '[3,7]', 0),
(514, '', 'Icicle Rune Rune', '', 0, 3, 0, 0, 0, 0, 0, 0, 0, 2271, 0, '[]', 0),
(515, '', 'Light Magic Missile Rune Rune', '', 0, 3, 0, 0, 0, 0, 0, 0, 0, 2287, 0, '[]', 0),
(516, '', 'Light Stone Shower Rune Rune', '', 0, 3, 0, 0, 0, 0, 0, 0, 0, 23722, 0, '[]', 0),
(517, '', 'Lightest Magic Missile Rune Rune', '', 0, 3, 0, 0, 0, 0, 0, 0, 0, 19392, 0, '[]', 0),
(518, '', 'Lightest Missile Rune Rune', '', 0, 3, 0, 0, 0, 0, 0, 0, 0, 23723, 0, '[]', 0),
(519, '', 'Magic Wall Rune Rune', '', 0, 3, 0, 0, 0, 0, 0, 0, 0, 2293, 0, '[]', 0),
(520, '', 'Poison Bomb Rune Rune', '', 0, 3, 0, 0, 0, 0, 0, 0, 0, 2286, 0, '[]', 0),
(521, '', 'Poison Field Rune Rune', '', 0, 3, 0, 0, 0, 0, 0, 0, 0, 2285, 0, '[]', 0),
(522, '', 'Poison Wall Rune Rune', '', 0, 3, 0, 0, 0, 0, 0, 0, 0, 2289, 0, '[]', 0),
(523, '', 'Soulfire Rune Rune', '', 0, 3, 0, 0, 0, 0, 0, 0, 0, 2308, 0, '[]', 0),
(524, '', 'Stalagmite Rune Rune', '', 0, 3, 0, 0, 0, 0, 0, 0, 0, 2292, 0, '[]', 0),
(525, '', 'Stone Shower Rune Rune', '', 0, 3, 0, 0, 0, 0, 0, 0, 0, 2288, 0, '[]', 0),
(526, '', 'Sudden Death Rune Rune', '', 0, 3, 0, 0, 0, 0, 0, 0, 0, 2268, 0, '[]', 0),
(527, '', 'Thunderstorm Rune Rune', '', 0, 3, 0, 0, 0, 0, 0, 0, 0, 2315, 0, '[]', 0),
(528, '', 'Paralyze Rune Rune', '', 0, 3, 0, 0, 1400, 0, 0, 0, 0, 2278, 0, '[2,6]', 0),
(529, '', 'Wild Growth Rune Rune', '', 0, 3, 0, 0, 0, 0, 0, 0, 0, 2269, 0, '[2,6]', 0),
(530, '', 'Cure Poison Rune Rune', '', 0, 3, 0, 0, 0, 0, 0, 0, 0, 2266, 0, '[]', 0),
(531, '', 'Intense Healing Rune Rune', '', 0, 3, 0, 0, 0, 0, 0, 0, 0, 2265, 0, '[]', 0),
(532, '', 'Ultimate Healing Rune Rune', '', 0, 3, 0, 0, 0, 0, 0, 0, 0, 2273, 0, '[]', 0),
(533, '', 'Animate Dead Rune Rune', '', 0, 3, 0, 0, 0, 0, 0, 0, 0, 2316, 0, '[]', 0),
(534, '', 'Convince Creature Rune Rune', '', 0, 3, 0, 0, 0, 0, 0, 0, 0, 2290, 0, '[]', 0),
(535, '', 'Chameleon Rune Rune', '', 0, 3, 0, 0, 0, 0, 0, 0, 0, 2291, 0, '[]', 0),
(536, '', 'Disintegrate Rune Rune', '', 0, 3, 0, 0, 0, 0, 0, 0, 0, 2310, 0, '[]', 0),
(537, '', 'Destroy Field Rune Rune', '', 0, 3, 0, 0, 0, 0, 0, 0, 0, 2261, 0, '[]', 0);

-- --------------------------------------------------------

--
-- Table structure for table `myaac_videos`
--

CREATE TABLE `myaac_videos` (
  `id` int(11) NOT NULL,
  `title` varchar(100) NOT NULL DEFAULT '',
  `youtube_id` varchar(20) NOT NULL,
  `author` varchar(50) NOT NULL DEFAULT '',
  `ordering` int(11) NOT NULL DEFAULT 0,
  `hidden` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `myaac_visitors`
--

CREATE TABLE `myaac_visitors` (
  `ip` varchar(45) NOT NULL,
  `lastvisit` int(11) NOT NULL DEFAULT 0,
  `page` varchar(2048) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `myaac_weapons`
--

CREATE TABLE `myaac_weapons` (
  `id` int(11) NOT NULL,
  `level` int(11) NOT NULL DEFAULT 0,
  `maglevel` int(11) NOT NULL DEFAULT 0,
  `vocations` varchar(100) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_uca1400_ai_ci;

--
-- Dumping data for table `myaac_weapons`
--

INSERT INTO `myaac_weapons` (`id`, `level`, `maglevel`, `vocations`) VALUES
(1294, 0, 0, '[]'),
(2111, 0, 0, '[]'),
(2181, 26, 0, '{\"2\":true}'),
(2182, 7, 0, '{\"2\":true}'),
(2183, 33, 0, '{\"2\":true}'),
(2185, 19, 0, '{\"2\":true}'),
(2186, 13, 0, '{\"2\":true}'),
(2187, 33, 0, '{\"1\":true}'),
(2188, 19, 0, '{\"1\":true}'),
(2189, 26, 0, '{\"1\":true}'),
(2190, 7, 0, '{\"1\":true}'),
(2191, 13, 0, '{\"1\":true}'),
(2377, 20, 0, '{\"4\":true}'),
(2378, 0, 0, '{\"4\":true}'),
(2381, 25, 0, '[]'),
(2387, 25, 0, '{\"4\":true}'),
(2389, 0, 0, '[]'),
(2390, 140, 0, '{\"4\":true}'),
(2391, 50, 0, '{\"4\":true}'),
(2392, 30, 0, '[]'),
(2393, 55, 0, '{\"4\":true}'),
(2396, 0, 0, '[]'),
(2399, 0, 0, '[]'),
(2400, 80, 0, '[]'),
(2407, 30, 0, '[]'),
(2408, 120, 0, '{\"4\":true}'),
(2410, 0, 0, '[]'),
(2413, 0, 0, '{\"4\":true}'),
(2414, 60, 0, '[]'),
(2415, 95, 0, '{\"4\":true}'),
(2421, 85, 0, '[]'),
(2423, 20, 0, '[]'),
(2424, 45, 0, '[]'),
(2425, 20, 0, '[]'),
(2426, 25, 0, '[]'),
(2427, 55, 0, '[]'),
(2429, 20, 0, '[]'),
(2430, 25, 0, '[]'),
(2431, 90, 0, '[]'),
(2432, 35, 0, '[]'),
(2434, 25, 0, '[]'),
(2435, 20, 0, '[]'),
(2436, 30, 0, '[]'),
(2438, 30, 0, '[]'),
(2440, 25, 0, '{\"4\":true}'),
(2443, 70, 0, '{\"4\":true}'),
(2444, 65, 0, '{\"4\":true}'),
(2445, 35, 0, '[]'),
(2446, 45, 0, '[]'),
(2447, 50, 0, '{\"4\":true}'),
(2451, 35, 0, '[]'),
(2452, 70, 0, '{\"4\":true}'),
(2453, 75, 0, '[]'),
(2454, 65, 0, '{\"4\":true}'),
(2543, 0, 0, '[]'),
(2544, 0, 0, '[]'),
(2545, 0, 0, '[]'),
(2546, 0, 0, '[]'),
(2547, 55, 0, '[]'),
(3961, 40, 0, '[]'),
(3962, 30, 0, '[]'),
(3965, 20, 0, '[]'),
(5803, 75, 0, '{\"3\":true}'),
(6528, 75, 0, '{\"4\":true}'),
(6529, 110, 0, '[]'),
(6553, 75, 0, '{\"4\":true}'),
(7363, 30, 0, '[]'),
(7364, 20, 0, '[]'),
(7365, 40, 0, '[]'),
(7366, 0, 0, '[]'),
(7367, 42, 0, '[]'),
(7368, 80, 0, '[]'),
(7378, 25, 0, '[]'),
(7379, 25, 0, '[]'),
(7380, 35, 0, '{\"4\":true}'),
(7381, 20, 0, '[]'),
(7382, 60, 0, '{\"4\":true}'),
(7383, 50, 0, '[]'),
(7384, 60, 0, '[]'),
(7385, 20, 0, '[]'),
(7386, 40, 0, '{\"4\":true}'),
(7387, 25, 0, '[]'),
(7388, 55, 0, '[]'),
(7389, 60, 0, '[]'),
(7390, 75, 0, '[]'),
(7391, 50, 0, '{\"4\":true}'),
(7392, 35, 0, '[]'),
(7402, 45, 0, '{\"4\":true}'),
(7403, 65, 0, '{\"4\":true}'),
(7404, 40, 0, '[]'),
(7405, 70, 0, '{\"4\":true}'),
(7406, 35, 0, '{\"4\":true}'),
(7407, 30, 0, '{\"4\":true}'),
(7408, 25, 0, '[]'),
(7409, 50, 0, '[]'),
(7410, 55, 0, '[]'),
(7411, 50, 0, '[]'),
(7412, 45, 0, '[]'),
(7413, 40, 0, '{\"4\":true}'),
(7414, 60, 0, '{\"4\":true}'),
(7415, 60, 0, '[]'),
(7416, 55, 0, '[]'),
(7417, 65, 0, '[]'),
(7418, 70, 0, '[]'),
(7419, 40, 0, '[]'),
(7420, 70, 0, '[]'),
(7421, 65, 0, '[]'),
(7422, 75, 0, '[]'),
(7423, 85, 0, '{\"4\":true}'),
(7424, 30, 0, '[]'),
(7425, 20, 0, '[]'),
(7426, 40, 0, '[]'),
(7427, 45, 0, '[]'),
(7428, 55, 0, '{\"4\":true}'),
(7429, 75, 0, '[]'),
(7430, 30, 0, '[]'),
(7431, 80, 0, '[]'),
(7432, 20, 0, '[]'),
(7433, 65, 0, '[]'),
(7434, 75, 0, '[]'),
(7435, 85, 0, '[]'),
(7436, 45, 0, '{\"4\":true}'),
(7437, 30, 0, '[]'),
(7449, 25, 0, '{\"4\":true}'),
(7450, 120, 0, '{\"4\":true}'),
(7451, 35, 0, '[]'),
(7452, 30, 0, '{\"4\":true}'),
(7453, 85, 0, '{\"4\":true}'),
(7454, 30, 0, '{\"4\":true}'),
(7455, 80, 0, '[]'),
(7456, 35, 0, '[]'),
(7744, 0, 0, '[]'),
(7745, 50, 0, '[]'),
(7746, 60, 0, '[]'),
(7747, 35, 0, '{\"4\":true}'),
(7748, 45, 0, '{\"4\":true}'),
(7749, 20, 0, '[]'),
(7750, 25, 0, '[]'),
(7751, 60, 0, '[]'),
(7752, 35, 0, '{\"4\":true}'),
(7753, 65, 0, '{\"4\":true}'),
(7754, 20, 0, '[]'),
(7755, 35, 0, '[]'),
(7756, 60, 0, '[]'),
(7757, 35, 0, '[]'),
(7758, 50, 0, '{\"4\":true}'),
(7763, 0, 0, '[]'),
(7764, 50, 0, '[]'),
(7765, 60, 0, '[]'),
(7766, 35, 0, '{\"4\":true}'),
(7767, 45, 0, '{\"4\":true}'),
(7768, 20, 0, '[]'),
(7769, 25, 0, '[]'),
(7770, 60, 0, '[]'),
(7771, 35, 0, '{\"4\":true}'),
(7772, 65, 0, '{\"4\":true}'),
(7773, 20, 0, '[]'),
(7774, 35, 0, '[]'),
(7775, 60, 0, '[]'),
(7776, 35, 0, '[]'),
(7777, 50, 0, '{\"4\":true}'),
(7838, 20, 0, '[]'),
(7839, 20, 0, '[]'),
(7840, 20, 0, '[]'),
(7850, 20, 0, '[]'),
(7854, 0, 0, '[]'),
(7855, 50, 0, '[]'),
(7856, 60, 0, '[]'),
(7857, 35, 0, '{\"4\":true}'),
(7858, 45, 0, '{\"4\":true}'),
(7859, 20, 0, '[]'),
(7860, 25, 0, '[]'),
(7861, 60, 0, '[]'),
(7862, 35, 0, '{\"4\":true}'),
(7863, 65, 0, '{\"4\":true}'),
(7864, 20, 0, '[]'),
(7865, 35, 0, '[]'),
(7866, 60, 0, '[]'),
(7867, 35, 0, '[]'),
(7868, 50, 0, '{\"4\":true}'),
(7869, 0, 0, '[]'),
(7870, 50, 0, '[]'),
(7871, 60, 0, '[]'),
(7872, 35, 0, '{\"4\":true}'),
(7873, 45, 0, '{\"4\":true}'),
(7874, 20, 0, '[]'),
(7875, 25, 0, '[]'),
(7876, 60, 0, '[]'),
(7877, 35, 0, '{\"4\":true}'),
(7878, 65, 0, '{\"4\":true}'),
(7879, 20, 0, '[]'),
(7880, 35, 0, '[]'),
(7881, 60, 0, '[]'),
(7882, 35, 0, '[]'),
(7883, 50, 0, '{\"4\":true}'),
(8849, 45, 0, '{\"3\":true}'),
(8850, 60, 0, '{\"3\":true}'),
(8851, 130, 0, '{\"3\":true}'),
(8852, 100, 0, '{\"3\":true}'),
(8853, 80, 0, '{\"3\":true}'),
(8854, 80, 0, '{\"3\":true}'),
(8855, 50, 0, '{\"3\":true}'),
(8856, 60, 0, '{\"3\":true}'),
(8857, 40, 0, '{\"3\":true}'),
(8858, 70, 0, '{\"3\":true}'),
(8910, 42, 0, '{\"2\":true}'),
(8911, 22, 0, '{\"2\":true}'),
(8912, 37, 0, '{\"2\":true}'),
(8920, 37, 0, '{\"1\":true}'),
(8921, 22, 0, '{\"1\":true}'),
(8922, 42, 0, '{\"1\":true}'),
(8924, 110, 0, '[]'),
(8925, 130, 0, '[]'),
(8926, 120, 0, '{\"4\":true}'),
(8927, 120, 0, '[]'),
(8928, 100, 0, '[]'),
(8929, 100, 0, '{\"4\":true}'),
(8930, 100, 0, '[]'),
(8931, 120, 0, '[]'),
(8932, 100, 0, '{\"4\":true}'),
(11305, 60, 0, '[]'),
(11306, 50, 0, '{\"4\":true}'),
(11307, 55, 0, '[]'),
(11308, 55, 0, '{\"4\":true}'),
(11309, 20, 0, '{\"4\":true}'),
(11323, 25, 0, '[]'),
(12613, 58, 0, '{\"4\":true}'),
(12648, 82, 0, '[]'),
(12649, 82, 0, '[]'),
(13760, 37, 0, '{\"1\":true}'),
(13838, 25, 0, '[]'),
(13871, 40, 0, '{\"4\":true}'),
(13872, 40, 0, '{\"2\":true}'),
(13873, 40, 0, '{\"3\":true}'),
(13880, 40, 0, '{\"1\":true}'),
(15400, 38, 0, '[]'),
(15404, 80, 0, '[]'),
(15414, 90, 0, '[]'),
(15451, 40, 0, '[]'),
(15454, 50, 0, '[]'),
(15492, 70, 0, '[]'),
(15643, 85, 0, '{\"3\":true}'),
(15644, 50, 0, '{\"3\":true}'),
(15647, 48, 0, '[]'),
(15648, 30, 0, '[]'),
(15649, 40, 0, '[]'),
(16111, 150, 0, '{\"3\":true}'),
(18303, 0, 0, '[]'),
(18304, 90, 0, '[]'),
(18390, 65, 0, '{\"1\":true}'),
(18409, 65, 0, '{\"1\":true}'),
(18411, 65, 0, '{\"2\":true}'),
(18412, 65, 0, '{\"2\":true}'),
(18435, 90, 0, '[]'),
(18436, 70, 0, '[]'),
(18437, 70, 0, '[]'),
(18450, 62, 0, '[]'),
(18453, 90, 0, '{\"3\":true}'),
(18454, 105, 0, '{\"3\":true}'),
(19391, 1, 0, '[true]'),
(20092, 15, 0, '[]'),
(20093, 15, 0, '[]'),
(20108, 50, 0, '{\"4\":true}'),
(20139, 20, 0, '[]'),
(21690, 70, 0, '{\"3\":true}'),
(21696, 0, 0, '[]'),
(22398, 75, 0, '{\"4\":true}'),
(22399, 120, 0, '{\"4\":true}'),
(22400, 250, 0, '{\"4\":true}'),
(22401, 75, 0, '{\"4\":true}'),
(22402, 120, 0, '{\"4\":true}'),
(22403, 250, 0, '{\"4\":true}'),
(22404, 75, 0, '{\"4\":true}'),
(22405, 120, 0, '{\"4\":true}'),
(22406, 250, 0, '{\"4\":true}'),
(22407, 75, 0, '{\"4\":true}'),
(22408, 120, 0, '{\"4\":true}'),
(22409, 250, 0, '{\"4\":true}'),
(22410, 75, 0, '{\"4\":true}'),
(22411, 120, 0, '{\"4\":true}'),
(22412, 250, 0, '{\"4\":true}'),
(22413, 75, 0, '{\"4\":true}'),
(22414, 120, 0, '{\"4\":true}'),
(22415, 250, 0, '{\"4\":true}'),
(22416, 75, 0, '{\"3\":true}'),
(22417, 150, 0, '{\"3\":true}'),
(22418, 250, 0, '{\"3\":true}'),
(22419, 75, 0, '{\"3\":true}'),
(22420, 150, 0, '{\"3\":true}'),
(22421, 250, 0, '{\"3\":true}'),
(23529, 60, 0, '[]'),
(23719, 1, 0, '{\"1\":true}'),
(23721, 1, 0, '{\"2\":true}'),
(23839, 1, 0, '[]'),
(24827, 50, 0, '[]'),
(24828, 25, 0, '[]'),
(24839, 37, 0, '{\"2\":true}'),
(25383, 70, 0, '[]'),
(25415, 150, 0, '[]'),
(25416, 150, 0, '[]'),
(25418, 150, 0, '[]'),
(25420, 100, 0, '[]'),
(25421, 65, 0, '{\"1\":true}'),
(25422, 100, 0, '{\"1\":true}'),
(25522, 120, 0, '{\"3\":true}'),
(25523, 120, 0, '{\"3\":true}'),
(25526, 0, 0, '[]');

-- --------------------------------------------------------

--
-- Table structure for table `players`
--

CREATE TABLE `players` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `group_id` int(11) NOT NULL DEFAULT 1,
  `account_id` int(11) NOT NULL DEFAULT 0,
  `level` int(11) NOT NULL DEFAULT 1,
  `vocation` int(11) NOT NULL DEFAULT 0,
  `health` int(11) NOT NULL DEFAULT 150,
  `healthmax` int(11) NOT NULL DEFAULT 150,
  `experience` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `lookbody` int(11) NOT NULL DEFAULT 0,
  `lookfeet` int(11) NOT NULL DEFAULT 0,
  `lookhead` int(11) NOT NULL DEFAULT 0,
  `looklegs` int(11) NOT NULL DEFAULT 0,
  `looktype` int(11) NOT NULL DEFAULT 136,
  `lookaddons` int(11) NOT NULL DEFAULT 0,
  `direction` tinyint(3) UNSIGNED NOT NULL DEFAULT 2,
  `maglevel` int(11) NOT NULL DEFAULT 0,
  `mana` int(11) NOT NULL DEFAULT 0,
  `manamax` int(11) NOT NULL DEFAULT 0,
  `manaspent` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `soul` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `town_id` int(11) NOT NULL DEFAULT 1,
  `posx` int(11) NOT NULL DEFAULT 0,
  `posy` int(11) NOT NULL DEFAULT 0,
  `posz` int(11) NOT NULL DEFAULT 0,
  `conditions` blob DEFAULT NULL,
  `cap` int(11) NOT NULL DEFAULT 400,
  `sex` int(11) NOT NULL DEFAULT 0,
  `lastlogin` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `lastip` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `save` tinyint(4) NOT NULL DEFAULT 1,
  `skull` tinyint(4) NOT NULL DEFAULT 0,
  `skulltime` bigint(20) NOT NULL DEFAULT 0,
  `lastlogout` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `blessings` tinyint(4) NOT NULL DEFAULT 0,
  `onlinetime` bigint(20) NOT NULL DEFAULT 0,
  `deletion` bigint(20) NOT NULL DEFAULT 0,
  `balance` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `offlinetraining_time` smallint(5) UNSIGNED NOT NULL DEFAULT 43200,
  `offlinetraining_skill` int(11) NOT NULL DEFAULT -1,
  `stamina` smallint(5) UNSIGNED NOT NULL DEFAULT 2520,
  `skill_fist` int(10) UNSIGNED NOT NULL DEFAULT 10,
  `skill_fist_tries` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `skill_club` int(10) UNSIGNED NOT NULL DEFAULT 10,
  `skill_club_tries` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `skill_sword` int(10) UNSIGNED NOT NULL DEFAULT 10,
  `skill_sword_tries` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `skill_axe` int(10) UNSIGNED NOT NULL DEFAULT 10,
  `skill_axe_tries` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `skill_dist` int(10) UNSIGNED NOT NULL DEFAULT 10,
  `skill_dist_tries` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `skill_shielding` int(10) UNSIGNED NOT NULL DEFAULT 10,
  `skill_shielding_tries` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `skill_fishing` int(10) UNSIGNED NOT NULL DEFAULT 10,
  `skill_fishing_tries` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `created` int(11) NOT NULL DEFAULT 0,
  `hidden` tinyint(1) NOT NULL DEFAULT 0,
  `comment` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_uca1400_ai_ci;

--
-- Dumping data for table `players`
--

INSERT INTO `players` (`id`, `name`, `group_id`, `account_id`, `level`, `vocation`, `health`, `healthmax`, `experience`, `lookbody`, `lookfeet`, `lookhead`, `looklegs`, `looktype`, `lookaddons`, `direction`, `maglevel`, `mana`, `manamax`, `manaspent`, `soul`, `town_id`, `posx`, `posy`, `posz`, `conditions`, `cap`, `sex`, `lastlogin`, `lastip`, `save`, `skull`, `skulltime`, `lastlogout`, `blessings`, `onlinetime`, `deletion`, `balance`, `offlinetraining_time`, `offlinetraining_skill`, `stamina`, `skill_fist`, `skill_fist_tries`, `skill_club`, `skill_club_tries`, `skill_sword`, `skill_sword_tries`, `skill_axe`, `skill_axe_tries`, `skill_dist`, `skill_dist_tries`, `skill_shielding`, `skill_shielding_tries`, `skill_fishing`, `skill_fishing_tries`, `created`, `hidden`, `comment`) VALUES
(1, 'Rook Sample', 1, 1, 8, 0, 185, 185, 4200, 113, 115, 95, 39, 129, 0, 2, 0, 35, 35, 0, 0, 1, 95, 117, 7, '', 440, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1000000, 43200, -1, 2520, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 0, 0, ''),
(2, 'Sorcerer Sample', 1, 1, 8, 1, 185, 185, 4200, 113, 115, 95, 39, 129, 0, 2, 0, 35, 35, 0, 0, 2, 159, 387, 6, '', 440, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1000000, 43200, -1, 2520, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 0, 0, ''),
(3, 'Druid Sample', 1, 1, 8, 2, 185, 185, 4200, 113, 115, 95, 39, 129, 0, 2, 0, 35, 35, 0, 0, 3, 242, 430, 12, '', 440, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1000000, 43200, -1, 2520, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 0, 0, ''),
(4, 'Paladin Sample', 1, 1, 8, 3, 185, 185, 4200, 113, 115, 95, 39, 129, 0, 2, 0, 35, 35, 0, 0, 4, 496, 172, 7, '', 440, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1000000, 43200, -1, 2520, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 0, 0, ''),
(5, 'Knight Sample', 1, 1, 8, 4, 185, 185, 4200, 113, 115, 95, 39, 129, 0, 2, 0, 35, 35, 0, 0, 5, 240, 566, 7, '', 440, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1000000, 43200, -1, 2520, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 0, 0, ''),
(6, 'Admin', 6, 1, 500, 0, 3000, 3000, 2058474800, 113, 115, 95, 39, 75, 0, 2, 100, 3000, 3000, 0, 0, 1, 95, 117, 7, '', 5000, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1000000, 43200, -1, 2520, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 10, 0, 0, 0, '');

--
-- Triggers `players`
--
DELIMITER $$
CREATE TRIGGER `ondelete_players` BEFORE DELETE ON `players` FOR EACH ROW BEGIN
    UPDATE `houses` SET `owner` = 0 WHERE `owner` = OLD.`id`;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `players_online`
--

CREATE TABLE `players_online` (
  `player_id` int(11) NOT NULL
) ENGINE=MEMORY DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `player_deaths`
--

CREATE TABLE `player_deaths` (
  `player_id` int(11) NOT NULL,
  `time` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
  `level` int(11) NOT NULL DEFAULT 1,
  `killed_by` varchar(255) NOT NULL,
  `is_player` tinyint(4) NOT NULL DEFAULT 1,
  `mostdamage_by` varchar(100) NOT NULL,
  `mostdamage_is_player` tinyint(4) NOT NULL DEFAULT 0,
  `unjustified` tinyint(4) NOT NULL DEFAULT 0,
  `mostdamage_unjustified` tinyint(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `player_depotitems`
--

CREATE TABLE `player_depotitems` (
  `player_id` int(11) NOT NULL,
  `sid` int(11) NOT NULL COMMENT 'any given range eg 0-100 will be reserved for depot lockers and all > 100 will be then normal items inside depots',
  `pid` int(11) NOT NULL DEFAULT 0,
  `itemtype` smallint(5) UNSIGNED NOT NULL,
  `count` smallint(6) NOT NULL DEFAULT 0,
  `attributes` blob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `player_inboxitems`
--

CREATE TABLE `player_inboxitems` (
  `player_id` int(11) NOT NULL,
  `sid` int(11) NOT NULL,
  `pid` int(11) NOT NULL DEFAULT 0,
  `itemtype` smallint(5) UNSIGNED NOT NULL,
  `count` smallint(6) NOT NULL DEFAULT 0,
  `attributes` blob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `player_items`
--

CREATE TABLE `player_items` (
  `player_id` int(11) NOT NULL DEFAULT 0,
  `pid` int(11) NOT NULL DEFAULT 0,
  `sid` int(11) NOT NULL DEFAULT 0,
  `itemtype` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
  `count` smallint(6) NOT NULL DEFAULT 0,
  `attributes` blob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_uca1400_ai_ci;

--
-- Dumping data for table `player_items`
--

INSERT INTO `player_items` (`player_id`, `pid`, `sid`, `itemtype`, `count`, `attributes`) VALUES
(3, 3, 101, 1987, 1, ''),
(3, 4, 102, 2650, 1, ''),
(3, 6, 103, 2382, 1, ''),
(3, 10, 104, 2050, 1, ''),
(3, 101, 105, 2674, 1, 0x0f01),
(5, 3, 101, 1987, 1, ''),
(5, 4, 102, 2650, 1, ''),
(5, 6, 103, 2382, 1, ''),
(5, 10, 104, 2050, 1, ''),
(5, 101, 105, 2674, 1, 0x0f01),
(4, 3, 101, 1987, 1, ''),
(4, 4, 102, 2650, 1, ''),
(4, 6, 103, 2382, 1, ''),
(4, 10, 104, 2050, 1, ''),
(4, 101, 105, 2674, 1, 0x0f01),
(1, 3, 101, 1987, 1, ''),
(1, 4, 102, 2650, 1, ''),
(1, 6, 103, 2382, 1, ''),
(1, 10, 104, 2050, 1, ''),
(1, 101, 105, 2674, 1, 0x0f01),
(6, 3, 101, 1987, 1, ''),
(6, 4, 102, 2650, 1, ''),
(6, 6, 103, 2382, 1, ''),
(6, 10, 104, 2050, 1, ''),
(6, 101, 105, 2674, 1, 0x0f01),
(2, 3, 101, 1987, 1, ''),
(2, 4, 102, 2650, 1, ''),
(2, 6, 103, 2382, 1, ''),
(2, 10, 104, 2050, 1, ''),
(2, 101, 105, 2674, 1, 0x0f01);

-- --------------------------------------------------------

--
-- Table structure for table `player_namelocks`
--

CREATE TABLE `player_namelocks` (
  `player_id` int(11) NOT NULL,
  `reason` varchar(255) NOT NULL,
  `namelocked_at` bigint(20) NOT NULL,
  `namelocked_by` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `player_rewarditems`
--

CREATE TABLE `player_rewarditems` (
  `player_id` int(11) NOT NULL,
  `sid` int(11) NOT NULL COMMENT 'range 0-100 will be reserved for adding items to player who are offline and all > 100 is for items saved from reward chest',
  `pid` int(11) NOT NULL DEFAULT 0,
  `itemtype` smallint(5) UNSIGNED NOT NULL,
  `count` smallint(6) NOT NULL DEFAULT 0,
  `attributes` blob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `player_spells`
--

CREATE TABLE `player_spells` (
  `player_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `player_storage`
--

CREATE TABLE `player_storage` (
  `player_id` int(11) NOT NULL DEFAULT 0,
  `key` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `value` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `player_storeinboxitems`
--

CREATE TABLE `player_storeinboxitems` (
  `player_id` int(11) NOT NULL,
  `sid` int(11) NOT NULL,
  `pid` int(11) NOT NULL DEFAULT 0,
  `itemtype` smallint(5) UNSIGNED NOT NULL,
  `count` smallint(6) NOT NULL DEFAULT 0,
  `attributes` blob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `server_config`
--

CREATE TABLE `server_config` (
  `config` varchar(50) NOT NULL,
  `value` varchar(256) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_uca1400_ai_ci;

--
-- Dumping data for table `server_config`
--

INSERT INTO `server_config` (`config`, `value`) VALUES
('db_version', '31'),
('motd_hash', ''),
('motd_num', '0'),
('players_record', '1');

-- --------------------------------------------------------

--
-- Table structure for table `tile_store`
--

CREATE TABLE `tile_store` (
  `house_id` int(11) NOT NULL,
  `data` longblob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `towns`
--

CREATE TABLE `towns` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `posx` int(11) NOT NULL DEFAULT 0,
  `posy` int(11) NOT NULL DEFAULT 0,
  `posz` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_uca1400_ai_ci;

--
-- Dumping data for table `towns`
--

INSERT INTO `towns` (`id`, `name`, `posx`, `posy`, `posz`) VALUES
(1, 'Trekolt', 95, 117, 7),
(2, 'Rhyves', 159, 387, 6),
(3, 'Varak', 242, 429, 12),
(4, 'Jorvik', 496, 172, 7),
(5, 'Saund', 240, 566, 7);

-- --------------------------------------------------------

--
-- Table structure for table `z_polls`
--

CREATE TABLE `z_polls` (
  `id` int(11) NOT NULL,
  `question` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `end` int(11) NOT NULL DEFAULT 0,
  `start` int(11) NOT NULL DEFAULT 0,
  `answers` int(11) NOT NULL DEFAULT 0,
  `votes_all` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_uca1400_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `z_polls_answers`
--

CREATE TABLE `z_polls_answers` (
  `poll_id` int(11) NOT NULL,
  `answer_id` int(11) NOT NULL,
  `answer` varchar(255) NOT NULL,
  `votes` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_uca1400_ai_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `account_bans`
--
ALTER TABLE `account_bans`
  ADD PRIMARY KEY (`account_id`),
  ADD KEY `banned_by` (`banned_by`);

--
-- Indexes for table `account_ban_history`
--
ALTER TABLE `account_ban_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `account_id` (`account_id`),
  ADD KEY `banned_by` (`banned_by`);

--
-- Indexes for table `account_storage`
--
ALTER TABLE `account_storage`
  ADD PRIMARY KEY (`account_id`,`key`);

--
-- Indexes for table `account_viplist`
--
ALTER TABLE `account_viplist`
  ADD UNIQUE KEY `account_player_index` (`account_id`,`player_id`),
  ADD KEY `player_id` (`player_id`);

--
-- Indexes for table `guilds`
--
ALTER TABLE `guilds`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD UNIQUE KEY `ownerid` (`ownerid`);

--
-- Indexes for table `guildwar_kills`
--
ALTER TABLE `guildwar_kills`
  ADD PRIMARY KEY (`id`),
  ADD KEY `warid` (`warid`);

--
-- Indexes for table `guild_invites`
--
ALTER TABLE `guild_invites`
  ADD PRIMARY KEY (`player_id`,`guild_id`),
  ADD KEY `guild_id` (`guild_id`);

--
-- Indexes for table `guild_membership`
--
ALTER TABLE `guild_membership`
  ADD PRIMARY KEY (`player_id`),
  ADD KEY `guild_id` (`guild_id`),
  ADD KEY `rank_id` (`rank_id`);

--
-- Indexes for table `guild_ranks`
--
ALTER TABLE `guild_ranks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `guild_id` (`guild_id`);

--
-- Indexes for table `guild_wars`
--
ALTER TABLE `guild_wars`
  ADD PRIMARY KEY (`id`),
  ADD KEY `guild1` (`guild1`),
  ADD KEY `guild2` (`guild2`);

--
-- Indexes for table `houses`
--
ALTER TABLE `houses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `owner` (`owner`),
  ADD KEY `town_id` (`town_id`);

--
-- Indexes for table `house_lists`
--
ALTER TABLE `house_lists`
  ADD KEY `house_id` (`house_id`);

--
-- Indexes for table `ip_bans`
--
ALTER TABLE `ip_bans`
  ADD PRIMARY KEY (`ip`),
  ADD KEY `banned_by` (`banned_by`);

--
-- Indexes for table `market_history`
--
ALTER TABLE `market_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `player_id` (`player_id`,`sale`);

--
-- Indexes for table `market_offers`
--
ALTER TABLE `market_offers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sale` (`sale`,`itemtype`),
  ADD KEY `created` (`created`),
  ADD KEY `player_id` (`player_id`);

--
-- Indexes for table `myaac_account_actions`
--
ALTER TABLE `myaac_account_actions`
  ADD KEY `account_id` (`account_id`);

--
-- Indexes for table `myaac_admin_menu`
--
ALTER TABLE `myaac_admin_menu`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `myaac_bugtracker`
--
ALTER TABLE `myaac_bugtracker`
  ADD PRIMARY KEY (`uid`);

--
-- Indexes for table `myaac_changelog`
--
ALTER TABLE `myaac_changelog`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `myaac_config`
--
ALTER TABLE `myaac_config`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `myaac_faq`
--
ALTER TABLE `myaac_faq`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `myaac_forum`
--
ALTER TABLE `myaac_forum`
  ADD PRIMARY KEY (`id`),
  ADD KEY `section` (`section`);

--
-- Indexes for table `myaac_forum_boards`
--
ALTER TABLE `myaac_forum_boards`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `myaac_gallery`
--
ALTER TABLE `myaac_gallery`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `myaac_menu`
--
ALTER TABLE `myaac_menu`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `myaac_monsters`
--
ALTER TABLE `myaac_monsters`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `myaac_news`
--
ALTER TABLE `myaac_news`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `myaac_news_categories`
--
ALTER TABLE `myaac_news_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `myaac_notepad`
--
ALTER TABLE `myaac_notepad`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `myaac_pages`
--
ALTER TABLE `myaac_pages`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `myaac_spells`
--
ALTER TABLE `myaac_spells`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `myaac_videos`
--
ALTER TABLE `myaac_videos`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `myaac_visitors`
--
ALTER TABLE `myaac_visitors`
  ADD UNIQUE KEY `ip` (`ip`);

--
-- Indexes for table `myaac_weapons`
--
ALTER TABLE `myaac_weapons`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `players`
--
ALTER TABLE `players`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD KEY `account_id` (`account_id`),
  ADD KEY `vocation` (`vocation`);

--
-- Indexes for table `players_online`
--
ALTER TABLE `players_online`
  ADD PRIMARY KEY (`player_id`);

--
-- Indexes for table `player_deaths`
--
ALTER TABLE `player_deaths`
  ADD KEY `player_id` (`player_id`),
  ADD KEY `killed_by` (`killed_by`),
  ADD KEY `mostdamage_by` (`mostdamage_by`);

--
-- Indexes for table `player_depotitems`
--
ALTER TABLE `player_depotitems`
  ADD UNIQUE KEY `player_id_2` (`player_id`,`sid`);

--
-- Indexes for table `player_inboxitems`
--
ALTER TABLE `player_inboxitems`
  ADD UNIQUE KEY `player_id_2` (`player_id`,`sid`);

--
-- Indexes for table `player_items`
--
ALTER TABLE `player_items`
  ADD KEY `player_id` (`player_id`),
  ADD KEY `sid` (`sid`);

--
-- Indexes for table `player_namelocks`
--
ALTER TABLE `player_namelocks`
  ADD PRIMARY KEY (`player_id`),
  ADD KEY `namelocked_by` (`namelocked_by`);

--
-- Indexes for table `player_rewarditems`
--
ALTER TABLE `player_rewarditems`
  ADD UNIQUE KEY `player_id_2` (`player_id`,`sid`);

--
-- Indexes for table `player_spells`
--
ALTER TABLE `player_spells`
  ADD KEY `player_id` (`player_id`);

--
-- Indexes for table `player_storage`
--
ALTER TABLE `player_storage`
  ADD PRIMARY KEY (`player_id`,`key`);

--
-- Indexes for table `player_storeinboxitems`
--
ALTER TABLE `player_storeinboxitems`
  ADD UNIQUE KEY `player_id_2` (`player_id`,`sid`);

--
-- Indexes for table `server_config`
--
ALTER TABLE `server_config`
  ADD PRIMARY KEY (`config`);

--
-- Indexes for table `tile_store`
--
ALTER TABLE `tile_store`
  ADD KEY `house_id` (`house_id`);

--
-- Indexes for table `towns`
--
ALTER TABLE `towns`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `z_polls`
--
ALTER TABLE `z_polls`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accounts`
--
ALTER TABLE `accounts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `account_ban_history`
--
ALTER TABLE `account_ban_history`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `guilds`
--
ALTER TABLE `guilds`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `guildwar_kills`
--
ALTER TABLE `guildwar_kills`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `guild_ranks`
--
ALTER TABLE `guild_ranks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `guild_wars`
--
ALTER TABLE `guild_wars`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `houses`
--
ALTER TABLE `houses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `market_history`
--
ALTER TABLE `market_history`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `market_offers`
--
ALTER TABLE `market_offers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `myaac_admin_menu`
--
ALTER TABLE `myaac_admin_menu`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `myaac_bugtracker`
--
ALTER TABLE `myaac_bugtracker`
  MODIFY `uid` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `myaac_changelog`
--
ALTER TABLE `myaac_changelog`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `myaac_config`
--
ALTER TABLE `myaac_config`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `myaac_faq`
--
ALTER TABLE `myaac_faq`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `myaac_forum`
--
ALTER TABLE `myaac_forum`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `myaac_forum_boards`
--
ALTER TABLE `myaac_forum_boards`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `myaac_gallery`
--
ALTER TABLE `myaac_gallery`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `myaac_menu`
--
ALTER TABLE `myaac_menu`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;

--
-- AUTO_INCREMENT for table `myaac_monsters`
--
ALTER TABLE `myaac_monsters`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2191;

--
-- AUTO_INCREMENT for table `myaac_news`
--
ALTER TABLE `myaac_news`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `myaac_news_categories`
--
ALTER TABLE `myaac_news_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `myaac_notepad`
--
ALTER TABLE `myaac_notepad`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `myaac_pages`
--
ALTER TABLE `myaac_pages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `myaac_spells`
--
ALTER TABLE `myaac_spells`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=538;

--
-- AUTO_INCREMENT for table `myaac_videos`
--
ALTER TABLE `myaac_videos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `players`
--
ALTER TABLE `players`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `towns`
--
ALTER TABLE `towns`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `z_polls`
--
ALTER TABLE `z_polls`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `account_bans`
--
ALTER TABLE `account_bans`
  ADD CONSTRAINT `account_bans_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `account_bans_ibfk_2` FOREIGN KEY (`banned_by`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `account_ban_history`
--
ALTER TABLE `account_ban_history`
  ADD CONSTRAINT `account_ban_history_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `account_ban_history_ibfk_2` FOREIGN KEY (`banned_by`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `account_storage`
--
ALTER TABLE `account_storage`
  ADD CONSTRAINT `account_storage_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `account_viplist`
--
ALTER TABLE `account_viplist`
  ADD CONSTRAINT `account_viplist_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `account_viplist_ibfk_2` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `guilds`
--
ALTER TABLE `guilds`
  ADD CONSTRAINT `guilds_ibfk_1` FOREIGN KEY (`ownerid`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `guildwar_kills`
--
ALTER TABLE `guildwar_kills`
  ADD CONSTRAINT `guildwar_kills_ibfk_1` FOREIGN KEY (`warid`) REFERENCES `guild_wars` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `guild_invites`
--
ALTER TABLE `guild_invites`
  ADD CONSTRAINT `guild_invites_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `guild_invites_ibfk_2` FOREIGN KEY (`guild_id`) REFERENCES `guilds` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `guild_membership`
--
ALTER TABLE `guild_membership`
  ADD CONSTRAINT `guild_membership_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `guild_membership_ibfk_2` FOREIGN KEY (`guild_id`) REFERENCES `guilds` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `guild_membership_ibfk_3` FOREIGN KEY (`rank_id`) REFERENCES `guild_ranks` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `guild_ranks`
--
ALTER TABLE `guild_ranks`
  ADD CONSTRAINT `guild_ranks_ibfk_1` FOREIGN KEY (`guild_id`) REFERENCES `guilds` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `house_lists`
--
ALTER TABLE `house_lists`
  ADD CONSTRAINT `house_lists_ibfk_1` FOREIGN KEY (`house_id`) REFERENCES `houses` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `ip_bans`
--
ALTER TABLE `ip_bans`
  ADD CONSTRAINT `ip_bans_ibfk_1` FOREIGN KEY (`banned_by`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `market_history`
--
ALTER TABLE `market_history`
  ADD CONSTRAINT `market_history_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `market_offers`
--
ALTER TABLE `market_offers`
  ADD CONSTRAINT `market_offers_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `players`
--
ALTER TABLE `players`
  ADD CONSTRAINT `players_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `accounts` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `player_deaths`
--
ALTER TABLE `player_deaths`
  ADD CONSTRAINT `player_deaths_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `player_depotitems`
--
ALTER TABLE `player_depotitems`
  ADD CONSTRAINT `player_depotitems_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `player_inboxitems`
--
ALTER TABLE `player_inboxitems`
  ADD CONSTRAINT `player_inboxitems_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `player_items`
--
ALTER TABLE `player_items`
  ADD CONSTRAINT `player_items_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `player_namelocks`
--
ALTER TABLE `player_namelocks`
  ADD CONSTRAINT `player_namelocks_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `player_namelocks_ibfk_2` FOREIGN KEY (`namelocked_by`) REFERENCES `players` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `player_rewarditems`
--
ALTER TABLE `player_rewarditems`
  ADD CONSTRAINT `player_rewarditems_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `player_spells`
--
ALTER TABLE `player_spells`
  ADD CONSTRAINT `player_spells_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `player_storage`
--
ALTER TABLE `player_storage`
  ADD CONSTRAINT `player_storage_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `player_storeinboxitems`
--
ALTER TABLE `player_storeinboxitems`
  ADD CONSTRAINT `player_storeinboxitems_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `tile_store`
--
ALTER TABLE `tile_store`
  ADD CONSTRAINT `tile_store_ibfk_1` FOREIGN KEY (`house_id`) REFERENCES `houses` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
