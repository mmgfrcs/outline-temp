import React from 'react';
import { observer } from 'mobx-react';
import moment from 'moment';

import { Link } from 'react-router';
import PublishingInfo from 'components/PublishingInfo';

import styles from './Document.scss';

const DocumentHtml = observer((props) => {
  return (
    <div
      className={ styles.document }
      dangerouslySetInnerHTML={{ __html: props.html }}
      { ...props }
    />
  );
});

@observer
class Document extends React.Component {
  static propTypes = {
    document: React.PropTypes.object.isRequired,
  }

  render() {
    return (
      <div className={ styles.container }>
        <PublishingInfo
          document={ this.props.document }
          name={ this.props.document.user.name }
          createdAt={ this.props.document.createdAt }
          updatedAt={ this.props.document.updatedAt }
        />
        <DocumentHtml html={ this.props.document.html } />
      </div>
    );
  }
};

export default Document;
export {
  DocumentHtml
};
