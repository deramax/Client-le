import re

from .models import AuditLogEntry


def detect_device(user_agent: str) -> str:
    ua = user_agent or ""
    if re.search(r"iPad|Tablet", ua, re.I) or (
        re.search(r"Android", ua, re.I) and not re.search(r"Mobile", ua, re.I)
    ):
        return "Tablet"
    if re.search(r"Mobi|Android|iPhone|iPod|Windows Phone", ua, re.I):
        return "Mobile"
    return "Desktop"


def client_ip(request):
    fwd = request.META.get("HTTP_X_FORWARDED_FOR")
    if fwd:
        return fwd.split(",")[0].strip()
    return request.META.get("REMOTE_ADDR")


def log_audit(request, action, login=None):
    """Append a security-journal entry (legacy logAudit)."""
    AuditLogEntry.objects.create(
        action=action,
        login=login or getattr(getattr(request, "user", None), "login", "—") or "—",
        device=detect_device(request.META.get("HTTP_USER_AGENT", "")),
        ip=client_ip(request),
    )
    # cap the journal at 500 rows like the legacy app
    excess = AuditLogEntry.objects.count() - 500
    if excess > 0:
        old = AuditLogEntry.objects.order_by("ts").values_list("id", flat=True)[:excess]
        AuditLogEntry.objects.filter(id__in=list(old)).delete()
