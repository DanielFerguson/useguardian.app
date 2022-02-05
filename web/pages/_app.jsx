import { useEffect } from 'react';
import { useRouter } from 'next/router';
import * as Fathom from 'fathom-client';

import 'tailwindcss/tailwind.css'
import '../styles/globals.css'
import '../styles/device.min.css';

function MyApp({ Component, pageProps }) {
    const router = useRouter();

    useEffect(() => {
        Fathom.load('EUKRDHBL', {
            includedDomains: ['useguardian.app', 'www.useguardian.app'],
        });

        function onRouteChangeComplete() {
            Fathom.trackPageview();
        }

        router.events.on('routeChangeComplete', onRouteChangeComplete);

        return () => {
            router.events.off('routeChangeComplete', onRouteChangeComplete);
        };
    }, []);

    return <Component {...pageProps}
    />;
}

export default MyApp;