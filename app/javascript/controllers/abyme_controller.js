import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ['template', 'associations'];

  connect() {
    console.log('Abyme Connect');
  }

  get position() {
    return this.data.get('position') === 'before' ? 'beforeend' : 'afterbegin';
  }

  add_association(event) {
    event.preventDefault();

    let html = this.templateTarget.innerHTML.replace(
      /NEW_RECORD/g,
      new Date().getTime()
    );

    if (html.match(/<template[\s\S]+<\/template>/)) {
      const template = html
        .match(/<template[\s\S]+<\/template>/)[0]
        .replace(/(\[\d+\])(\[[^\[\]]+\]"){1}/g, `[NEW_RECORD]$2`);

      html = html.replace(/<template[\s\S]+<\/template>/g, template);
    }

    this.associationsTarget.insertAdjacentHTML(this.position, html);
  }

  remove_association(event) {
    event.preventDefault();

    let wrapper = event.target.closest('.abyme--fields');
    wrapper.querySelector("input[name*='_destroy']").value = 1;
    wrapper.style.display = 'none';
  }
}

// const regexp = new RegExp(/(\[.+\]\[)(NEW_RECORD|(\d{12,}))(\]\[.+\]")/g);
// const regexp = new RegExp(
//   /(name=".+)(\[)([(^\[|NEW_RECORD)]+)(\]\[[^\[]+\])"/
// );

// console.log(this.templateTarget.innerHTML.replace(regexp, `$1$2HELLO$4`));
