sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'invoices/test/integration/FirstJourney',
		'invoices/test/integration/pages/InvoiceList',
		'invoices/test/integration/pages/InvoiceObjectPage',
		'invoices/test/integration/pages/InvoiceItemObjectPage'
    ],
    function(JourneyRunner, opaJourney, InvoiceList, InvoiceObjectPage, InvoiceItemObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('invoices') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheInvoiceList: InvoiceList,
					onTheInvoiceObjectPage: InvoiceObjectPage,
					onTheInvoiceItemObjectPage: InvoiceItemObjectPage
                }
            },
            opaJourney.run
        );
    }
);