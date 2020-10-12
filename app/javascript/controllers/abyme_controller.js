import { Controller } from 'stimulus';

export class AbymeController extends Controller {
  static targets = ['template', 'associations'];

  connect() {
    console.log('Abyme Connect');
  }

  get position() {
    return this.associationsTarget.dataset.abymePosition === 'end' ? 'beforeend' : 'afterbegin';
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
        .replace(/(\[\d{12,}\])(\[[^\[\]]+\]"){1}/g, `[NEW_RECORD]$2`);

      html = html.replace(/<template[\s\S]+<\/template>/g, template);
    }

    this.dispatchEvent('abyme:before-add')
    this.associationsTarget.insertAdjacentHTML(this.position, html);
    this.dispatchEvent('abyme:after-add')
  }

  remove_association(event) {
    event.preventDefault();

    this.dispatchEvent('abyme:before-remove')
    let wrapper = event.target.closest('.abyme--fields');
    wrapper.querySelector("input[name*='_destroy']").value = 1;
    wrapper.style.display = 'none';
    this.dispatchEvent('abyme:before-after')
  }

  // dispatchEvent(type) {
  //   const event = new CustomEvent(type, { detail: this })
  //   this.element.dispatchEvent(event)

  //   if (type === 'abyme:before-add') {
  //     if (this.beforeAdd) this.beforeAdd(event)
  //   } else if (type === 'abyme:after-add') {
  //     if (this.afterAdd) this.afterAdd(event)
  //   } else if (type === 'abyme:before-remove') {
  //     if (this.beforeRemove) this.beforeRemove(event)
  //   } else if (type === 'abyme:after-remove') {
  //     if (this.afterRemove) this.afterRemove(event)
  //   }
  // }
}
