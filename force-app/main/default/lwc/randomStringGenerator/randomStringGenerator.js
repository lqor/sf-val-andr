import { LightningElement} from 'lwc';
import getCallout from '@salesforce/apex/RandomStringCallout.getCallout';
import createAccount from '@salesforce/apex/CreateAccountFromRandomString.createAccount';

export default class RandomStringGenerator extends LightningElement {
    generatedString;
    showString;
    succeed;
    accountLink;

    handleClickRandomize() {
        getCallout({}).then(response => {
            this.showString = true;
            this.succeed = false;
            this.generatedString = response;
        })
    }

    handleClickSave() { 
        createAccount({random: this.generatedString}).then((id) => {
            this.showString = false;
            this.succeed = true;
            this.accountLink = 'https://curious-unicorn-nzjuyg-dev-ed.lightning.force.com/lightning/r/Account/' + id + '/view';
        })
    }
}