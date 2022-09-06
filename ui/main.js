const progress = () => {
    return {
        init () {
            window.addEventListener('message', (event) => {	            
                var item = event.data;

                if (item !== undefined && item.type === 'ui') {		                
                    const onePercent = item.time * 0.01
                    this.show = true; this.action = item.text;

                    const updateProgress = setInterval(() => { 
                        this.percent += 1;

                        if (this.percent >= 100) {
                            clearInterval(updateProgress); $.post('https://kk-taskbar/actionDone', JSON.stringify({}));

                            this.show = false; this.percent = 0
                        }
                    }, onePercent);
                } else if (item.type == 'show') {
                    this.allHidden = false
                } else if (item.type == 'hide') { 
                    this.allHidden = true
                } else if (item.type == 'cancel') {
                    this.percent = 100
                }
            });
        },

        circumference: 30 * 2 * Math.PI,
        percent: 0,
        action: 'TEGEVUS',
        show: false,
        allHidden: false
    }
}