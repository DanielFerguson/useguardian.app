import Head from 'next/head'

import Hero from './components/hero';
import Features from './components/features';
// import Partners from './components/partners';
import Story from './components/story';
import CallToAction from './components/calltoaction';
// import FAQs from './components/faqs';
import Footer from './components/footer';

export default function Home() {
  return (
    <>
      <Head>
        <title>Privacy-first instant contact tracing | Guardian</title>
        <meta name="description" content="A privacy-first cross-platform contact-tracing application, automating near-immediate results and helping to prevent further COVID-19 outbreaks." />
        <meta name="keywords" content="privacy,privacy-first,cross-platform,contact-tracing,contact,tracing,application,automate,automating,prevent,COVID-19,outbreaks,lockdown,lockdowns" />
        <meta property="og:type" content="website" />
        <meta property="og:url" content="https://useguardian.app/" />
        <meta property="og:title" content="Privacy-first instant contact tracing | Guardian" />
        <meta property="og:description" content="A privacy-first cross-platform contact-tracing application, automating near-immediate results and helping to prevent further COVID-19 outbreaks." />
        <meta property="og:image" content="/guardian.jpg" />
        <meta property="twitter:card" content="summary_large_image" />
        <meta property="twitter:url" content="https://useguardian.app/" />
        <meta property="twitter:title" content="Privacy-first instant contact tracing | Guardian" />
        <meta property="twitter:description" content="A privacy-first cross-platform contact-tracing application, automating near-immediate results and helping to prevent further COVID-19 outbreaks." />
        <meta property="twitter:image" content="/guardian.jpg" />
      </Head>
      <main className="flex flex-col gap-24">
        <Hero />
        <Features />
        {/* <Partners /> */}
        <Story />
        <CallToAction />
        {/* <FAQs /> */}
        <Footer />
      </main>
    </>
  )
}
