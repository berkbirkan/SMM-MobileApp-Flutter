-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Anamakine: 127.0.0.1
-- Üretim Zamanı: 29 Eki 2020, 22:23:50
-- Sunucu sürümü: 10.4.13-MariaDB
-- PHP Sürümü: 7.4.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Veritabanı: `boosters_mobile`
--

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `admins`
--

CREATE TABLE `admins` (
  `admin_id` int(11) NOT NULL,
  `admin_username` varchar(225) NOT NULL,
  `admin_password` varchar(225) NOT NULL,
  `admin_fullname` varchar(225) NOT NULL,
  `admin_image` varchar(225) NOT NULL,
  `admin_email` varchar(225) NOT NULL,
  `admin_permission` varchar(225) NOT NULL,
  `admin_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `admin_language` varchar(225) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Tablo döküm verisi `admins`
--

INSERT INTO `admins` (`admin_id`, `admin_username`, `admin_password`, `admin_fullname`, `admin_image`, `admin_email`, `admin_permission`, `admin_date`, `admin_language`) VALUES
(1, 'admin', '$argon2i$v=19$m=131072,t=4,p=2$d1NRQWYxM1R5M2dTdXc0dQ$jIaPv1/QJVOdRJfU0yyLNvxbQtifbRWJ179zSSYr/+w', 'samet sensoy', '', 'info@sametsensoy.com', 'Manager', '2020-09-08 10:29:31', 'en');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `category`
--

CREATE TABLE `category` (
  `category_id` int(11) NOT NULL,
  `category_name` varchar(225) DEFAULT NULL,
  `socialmedia_id` int(11) NOT NULL,
  `category_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Tablo döküm verisi `category`
--

INSERT INTO `category` (`category_id`, `category_name`, `socialmedia_id`, `category_date`) VALUES
(12, 'Turkish Likes Packages', 37, '2020-09-19 11:19:04'),
(13, 'Video Packages', 37, '2020-09-19 11:19:18'),
(14, 'Likes Packages', 37, '2020-09-19 11:19:34'),
(15, 'Followers Packages', 37, '2020-09-19 11:19:41'),
(16, 'Video Packages', 39, '2020-09-19 12:33:01'),
(17, 'Comment Packages', 39, '2020-09-19 12:33:12'),
(18, 'Like Packages', 39, '2020-09-19 12:33:24'),
(19, 'Followers Packages', 39, '2020-09-19 12:33:40'),
(20, 'Video Packages', 40, '2020-09-19 12:33:53'),
(21, 'Retweet Packages', 40, '2020-09-19 12:34:12'),
(22, 'Followers', 40, '2020-09-19 12:34:28'),
(23, 'Dislike Packages', 41, '2020-09-19 12:35:11'),
(24, 'Likes Packages', 41, '2020-09-19 12:35:25'),
(25, 'Subscriber Packages', 41, '2020-09-19 12:35:35'),
(26, 'Likes', 42, '2020-09-19 12:35:57'),
(27, 'Relaxation', 42, '2020-09-19 13:31:50'),
(28, 'Followers', 42, '2020-09-19 13:35:20'),
(29, 'Followers', 43, '2020-09-19 13:35:48'),
(30, 'Video Views', 43, '2020-09-19 13:36:21'),
(31, 'Followers', 44, '2020-09-19 13:36:48'),
(32, 'Playlist Followers', 44, '2020-09-19 13:37:13'),
(33, 'Relaxation', 44, '2020-09-19 13:37:28'),
(34, 'Search Plays', 44, '2020-09-19 13:37:41'),
(35, 'Followers', 46, '2020-09-19 13:37:59'),
(36, 'Likes', 46, '2020-09-19 13:38:15'),
(37, 'Views', 46, '2020-09-19 13:38:26'),
(38, 'Web Site Organic Traffic', 47, '2020-09-19 13:38:37'),
(39, 'iOS App Ratings and Reviews', 48, '2020-09-19 13:38:53'),
(40, 'iOS Installs', 48, '2020-09-19 13:39:04'),
(41, 'Android Installs', 49, '2020-09-19 13:39:15'),
(42, 'Android Rating and Reviews', 49, '2020-09-19 13:39:23');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `languages`
--

CREATE TABLE `languages` (
  `language_id` int(11) NOT NULL,
  `lc_id` varchar(225) NOT NULL,
  `language_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `payments`
--

CREATE TABLE `payments` (
  `id` int(11) NOT NULL,
  `payment_type` varchar(10) NOT NULL,
  `stripe_publishable_key` varchar(500) NOT NULL,
  `stripe_secret_key` varchar(500) NOT NULL,
  `stripe_language` varchar(500) NOT NULL,
  `stripe_success_url` varchar(500) NOT NULL,
  `stripe_fail_url` varchar(500) NOT NULL,
  `stripe_active` tinyint(1) NOT NULL,
  `paytr_merchant_id` varchar(500) NOT NULL,
  `paytr_merchant_key` varchar(500) NOT NULL,
  `paytr_merchant_salt` varchar(500) NOT NULL,
  `paytr_language` varchar(500) NOT NULL,
  `paytr_success_url` varchar(500) NOT NULL,
  `paytr_fail_url` varchar(500) NOT NULL,
  `paytr_active` tinyint(1) NOT NULL,
  `paypay_email` varchar(500) NOT NULL,
  `paypal_client_id` varchar(500) NOT NULL,
  `paypal_secret_id` varchar(500) NOT NULL,
  `paypal_active` tinyint(1) NOT NULL,
  `iap_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Tablo döküm verisi `payments`
--

INSERT INTO `payments` (`id`, `payment_type`, `stripe_publishable_key`, `stripe_secret_key`, `stripe_language`, `stripe_success_url`, `stripe_fail_url`, `stripe_active`, `paytr_merchant_id`, `paytr_merchant_key`, `paytr_merchant_salt`, `paytr_language`, `paytr_success_url`, `paytr_fail_url`, `paytr_active`, `paypay_email`, `paypal_client_id`, `paypal_secret_id`, `paypal_active`, `iap_active`, `created_at`, `updated_at`) VALUES
(1, '0', 'ali demircan123', 'ali demircan123', '12312312312', '12331231231', '1233123123', 1, 'ali', 'elif', 'ahmet', 'kaas', 'dem', 'c', 0, 'ali', 'ahmet', 'fatih', 1, 1, '2020-10-22 13:50:56', '2020-10-22 14:54:08');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `provider`
--

CREATE TABLE `provider` (
  `provider_id` int(11) NOT NULL,
  `provider_name` varchar(225) NOT NULL,
  `provider_url` varchar(500) NOT NULL,
  `api_key` varchar(500) NOT NULL,
  `provider_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Tablo döküm verisi `provider`
--

INSERT INTO `provider` (`provider_id`, `provider_name`, `provider_url`, `api_key`, `provider_date`) VALUES
(10, 'BirkanMedia', 'https://birkanmedia.com/api/v2', '42e6d36e91430b61d4b3cb62c4e843b0', '2020-09-09 16:50:35'),
(11, 'SMM Global', 'https://www.smmglobal.net/api/v2', 'b19d82c660c3e7b758b117ccf263398d', '2020-09-14 18:45:06'),
(12, 'sosyalmedyam', 'https://sosyalmedyam.com.tr/api/v2', '803c842ab5fa5d179c07d5fd490da5fb', '2020-09-19 06:52:32'),
(13, 'SMM Heaven', 'https://smm-heaven.net/api/v2', '6cc12e14d4cb47d6fcbc213bd7f588a1', '2020-09-20 10:39:20'),
(14, 'JetSosyal', 'https://panel.jetsosyal.com/api/v2', '-', '2020-09-25 20:22:11');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `service`
--

CREATE TABLE `service` (
  `api_service_id` int(11) NOT NULL,
  `service_name` varchar(225) NOT NULL,
  `service_id` varchar(225) DEFAULT NULL,
  `provider_price` int(11) DEFAULT NULL,
  `provider_amount` int(11) NOT NULL,
  `provider_id` int(11) NOT NULL,
  `provider_url` varchar(500) NOT NULL,
  `provider_api_key` varchar(225) NOT NULL,
  `category_id` int(11) NOT NULL,
  `service_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Tablo döküm verisi `service`
--

INSERT INTO `service` (`api_service_id`, `service_name`, `service_id`, `provider_price`, `provider_amount`, `provider_id`, `provider_url`, `provider_api_key`, `category_id`, `service_date`) VALUES
(15, 'Instagram Likes', '1773', 2, 1000, 11, 'https://www.smmglobal.net/api/v2', 'b19d82c660c3e7b758b117ccf263398d', 14, '2020-09-19 12:01:27'),
(16, 'Instagram Likes', '1773', 3, 1500, 11, 'https://www.smmglobal.net/api/v2', 'b19d82c660c3e7b758b117ccf263398d', 14, '2020-09-19 12:03:05'),
(17, 'Instagram Likes', '1773', 4, 2000, 11, 'https://www.smmglobal.net/api/v2', 'b19d82c660c3e7b758b117ccf263398d', 14, '2020-09-19 12:03:39'),
(18, 'Instagram Likes', '1773', 5, 2500, 11, 'https://www.smmglobal.net/api/v2', 'b19d82c660c3e7b758b117ccf263398d', 14, '2020-09-19 12:04:23'),
(19, 'Instagram Followers', '1710', 3, 1000, 11, 'https://www.smmglobal.net/api/v2', 'b19d82c660c3e7b758b117ccf263398d', 15, '2020-09-19 12:07:09'),
(20, 'Instagram Followers', '1710', 5, 2000, 11, 'https://www.smmglobal.net/api/v2', 'b19d82c660c3e7b758b117ccf263398d', 15, '2020-09-19 12:10:02'),
(21, 'Instagram Followers', '1710', 7, 3000, 11, 'https://www.smmglobal.net/api/v2', 'b19d82c660c3e7b758b117ccf263398d', 15, '2020-09-19 12:11:30'),
(22, 'Instagram Followers', '1710', 9, 4000, 11, 'https://www.smmglobal.net/api/v2', 'b19d82c660c3e7b758b117ccf263398d', 15, '2020-09-19 12:12:21'),
(23, 'Instagram Followers', '1710', 11, 5000, 11, 'https://www.smmglobal.net/api/v2', 'b19d82c660c3e7b758b117ccf263398d', 15, '2020-09-19 12:13:01'),
(24, 'Facebook Page Likes', '1875', 7, 1000, 11, 'https://www.smmglobal.net/api/v2', 'b19d82c660c3e7b758b117ccf263398d', 14, '2020-09-19 12:18:04'),
(25, 'Facebook Page Likes', '1875', 12, 2000, 11, 'https://www.smmglobal.net/api/v2', 'b19d82c660c3e7b758b117ccf263398d', 14, '2020-09-19 12:20:13'),
(26, 'Facebook Page Likes', '1875', 16, 3000, 11, 'https://www.smmglobal.net/api/v2', 'b19d82c660c3e7b758b117ccf263398d', 14, '2020-09-19 12:23:55'),
(27, 'Facebook Page Likes', '1875', 20, 4000, 11, 'https://www.smmglobal.net/api/v2', 'b19d82c660c3e7b758b117ccf263398d', 14, '2020-09-19 12:24:44'),
(28, 'Facebook Video Views', '725', 1, 250, 12, 'https://sosyalmedyam.com.tr/api/v2', '803c842ab5fa5d179c07d5fd490da5fb', 16, '2020-09-20 10:32:02'),
(29, 'Facebook Video Views', '725', 2, 750, 12, 'https://sosyalmedyam.com.tr/api/v2', '803c842ab5fa5d179c07d5fd490da5fb', 13, '2020-09-20 10:32:17'),
(30, 'Facebook Comment', '728', 4, 25, 12, 'https://sosyalmedyam.com.tr/api/v2', '803c842ab5fa5d179c07d5fd490da5fb', 17, '2020-09-20 10:35:04'),
(31, 'Facebook Comment', '728', 6, 75, 12, 'https://sosyalmedyam.com.tr/api/v2', '803c842ab5fa5d179c07d5fd490da5fb', 17, '2020-09-20 10:35:37'),
(32, 'Facebook Comment', '728', 8, 50, 12, 'https://sosyalmedyam.com.tr/api/v2', '803c842ab5fa5d179c07d5fd490da5fb', 17, '2020-09-20 10:36:25'),
(33, 'Facebook Comment', '728', 15, 100, 12, 'https://sosyalmedyam.com.tr/api/v2', '803c842ab5fa5d179c07d5fd490da5fb', 17, '2020-09-20 10:36:53'),
(34, 'Facebook Page Followers', '601', 2, 250, 13, 'https://smm-heaven.net/api/v2', '6cc12e14d4cb47d6fcbc213bd7f588a1', 19, '2020-09-20 10:40:37'),
(35, 'Facebook Page Followers', '601', 4, 500, 13, 'https://smm-heaven.net/api/v2', '6cc12e14d4cb47d6fcbc213bd7f588a1', 19, '2020-09-20 10:41:00'),
(36, 'Facebook Page Followers', '601', 8, 1000, 13, 'https://smm-heaven.net/api/v2', '6cc12e14d4cb47d6fcbc213bd7f588a1', 19, '2020-09-20 10:42:35'),
(37, 'Twitter Video Views', '1871', 1, 250, 11, 'https://www.smmglobal.net/api/v2', 'b19d82c660c3e7b758b117ccf263398d', 20, '2020-09-20 10:43:54'),
(38, 'Twitter Video Views', '1871', 2, 500, 12, 'https://sosyalmedyam.com.tr/api/v2', '803c842ab5fa5d179c07d5fd490da5fb', 20, '2020-09-20 10:44:16'),
(39, 'Twitter Video Views', '1871', 2, 1000, 11, 'https://www.smmglobal.net/api/v2', 'b19d82c660c3e7b758b117ccf263398d', 22, '2020-09-20 10:44:45'),
(40, 'Twitter Retweets', '738', 2, 250, 12, 'https://sosyalmedyam.com.tr/api/v2', '803c842ab5fa5d179c07d5fd490da5fb', 21, '2020-09-20 10:46:02'),
(41, 'Twitter Retweets', '738', 3, 500, 12, 'https://sosyalmedyam.com.tr/api/v2', '803c842ab5fa5d179c07d5fd490da5fb', 12, '2020-09-20 10:46:27'),
(42, 'Twitter Retweets', '738', 6, 1000, 12, 'https://sosyalmedyam.com.tr/api/v2', '803c842ab5fa5d179c07d5fd490da5fb', 21, '2020-09-20 10:46:44'),
(43, 'Twitter Followers', '2221', 2, 250, 13, 'https://smm-heaven.net/api/v2', '6cc12e14d4cb47d6fcbc213bd7f588a1', 22, '2020-09-20 10:58:08'),
(44, 'Twitter Followers', '2221', 4, 500, 13, 'https://smm-heaven.net/api/v2', '6cc12e14d4cb47d6fcbc213bd7f588a1', 22, '2020-09-20 10:58:36'),
(45, 'Twitter Followers', '221', 7, 1000, 13, 'https://smm-heaven.net/api/v2', '6cc12e14d4cb47d6fcbc213bd7f588a1', 22, '2020-09-20 10:58:55'),
(46, 'Youtube Dislike', '755', 6, 250, 12, 'https://sosyalmedyam.com.tr/api/v2', '803c842ab5fa5d179c07d5fd490da5fb', 23, '2020-09-20 11:00:53'),
(47, 'Youtube Dislike', '755', 11, 500, 12, 'https://sosyalmedyam.com.tr/api/v2', '803c842ab5fa5d179c07d5fd490da5fb', 23, '2020-09-20 11:01:18'),
(48, 'Youtube Dislike', '755', 22, 1000, 12, 'https://sosyalmedyam.com.tr/api/v2', '803c842ab5fa5d179c07d5fd490da5fb', 23, '2020-09-20 11:01:53'),
(49, 'Youtube Like', '754', 1, 250, 12, 'https://sosyalmedyam.com.tr/api/v2', '803c842ab5fa5d179c07d5fd490da5fb', 24, '2020-09-20 11:03:00'),
(50, 'Youtube Like', '754', 2, 500, 12, 'https://sosyalmedyam.com.tr/api/v2', '803c842ab5fa5d179c07d5fd490da5fb', 24, '2020-09-20 11:03:22'),
(51, 'Youtube Like', '754', 3, 1000, 12, 'https://sosyalmedyam.com.tr/api/v2', '803c842ab5fa5d179c07d5fd490da5fb', 24, '2020-09-20 11:03:36'),
(52, 'Youtube Subscriber', '1839', 4, 250, 11, 'https://www.smmglobal.net/api/v2', 'b19d82c660c3e7b758b117ccf263398d', 25, '2020-09-20 11:04:29'),
(53, 'Youtube Subscriber', '1839', 8, 500, 11, 'https://www.smmglobal.net/api/v2', 'b19d82c660c3e7b758b117ccf263398d', 25, '2020-09-20 11:04:48'),
(54, 'Youtube Subscriber', '1839', 15, 1000, 11, 'https://www.smmglobal.net/api/v2', 'b19d82c660c3e7b758b117ccf263398d', 25, '2020-09-20 11:05:24'),
(55, 'SoundCloud Likes', '781', 3, 1000, 12, 'https://sosyalmedyam.com.tr/api/v2', '803c842ab5fa5d179c07d5fd490da5fb', 26, '2020-09-20 11:07:00'),
(56, 'SoundCloud Likes', '781', 1, 250, 12, 'https://sosyalmedyam.com.tr/api/v2', '803c842ab5fa5d179c07d5fd490da5fb', 26, '2020-09-20 11:07:25'),
(57, 'SoundCloud Likes', '781', 2, 750, 12, 'https://sosyalmedyam.com.tr/api/v2', '803c842ab5fa5d179c07d5fd490da5fb', 26, '2020-09-20 11:07:57'),
(58, 'SoundCloud Relaxation', '783', 1, 250, 12, 'https://sosyalmedyam.com.tr/api/v2', '803c842ab5fa5d179c07d5fd490da5fb', 27, '2020-09-20 11:09:56'),
(59, 'SoundCloud Relaxation', '783', 2, 1000, 12, 'https://sosyalmedyam.com.tr/api/v2', '803c842ab5fa5d179c07d5fd490da5fb', 27, '2020-09-20 11:09:56'),
(60, 'SoundCloud Followers', '780', 1, 250, 12, 'https://sosyalmedyam.com.tr/api/v2', '803c842ab5fa5d179c07d5fd490da5fb', 28, '2020-09-20 11:11:22'),
(61, 'SoundCloud Followers', '780', 3, 1000, 12, 'https://sosyalmedyam.com.tr/api/v2', '803c842ab5fa5d179c07d5fd490da5fb', 28, '2020-09-20 11:11:22'),
(62, 'Twitch Followers', '1907', 0, 250, 11, 'https://www.smmglobal.net/api/v2', 'b19d82c660c3e7b758b117ccf263398d', 29, '2020-09-21 10:42:54'),
(63, 'Twitch Followers', '1907', 0, 500, 11, 'https://www.smmglobal.net/api/v2', 'b19d82c660c3e7b758b117ccf263398d', 29, '2020-09-21 10:44:14'),
(64, 'Twitch Followers', '1907', 3, 1000, 11, 'https://www.smmglobal.net/api/v2', 'b19d82c660c3e7b758b117ccf263398d', 29, '2020-09-21 10:44:14'),
(65, 'Twitch Followers', '1907', 5, 2000, 11, 'https://www.smmglobal.net/api/v2', 'b19d82c660c3e7b758b117ccf263398d', 29, '2020-09-21 10:44:14'),
(66, 'Twitch Video Views', '1909', 1, 250, 11, 'https://www.smmglobal.net/api/v2', 'b19d82c660c3e7b758b117ccf263398d', 30, '2020-09-21 10:47:21'),
(67, 'Twitch Video Views', '1909', 2, 750, 11, 'https://www.smmglobal.net/api/v2', 'b19d82c660c3e7b758b117ccf263398d', 30, '2020-09-21 10:47:21'),
(68, 'Twitch Video Views', '1909', 3, 1250, 11, 'https://www.smmglobal.net/api/v2', 'b19d82c660c3e7b758b117ccf263398d', 30, '2020-09-21 10:47:21'),
(69, 'Spotify Followers', '1711', 1, 1000, 11, 'https://www.smmglobal.net/api/v2', 'b19d82c660c3e7b758b117ccf263398d', 31, '2020-09-21 10:50:39'),
(70, 'Spotify Followers', '1711', 2, 2100, 11, 'https://www.smmglobal.net/api/v2', 'b19d82c660c3e7b758b117ccf263398d', 31, '2020-09-21 10:50:39'),
(71, 'Spotify Followers', '1711', 3, 3300, 11, 'https://www.smmglobal.net/api/v2', 'b19d82c660c3e7b758b117ccf263398d', 31, '2020-09-21 10:50:39'),
(72, 'Spotify Playlist Followers', '1712', 1, 500, 11, 'https://www.smmglobal.net/api/v2', 'b19d82c660c3e7b758b117ccf263398d', 32, '2020-09-21 10:53:29'),
(73, 'Spotify Playlist Followers', '1712', 5, 2000, 11, 'https://www.smmglobal.net/api/v2', 'b19d82c660c3e7b758b117ccf263398d', 32, '2020-09-21 10:53:29'),
(74, 'Spotify Relaxation', '1922', 4, 1000, 11, 'https://www.smmglobal.net/api/v2', 'b19d82c660c3e7b758b117ccf263398d', 33, '2020-09-21 10:56:27'),
(75, 'Spotify Relaxation', '1922', 8, 2500, 11, 'https://www.smmglobal.net/api/v2', 'b19d82c660c3e7b758b117ccf263398d', 33, '2020-09-21 10:56:27'),
(76, 'Spotify Relaxation', '1922', 14, 3500, 11, 'https://www.smmglobal.net/api/v2', 'b19d82c660c3e7b758b117ccf263398d', 33, '2020-09-21 10:56:27'),
(77, 'Spotify Search Plays', '777', 1, 1000, 12, 'https://sosyalmedyam.com.tr/api/v2', '803c842ab5fa5d179c07d5fd490da5fb', 34, '2020-09-21 10:59:10'),
(78, 'Spotify Search Plays', '777', 3, 2000, 12, 'https://sosyalmedyam.com.tr/api/v2', '803c842ab5fa5d179c07d5fd490da5fb', 34, '2020-09-21 10:59:10'),
(79, 'Spotify Search Plays', '777', 5, 4000, 12, 'https://sosyalmedyam.com.tr/api/v2', '803c842ab5fa5d179c07d5fd490da5fb', 34, '2020-09-21 10:59:10'),
(80, 'TikTok Followers', '1898', 4, 1000, 11, 'https://www.smmglobal.net/api/v2', 'b19d82c660c3e7b758b117ccf263398d', 35, '2020-09-21 11:03:17'),
(81, 'TikTok Followers', '1898', 7, 2000, 11, 'https://www.smmglobal.net/api/v2', 'b19d82c660c3e7b758b117ccf263398d', 35, '2020-09-21 11:03:17'),
(82, 'TikTok Followers', '1898', 13, 3000, 11, 'https://www.smmglobal.net/api/v2', 'b19d82c660c3e7b758b117ccf263398d', 35, '2020-09-21 11:03:17'),
(83, 'TikTok Likes', '1899', 1, 250, 11, 'https://www.smmglobal.net/api/v2', 'b19d82c660c3e7b758b117ccf263398d', 36, '2020-09-21 11:04:53'),
(84, 'TikTok Likes', '1899', 2, 500, 11, 'https://www.smmglobal.net/api/v2', 'b19d82c660c3e7b758b117ccf263398d', 36, '2020-09-21 11:04:53'),
(85, 'TikTok Likes', '1899', 3, 1050, 11, 'https://www.smmglobal.net/api/v2', 'b19d82c660c3e7b758b117ccf263398d', 36, '2020-09-21 11:04:53'),
(86, 'TikTok Views', '1701', 3, 10000, 11, 'https://www.smmglobal.net/api/v2', 'b19d82c660c3e7b758b117ccf263398d', 37, '2020-09-21 11:07:30'),
(87, 'TikTok Views', '1701', 6, 30052, 11, 'https://www.smmglobal.net/api/v2', 'b19d82c660c3e7b758b117ccf263398d', 37, '2020-09-21 11:07:30'),
(88, 'TikTok Views', '1701', 6, 50000, 11, 'https://www.smmglobal.net/api/v2', 'b19d82c660c3e7b758b117ccf263398d', 37, '2020-09-21 11:07:31'),
(89, 'Special Keyword | Google', '787', 3, 1000, 12, 'https://sosyalmedyam.com.tr/api/v2', '803c842ab5fa5d179c07d5fd490da5fb', 38, '2020-09-21 12:09:04'),
(90, 'Organic Traffic on Google', '788', 3, 1000, 12, 'https://sosyalmedyam.com.tr/api/v2', '803c842ab5fa5d179c07d5fd490da5fb', 38, '2020-09-21 12:09:04'),
(91, 'Organic Traffic on Yandex', '789', 3, 1000, 12, 'https://sosyalmedyam.com.tr/api/v2', '803c842ab5fa5d179c07d5fd490da5fb', 38, '2020-09-21 12:09:04'),
(92, 'Organic Traffic on Youtube', '790', 3, 1000, 12, 'https://sosyalmedyam.com.tr/api/v2', '803c842ab5fa5d179c07d5fd490da5fb', 38, '2020-09-21 12:10:13'),
(93, 'USA Ratings and Reviews', '3065', 15, 10, 13, 'https://smm-heaven.net/api/v2', '6cc12e14d4cb47d6fcbc213bd7f588a1', 39, '2020-09-21 12:14:43'),
(94, 'USA Ratings and Reviews', '3065', 75, 50, 13, 'https://smm-heaven.net/api/v2', '6cc12e14d4cb47d6fcbc213bd7f588a1', 39, '2020-09-21 12:14:43'),
(95, 'USA Ratings and Reviews', '3065', 140, 100, 13, 'https://smm-heaven.net/api/v2', '6cc12e14d4cb47d6fcbc213bd7f588a1', 39, '2020-09-21 12:14:44'),
(96, 'USA Ratings and Reviews', '3065', 1300, 1000, 13, 'https://smm-heaven.net/api/v2', '6cc12e14d4cb47d6fcbc213bd7f588a1', 39, '2020-09-21 12:16:09'),
(97, 'iOS Installs', '3057', 18, 50, 13, 'https://smm-heaven.net/api/v2', '6cc12e14d4cb47d6fcbc213bd7f588a1', 40, '2020-09-21 12:17:07'),
(98, 'iOS Installs', '3057', 35, 100, 13, 'https://smm-heaven.net/api/v2', '6cc12e14d4cb47d6fcbc213bd7f588a1', 40, '2020-09-21 12:17:07'),
(99, 'iOS Installs', '3057', 175, 500, 13, 'https://smm-heaven.net/api/v2', '6cc12e14d4cb47d6fcbc213bd7f588a1', 40, '2020-09-21 12:17:07'),
(100, 'iOS Installs', '3057', 350, 1000, 13, 'https://smm-heaven.net/api/v2', '6cc12e14d4cb47d6fcbc213bd7f588a1', 40, '2020-09-21 12:17:07'),
(101, 'Android Installs', '1832', 1, 10, 11, 'https://www.smmglobal.net/api/v2', 'b19d82c660c3e7b758b117ccf263398d', 41, '2020-09-21 12:19:23'),
(102, 'Android Installs', '1832', 10, 100, 11, 'https://www.smmglobal.net/api/v2', 'b19d82c660c3e7b758b117ccf263398d', 41, '2020-09-21 12:19:23'),
(103, 'Android Installs', '1832', 23, 250, 11, 'https://www.smmglobal.net/api/v2', 'b19d82c660c3e7b758b117ccf263398d', 41, '2020-09-21 12:19:23'),
(104, 'Android Installs', '1832', 90, 1000, 11, 'https://www.smmglobal.net/api/v2', 'b19d82c660c3e7b758b117ccf263398d', 41, '2020-09-21 12:19:23'),
(105, 'Android Rating and Reviews', '1834', 1, 10, 11, 'https://www.smmglobal.net/api/v2', 'b19d82c660c3e7b758b117ccf263398d', 42, '2020-09-21 12:23:13'),
(106, 'Android Rating and Reviews', '1834', 10, 100, 11, 'https://www.smmglobal.net/api/v2', 'b19d82c660c3e7b758b117ccf263398d', 42, '2020-09-21 12:23:13'),
(107, 'Android Rating and Reviews', '1834', 20, 250, 11, 'https://www.smmglobal.net/api/v2', 'b19d82c660c3e7b758b117ccf263398d', 42, '2020-09-21 12:23:14'),
(108, 'Android Rating and Reviews', '1834', 40, 500, 11, 'https://www.smmglobal.net/api/v2', 'b19d82c660c3e7b758b117ccf263398d', 42, '2020-09-21 12:23:14'),
(109, 'Android Rating and Reviews', '1834', 80, 1000, 11, 'https://www.smmglobal.net/api/v2', 'b19d82c660c3e7b758b117ccf263398d', 42, '2020-09-21 12:23:14');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `socialmedia`
--

CREATE TABLE `socialmedia` (
  `socialmedia_id` int(11) NOT NULL,
  `socialmedia_name` varchar(500) NOT NULL,
  `socialmedia_url` varchar(500) NOT NULL,
  `socialmedia_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Tablo döküm verisi `socialmedia`
--

INSERT INTO `socialmedia` (`socialmedia_id`, `socialmedia_name`, `socialmedia_url`, `socialmedia_date`) VALUES
(37, 'hello', 'https://birkanmedia.com/smmobile/admin/assets/socialmedia/instagram-logos-png-images-free-download-2.png', '2020-09-09 16:50:54'),
(39, 'hi', 'https://birkanmedia.com/smmobile/admin/assets/socialmedia/fb_icon_325x325.png', '2020-09-19 11:03:51'),
(40, 'good', 'https://birkanmedia.com/smmobile/admin/assets/socialmedia/e7b78b7e4664caa8e541da27ef1f0c3e.png', '2020-09-19 11:04:30'),
(41, 'Youtube', 'https://birkanmedia.com/smmobile/admin/assets/socialmedia/yt_1200.png', '2020-09-19 11:05:34'),
(42, 'SoundCloud', 'https://birkanmedia.com/smmobile/admin/assets/socialmedia/png-transparent-soundcloud-logo-music-drawing-streaming-media-others-miscellaneous-orange-logo.png', '2020-09-19 11:06:12'),
(43, 'Twitch', 'https://birkanmedia.com/smmobile/admin/assets/socialmedia/K-ZDJZli_400x400.jpg', '2020-09-19 11:07:26'),
(44, 'Spotify', 'https://birkanmedia.com/smmobile/admin/assets/socialmedia/kTJdUF7D_400x400.jpg', '2020-09-19 11:08:56'),
(46, 'TikTok', 'https://birkanmedia.com/smmobile/admin/assets/socialmedia/unnamed (1).png', '2020-09-19 11:10:10'),
(47, 'Web Site Organic Traffic', 'https://birkanmedia.com/smmobile/admin/assets/socialmedia/44386.png', '2020-09-19 11:11:21'),
(48, 'iOS', 'https://birkanmedia.com/smmobile/admin/assets/socialmedia/5315_-_Apple-512.png', '2020-09-19 11:17:09'),
(49, 'Android', 'https://birkanmedia.com/smmobile/admin/assets/socialmedia/android-logo-220819.png', '2020-09-19 11:18:32'),
(54, 'facebook', 'assets/socialmedia/facebook.png', '2020-10-29 21:22:25');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `user_username` varchar(225) NOT NULL,
  `user_password` varchar(225) NOT NULL,
  `user_name` varchar(225) NOT NULL,
  `user_surname` varchar(225) NOT NULL,
  `user_email` varchar(225) NOT NULL,
  `user_kredi` int(11) NOT NULL,
  `user_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dökümü yapılmış tablolar için indeksler
--

--
-- Tablo için indeksler `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`admin_id`);

--
-- Tablo için indeksler `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`category_id`),
  ADD KEY `socialmedia_id` (`socialmedia_id`);

--
-- Tablo için indeksler `languages`
--
ALTER TABLE `languages`
  ADD PRIMARY KEY (`language_id`);

--
-- Tablo için indeksler `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `provider`
--
ALTER TABLE `provider`
  ADD PRIMARY KEY (`provider_id`);

--
-- Tablo için indeksler `service`
--
ALTER TABLE `service`
  ADD PRIMARY KEY (`api_service_id`),
  ADD KEY `provider_id` (`provider_id`),
  ADD KEY `category_id` (`category_id`);

--
-- Tablo için indeksler `socialmedia`
--
ALTER TABLE `socialmedia`
  ADD PRIMARY KEY (`socialmedia_id`);

--
-- Tablo için indeksler `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`);

--
-- Dökümü yapılmış tablolar için AUTO_INCREMENT değeri
--

--
-- Tablo için AUTO_INCREMENT değeri `admins`
--
ALTER TABLE `admins`
  MODIFY `admin_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Tablo için AUTO_INCREMENT değeri `category`
--
ALTER TABLE `category`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- Tablo için AUTO_INCREMENT değeri `languages`
--
ALTER TABLE `languages`
  MODIFY `language_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- Tablo için AUTO_INCREMENT değeri `payments`
--
ALTER TABLE `payments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Tablo için AUTO_INCREMENT değeri `provider`
--
ALTER TABLE `provider`
  MODIFY `provider_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- Tablo için AUTO_INCREMENT değeri `service`
--
ALTER TABLE `service`
  MODIFY `api_service_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=110;

--
-- Tablo için AUTO_INCREMENT değeri `socialmedia`
--
ALTER TABLE `socialmedia`
  MODIFY `socialmedia_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=55;

--
-- Tablo için AUTO_INCREMENT değeri `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- Dökümü yapılmış tablolar için kısıtlamalar
--

--
-- Tablo kısıtlamaları `category`
--
ALTER TABLE `category`
  ADD CONSTRAINT `category_ibfk_1` FOREIGN KEY (`socialmedia_id`) REFERENCES `socialmedia` (`socialmedia_id`);

--
-- Tablo kısıtlamaları `service`
--
ALTER TABLE `service`
  ADD CONSTRAINT `service_ibfk_1` FOREIGN KEY (`provider_id`) REFERENCES `provider` (`provider_id`),
  ADD CONSTRAINT `service_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
