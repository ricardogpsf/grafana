import { css } from '@emotion/css';
import { useState } from 'react';

import { GrafanaTheme2, renderMarkdown } from '@grafana/data';
import { config, useChromeHeaderHeight } from '@grafana/runtime';
import { useStyles2 } from '@grafana/ui';

export function AnnouncementBanner() {
  const text = config.announcementBannerText;
  const headerHeight = useChromeHeaderHeight();
  const styles = useStyles2(getStyles, headerHeight);
  const [dismissed, setDismissed] = useState(false);

  if (!text || dismissed) {
    return null;
  }

  return (
    <div className={styles.banner} role="banner">
      <span dangerouslySetInnerHTML={{ __html: renderMarkdown(text) }} />
      <button className={styles.closeButton} onClick={() => setDismissed(true)} aria-label="Close announcement">
        ✕
      </button>
    </div>
  );
}

const getStyles = (theme: GrafanaTheme2, headerHeight: number) => ({
  banner: css({
    background: theme.colors.warning.main,
    color: theme.colors.warning.contrastText,
    textAlign: 'center',
    padding: theme.spacing(1, 2),
    fontWeight: theme.typography.fontWeightMedium,
    fontSize: theme.typography.bodySmall.fontSize,
    position: 'sticky',
    top: headerHeight,
    zIndex: theme.zIndex.navbarFixed,
    display: 'flex',
    alignItems: 'center',
    justifyContent: 'center',
    gap: theme.spacing(1),
  }),
  closeButton: css({
    background: 'none',
    border: 'none',
    color: 'inherit',
    cursor: 'pointer',
    fontSize: theme.typography.bodySmall.fontSize,
    padding: theme.spacing(0, 0.5),
    lineHeight: 1,
    opacity: 0.7,
    '&:hover': {
      opacity: 1,
    },
  }),
});
